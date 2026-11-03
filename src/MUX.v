module MUX (
   input wire [7:0] A,
   input wire [7:0] B,
   input wire  sel,
   output reg [7:0] OUT
);

always @(*) begin
    if (sel)
        OUT = B;
    else
        OUT = A;
end

endmodule
