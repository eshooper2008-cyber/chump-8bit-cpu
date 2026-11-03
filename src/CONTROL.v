module CONTROL (
    input wire [3:0] PRGM,
    output reg [7:0] OUT
);

    always @(*) begin
        case(PRGM)
            4'b0000: OUT = 8'hA9;
            4'b0001: OUT = 8'hA9;
            4'b0010: OUT = 8'h95;
            4'b0011: OUT = 8'h95;
            4'b0100: OUT = 8'h61;
            4'b0101: OUT = 8'h61;
            4'b0110: OUT = 8'h02;
            4'b0111: OUT = 8'h02;
            4'b1000: OUT = 8'h03;
            4'b1001: OUT = 8'h03;
            4'b1010: OUT = 8'h00;
            4'b1011: OUT = 8'h00;
            4'b1100: OUT = 8'hCB;
            4'b1101: OUT = 8'hCB;
            4'b1110: OUT = 8'h0B;
            4'b1111: OUT = 8'h0B;
            default: OUT = 8'b00000000;
        endcase
    end

endmodule
