module PROGRAM_EEPROM (
    input wire [7:0] ADDRESS,
    output reg [11:0] DATA_OUT
);

    always @(*) begin
        case(ADDRESS)
            // Example program: Countdown
            8'h00: DATA_OUT = 12'b0000_00001010;  // LOAD 10 - A = 10
            8'h01: DATA_OUT = 12'b0100_00000001;  // SUBTRACT 1 - A = A - 1
            8'h02: DATA_OUT = 12'b1110_00000100;  // IFZERO 4 - if A is 0, we're finished
            8'h03: DATA_OUT = 12'b1100_00000001;  // GOTO 1 - otherwise keep counting down
            8'h04: DATA_OUT = 12'b1100_00000100;  // GOTO 4 - stop here (A stays at 0)

            default: DATA_OUT = 12'h000;
        endcase
    end

endmodule
