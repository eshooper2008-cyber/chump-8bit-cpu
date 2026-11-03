module RAM (
    input wire CLK,
    input wire [7:0] DATA_IN,
    input wire [7:0] ADDRESS,
    input wire WE_n,
    output reg [7:0] DATA_OUT
);

reg [7:0] MEMORY [0:255];

integer i;
initial begin
    for (i = 0; i < 256; i = i + 1) begin
        MEMORY[i] = 8'b00000000;
    end
end

always @(*) begin
    DATA_OUT = MEMORY[ADDRESS];
end

always @(*) begin
    if (!WE_n) begin
        MEMORY[ADDRESS] <= DATA_IN;
    end
end

endmodule
