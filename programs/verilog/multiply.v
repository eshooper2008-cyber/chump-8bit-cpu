module PROGRAM_EEPROM (
    input wire [7:0] ADDRESS,
    output reg [11:0] DATA_OUT
);

    always @(*) begin
        case(ADDRESS)
            // Example program: Multiply (6 x 7)
            8'h00: DATA_OUT = 12'b0000_00000111;  // LOAD 7 - A = 7
            8'h01: DATA_OUT = 12'b0110_00000001;  // STORETO 1 - count = 7
            8'h02: DATA_OUT = 12'b1000_00000000;  // READ 0 - point at result
            8'h03: DATA_OUT = 12'b0001_00000000;  // LOAD it - A = result
            8'h04: DATA_OUT = 12'b0010_00000110;  // ADD 6 - A = result + 6
            8'h05: DATA_OUT = 12'b0110_00000000;  // STORETO 0 - result = A
            8'h06: DATA_OUT = 12'b1000_00000001;  // READ 1 - point at count
            8'h07: DATA_OUT = 12'b0001_00000000;  // LOAD it - A = count
            8'h08: DATA_OUT = 12'b0100_00000001;  // SUBTRACT 1 - A = count - 1
            8'h09: DATA_OUT = 12'b0110_00000001;  // STORETO 1 - count = A
            8'h0A: DATA_OUT = 12'b1110_00001100;  // IFZERO 12 - no 6s left? then we're done
            8'h0B: DATA_OUT = 12'b1100_00000010;  // GOTO 2 - add another 6
            8'h0C: DATA_OUT = 12'b1000_00000000;  // READ 0 - point at result
            8'h0D: DATA_OUT = 12'b0001_00000000;  // LOAD it - show the result on the accumulator LEDs
            8'h0E: DATA_OUT = 12'b1100_00001110;  // GOTO 14 - stop here

            default: DATA_OUT = 12'h000;
        endcase
    end

endmodule
