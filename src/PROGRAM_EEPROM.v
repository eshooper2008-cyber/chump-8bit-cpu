module PROGRAM_EEPROM (
    input wire [7:0] ADDRESS,
    output reg [11:0] DATA_OUT
);

    always @(*) begin
        case(ADDRESS)
            // Initialize: a=5, b=3
            8'h00: DATA_OUT = 12'b1000_00000000;  // READ const 0
            8'h01: DATA_OUT = 12'b0000_00000000;  // LOAD const 0
            8'h02: DATA_OUT = 12'b0010_00000001;  // ADD const 1
            8'h03: DATA_OUT = 12'b0110_00000000;  // STORETO const 0
            8'h04: DATA_OUT = 12'b1100_00000010;  // GOTO const 0x02

            default: DATA_OUT = 12'h000;
        endcase
    end

endmodule
