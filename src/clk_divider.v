module clk_divider #(
    parameter CLK_DIV_BIT = 18
)(
    input  wire clk_in,
    output wire clk_out
);

reg [26:0] counter;

always @(posedge clk_in) begin
    counter <= counter + 1'b1;
end

assign clk_out = counter[CLK_DIV_BIT];

endmodule
