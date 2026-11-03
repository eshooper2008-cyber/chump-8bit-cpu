module ALU (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [3:0] S,
    input  wire       M,
    input  wire       Cn,
    output reg  [7:0] F,
    output reg        Cout,
    output reg        Z
);

    reg [8:0] tmp;   // 9 bits so the carry out isn't lost
    wire [7:0] nB = ~B;   // keep ~B 8 bits wide inside the 9-bit sums

    always @(*) begin
        F    = 8'b00000000;
        Cout = 1'b0;
        tmp  = 9'b000000000;

        if (M) begin
            case (S)
                4'b0000: F = ~A;
                4'b0001: F = ~(A | B);
                4'b0010: F = (~A & B);
                4'b0011: F = 8'b00000000;
                4'b0100: F = ~(A & B);
                4'b0101: F = ~B;
                4'b0110: F = (A ^ B);
                4'b0111: F = (A & ~B);
                4'b1000: F = (~A | B);
                4'b1001: F = ~(A ^ B);
                4'b1010: F = B;
                4'b1011: F = (A & B);
                4'b1100: F = 8'b11111111;
                4'b1101: F = (A | ~B);
                4'b1110: F = (A | B);
                4'b1111: F = A;
            endcase
            Cout = 1'b0;
        end
        else begin
            case (S)
                4'b0000: tmp = {1'b0, A} + Cn;
                4'b0001: tmp = {1'b0, (A | B)} + Cn;
                4'b0010: tmp = {1'b0, (A | nB)} + Cn;
                4'b0011: tmp = {1'b0, 8'b11111111} + Cn;
                4'b0100: tmp = {1'b0, A} + (A & nB) + Cn;
                4'b0101: tmp = {1'b0, (A | B)} + (A & nB) + Cn;
                4'b0110: tmp = {1'b0, A} + nB + Cn;
                4'b0111: tmp = {1'b0, (A & nB)} + 8'b11111111 + Cn;
                4'b1000: tmp = {1'b0, A} + (A & B) + Cn;
                4'b1001: tmp = {1'b0, A} + B + Cn;
                4'b1010: tmp = {1'b0, (A | nB)} + (A & B) + Cn;
                4'b1011: tmp = {1'b0, (A & B)} + 8'b11111111 + Cn;
                4'b1100: tmp = {1'b0, A} + A + Cn;
                4'b1101: tmp = {1'b0, (A | B)} + A + Cn;
                4'b1110: tmp = {1'b0, (A | nB)} + A + Cn;
                4'b1111: tmp = {1'b0, A} + 8'b11111111 + Cn;
            endcase

            {Cout, F} = tmp;
        end

        Z = (F == 8'b11111111) ? 1'b1 : 1'b0;
    end

endmodule
