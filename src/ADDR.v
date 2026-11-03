module ADDR (
    input wire CLK,
    input wire [8:0] INPUT,
    output reg [8:0] OUTPUT
);

initial OUTPUT = 9'b000000000;

always @(posedge CLK) begin
    OUTPUT <= INPUT;
end

endmodule
