module PROGRAM_EEPROM (
    input wire [7:0] ADDRESS,
    output reg [11:0] DATA_OUT
);

    always @(*) begin
        case(ADDRESS)
            // Example program: Fibonacci
            8'h00: DATA_OUT = 12'b0000_00000001;  // LOAD 1 - A = 1
            8'h01: DATA_OUT = 12'b0110_00000001;  // STORETO 1 - b = 1  (a = RAM[0] starts at 0)
            8'h02: DATA_OUT = 12'b1000_00000000;  // READ 0 - point at a
            8'h03: DATA_OUT = 12'b0001_00000000;  // LOAD it - A = a
            8'h04: DATA_OUT = 12'b1000_00000001;  // READ 1 - point at b
            8'h05: DATA_OUT = 12'b0011_00000000;  // ADD it - A = a + b
            8'h06: DATA_OUT = 12'b0110_00000010;  // STORETO 2 - next = A
            8'h07: DATA_OUT = 12'b1000_00000001;  // READ 1 - point at b
            8'h08: DATA_OUT = 12'b0001_00000000;  // LOAD it - A = b
            8'h09: DATA_OUT = 12'b0110_00000000;  // STORETO 0 - a = b
            8'h0A: DATA_OUT = 12'b1000_00000010;  // READ 2 - point at next
            8'h0B: DATA_OUT = 12'b0001_00000000;  // LOAD it - A = next
            8'h0C: DATA_OUT = 12'b0110_00000001;  // STORETO 1 - b = next
            8'h0D: DATA_OUT = 12'b1100_00000010;  // GOTO 2 - work out the next number

            default: DATA_OUT = 12'h000;
        endcase
    end

endmodule
