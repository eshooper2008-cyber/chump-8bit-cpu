module PROGRAM_EEPROM (
    input wire [7:0] ADDRESS,
    output reg [11:0] DATA_OUT
);

    always @(*) begin
        case(ADDRESS)
            // Example program: Counter
            8'h00: DATA_OUT = 12'b1000_00000000;  // READ 0 - point the address register at RAM[0]
            8'h01: DATA_OUT = 12'b0000_00000000;  // LOAD 0 - A = 0
            8'h02: DATA_OUT = 12'b0010_00000001;  // ADD 1 - A = A + 1
            8'h03: DATA_OUT = 12'b0110_00000000;  // STORETO 0 - RAM[0] = A
            8'h04: DATA_OUT = 12'b1100_00000010;  // GOTO 2 - repeat

            default: DATA_OUT = 12'h000;
        endcase
    end

endmodule
