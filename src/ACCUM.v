module ACCUM (
    input wire CLK,
    input wire ENB,
    input wire [7:0] INPUT,
    output reg [7:0] OUTPUT
);

initial OUTPUT = 8'b00000000;

always @(posedge CLK) begin
    if (!ENB)
        OUTPUT <= INPUT;
end

endmodule
