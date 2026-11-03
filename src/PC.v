module PC (
    input wire CLK,
    input wire [7:0] INPUT,
    input wire SET,
    output reg [7:0] OUTPUT
);

initial OUTPUT = 8'b00000000;

always @(posedge CLK) begin
    if (SET) begin
        OUTPUT <= INPUT;
    end else begin
        OUTPUT <= OUTPUT + 1;
    end
end

endmodule
