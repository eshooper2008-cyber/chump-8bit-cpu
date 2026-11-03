module PROGRAM_EEPROM (
    input wire [7:0] ADDRESS,
    output reg [11:0] DATA_OUT
);

    always @(*) begin
        case(ADDRESS)
            // Example program: Running light
            8'h00: DATA_OUT = 12'b0000_00000001;  // LOAD 1 - A = 00000001
            8'h01: DATA_OUT = 12'b0110_00000000;  // STORETO 0 - RAM[0] = A
            8'h02: DATA_OUT = 12'b1000_00000000;  // READ 0 - point at RAM[0] (also lets the store land)
            8'h03: DATA_OUT = 12'b0011_00000000;  // ADD it - A = A + RAM[0] = A * 2, the light moves left
            8'h04: DATA_OUT = 12'b1110_00000000;  // IFZERO 0 - 128 + 128 = 256 doesn't fit in 8 bits -> 0, so restart
            8'h05: DATA_OUT = 12'b1100_00000001;  // GOTO 1 - move the light again

            default: DATA_OUT = 12'h000;
        endcase
    end

endmodule
