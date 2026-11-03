#define WE_PIN 3    // Write Enable pin for EEPROM programming

#define A0_PIN A3   // Address bit 0 (LSB)
#define A1_PIN A2   // Address bit 1
#define A2_PIN A5   // Address bit 2
#define A3_PIN A4   // Address bit 3 (MSB of 4-bit address)
#define A4_PIN 11   // Page select bit 0 - connects to 555 timer for clock input
#define A7_PIN 12   // Page select bit 1 - selects between function sets (Personal/Feinberg)

#define IO0_PIN A1  // Data bit 0 (LSB) - EEPROM I/O pin
#define IO1_PIN A0  // Data bit 1 - EEPROM I/O pin
#define IO2_PIN 13  // Data bit 2 - EEPROM I/O pin
#define IO3_PIN 6   // Data bit 3 - EEPROM I/O pin
#define IO4_PIN 7   // Data bit 4 - EEPROM I/O pin
#define IO5_PIN 8   // Data bit 5 - EEPROM I/O pin
#define IO6_PIN 9   // Data bit 6 - EEPROM I/O pin
#define IO7_PIN 10  // Data bit 7 (MSB) - EEPROM I/O pin

// Standard hexadecimal digit lookup (0-F)
byte LookUpTable[16] = {
  0x77,                         // 0 - Display pattern for digit 0
  0x14,                         // 1 - Display pattern for digit 1
  0xB3,                         // 2 - Display pattern for digit 2
  0xB6,                         // 3 - Display pattern for digit 3
  0xD4,                         // 4 - Display pattern for digit 4
  0xE6,                         // 5 - Display pattern for digit 5
  0xE7,                         // 6 - Display pattern for digit 6
  0x34,                         // 7 - Display pattern for digit 7
  0xFF,                         // 8 - Display pattern for digit 8
  0xFC,                         // 9 - Display pattern for digit 9
  0xFD,                         // A - Display pattern for digit A
  0xCF,                         // B - Display pattern for digit B
  0x63,                         // C - Display pattern for digit C
  0x97,                         // D - Display pattern for digit D
  0xE3,                         // E - Display pattern for digit E
  0xE1                          // F - Display pattern for digit F
};

// Personal display sequence - LEFT digit: 0 6 0 6 0 6 8 1 8 3 8 3 6 C [blank] [blank]
byte PersonalLEFT[16] = {
  0x77,                         // Address 0: Display 0
  0xE7,                         // Address 1: Display 6
  0x77,                         // Address 2: Display 0
  0xE7,                         // Address 3: Display 6
  0x77,                         // Address 4: Display 0
  0xE7,                         // Address 5: Display 6
  0xFF,                         // Address 6: Display 8
  0x14,                         // Address 7: Display 1
  0xFF,                         // Address 8: Display 8
  0xB6,                         // Address 9: Display 3
  0xFF,                         // Address 10: Display 8
  0xB6,                         // Address 11: Display 3
  0xE7,                         // Address 12: Display 6
  0x63,                         // Address 13: Display C
  0x00,                         // Address 14: Blank display
  0x00                          // Address 15: Blank display
};

// Personal display sequence - RIGHT digit: 4 2 2 3 8 4 2 0 3 0 4 0 5 D [blank] [blank]
byte PersonalRIGHT[16] = {
  0xD4,                         // Address 0: Display 4
  0xB3,                         // Address 1: Display 2
  0xB3,                         // Address 2: Display 2
  0xB6,                         // Address 3: Display 3
  0xFF,                         // Address 4: Display 8
  0xD4,                         // Address 5: Display 4
  0xB3,                         // Address 6: Display 2
  0x77,                         // Address 7: Display 0
  0xB6,                         // Address 8: Display 3
  0x77,                         // Address 9: Display 0
  0xD4,                         // Address 10: Display 4
  0x77,                         // Address 11: Display 0
  0xE6,                         // Address 12: Display 5
  0x97,                         // Address 13: Display D
  0x00,                         // Address 14: Blank display
  0x00                          // Address 15: Blank display
};

// Feinberg display sequence - LEFT digit: 8 1 2 6 D [blank] [blank] ...
byte FeinbergLEFT[16] = {
  0xFF,                         // Address 0: Display 8
  0x14,                         // Address 1: Display 1
  0xB3,                         // Address 2: Display 2
  0xE7,                         // Address 3: Display 6
  0x97,                         // Address 4: Display D
  0x00,                         // Address 5: Blank display
  0x00,                         // Address 6: Blank display
  0x00,                         // Address 7: Blank display
  0x00,                         // Address 8: Blank display
  0x00,                         // Address 9: Blank display
  0x00,                         // Address 10: Blank display
  0x00,                         // Address 11: Blank display
  0x00,                         // Address 12: Blank display
  0x00,                         // Address 13: Blank display
  0x00,                         // Address 14: Blank display
  0x00                          // Address 15: Blank display
};

// Feinberg display sequence - RIGHT digit: 2 0 1 2 0 [blank] [blank] ...
byte FeinbergRIGHT[16] = {
  0xB3,                         // Address 0: Display 2
  0x77,                         // Address 1: Display 0
  0x14,                         // Address 2: Display 1
  0xB3,                         // Address 3: Display 2
  0x77,                         // Address 4: Display 0
  0x00,                         // Address 5: Blank display
  0x00,                         // Address 6: Blank display
  0x00,                         // Address 7: Blank display
  0x00,                         // Address 8: Blank display
  0x00,                         // Address 9: Blank display
  0x00,                         // Address 10: Blank display
  0x00,                         // Address 11: Blank display
  0x00,                         // Address 12: Blank display
  0x00,                         // Address 13: Blank display
  0x00,                         // Address 14: Blank display
  0x00                          // Address 15: Blank display
};

void setup() {
  pinMode(A0_PIN, OUTPUT);                          // Set A0 as output for address bit 0
  pinMode(A1_PIN, OUTPUT);                          // Set A1 as output for address bit 1
  pinMode(A2_PIN, OUTPUT);                          // Set A2 as output for address bit 2
  pinMode(A3_PIN, OUTPUT);                          // Set A3 as output for address bit 3
  pinMode(A4_PIN, OUTPUT);                          // Set A4 (pin 11) as output for page select bit 0
  pinMode(A7_PIN, OUTPUT);                          // Set A7 (pin 12) as output for page select bit 1

  pinMode(IO0_PIN, INPUT);                          // Set IO0 as input (data bit 0)
  pinMode(IO1_PIN, INPUT);                          // Set IO1 as input (data bit 1)
  pinMode(IO2_PIN, INPUT);                          // Set IO2 as input (data bit 2)
  pinMode(IO3_PIN, INPUT);                          // Set IO3 as input (data bit 3)
  pinMode(IO4_PIN, INPUT);                          // Set IO4 as input (data bit 4)
  pinMode(IO5_PIN, INPUT);                          // Set IO5 as input (data bit 5)
  pinMode(IO6_PIN, INPUT);                          // Set IO6 as input (data bit 6)
  pinMode(IO7_PIN, INPUT);                          // Set IO7 as input (data bit 7)

  pinMode(WE_PIN, OUTPUT);                          // Set Write Enable as output
  digitalWrite(WE_PIN, HIGH);                       // Disable EEPROM writing (WE inactive = HIGH)

  digitalWrite(A7_PIN, HIGH);                       // Select Personal function set (A7 = HIGH)

  digitalWrite(A4_PIN, LOW);                        // Select page 0 (A4 = LOW, A7 = HIGH)
  for (int address = 0; address < 16; address++) { // Loop through all 16 addresses
    writeEEPROM(address, PersonalRIGHT[address]);   // Write PersonalRIGHT data to EEPROM
    delay(2);                                       // Wait 2ms for EEPROM write cycle to complete
  }

  digitalWrite(A4_PIN, HIGH);                       // Select page 1 (A4 = HIGH, A7 = HIGH)
  for (int address = 0; address < 16; address++) { // Loop through all 16 addresses
    writeEEPROM(address, PersonalLEFT[address]);    // Write PersonalLEFT data to EEPROM
    delay(2);                                       // Wait 2ms for EEPROM write cycle to complete
  }

  digitalWrite(A7_PIN, LOW);                        // Select Feinberg function set (A7 = LOW)

  digitalWrite(A4_PIN, LOW);                        // Select page 2 (A4 = LOW, A7 = LOW)
  for (int address = 0; address < 16; address++) { // Loop through all 16 addresses
    writeEEPROM(address, FeinbergRIGHT[address]);   // Write FeinbergRIGHT data to EEPROM
    delay(2);                                       // Wait 2ms for EEPROM write cycle to complete
  }

  digitalWrite(A4_PIN, HIGH);                       // Select page 3 (A4 = HIGH, A7 = LOW)
  for (int address = 0; address < 16; address++) { // Loop through all 16 addresses
    writeEEPROM(address, FeinbergLEFT[address]);    // Write FeinbergLEFT data to EEPROM
    delay(2);                                       // Wait 2ms for EEPROM write cycle to complete
  }
}

void loop() {
  // Nothing to do - EEPROM programming happens once in setup()
}

void writeEEPROM(int address, byte value) {
  digitalWrite(A0_PIN, (address >> 0) & 1);         // Set address bit 0 (extract bit 0 from address)
  digitalWrite(A1_PIN, (address >> 1) & 1);         // Set address bit 1 (extract bit 1 from address)
  digitalWrite(A2_PIN, (address >> 2) & 1);         // Set address bit 2 (extract bit 2 from address)
  digitalWrite(A3_PIN, (address >> 3) & 1);         // Set address bit 3 (extract bit 3 from address)

  digitalWrite(IO0_PIN, value & 0x01);              // Set data bit 0 (extract bit 0 from value)
  digitalWrite(IO1_PIN, (value >> 1) & 0x01);       // Set data bit 1 (extract bit 1 from value)
  digitalWrite(IO2_PIN, (value >> 2) & 0x01);       // Set data bit 2 (extract bit 2 from value)
  digitalWrite(IO3_PIN, (value >> 3) & 0x01);       // Set data bit 3 (extract bit 3 from value)
  digitalWrite(IO4_PIN, (value >> 4) & 0x01);       // Set data bit 4 (extract bit 4 from value)
  digitalWrite(IO5_PIN, (value >> 5) & 0x01);       // Set data bit 5 (extract bit 5 from value)
  digitalWrite(IO6_PIN, (value >> 6) & 0x01);       // Set data bit 6 (extract bit 6 from value)
  digitalWrite(IO7_PIN, (value >> 7) & 0x01);       // Set data bit 7 (extract bit 7 from value)

  digitalWrite(WE_PIN, LOW);                        // Enable EEPROM writing (WE active = LOW)
  delayMicroseconds(1);                             // Wait 1µs for the write pulse width
  digitalWrite(WE_PIN, HIGH);                       // Disable EEPROM writing (WE inactive = HIGH)
}
