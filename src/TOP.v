module TOP (
    input wire CLK_IN,
    output wire [7:0] ACCUM_OUT,
    output wire [7:0] RAM_OUT,
    output wire [7:0] Prgmcounter_OUT,
    output wire [11:0] Program_OUT,
    output wire [7:0] MUX_OUT,
    output wire CLK_OUT
);

// Internal wires
wire CLK_internal;
wire [7:0] ACCUM_internal;
wire [11:0] PRGM;
wire [7:0] PC;
wire [7:0] CE;
wire [7:0] mux_out;
wire [8:0] addr_out;
wire [7:0] ram_out;
wire [7:0] ram_out_inverted;
wire [7:0] alu_out;
wire Z;
wire LOAD_internal;

// Output assignments
assign CLK_OUT = CLK_internal;
assign ACCUM_OUT = ACCUM_internal;
assign RAM_OUT = ram_out;
assign Prgmcounter_OUT = PC;
assign Program_OUT = PRGM;
assign MUX_OUT = mux_out;

// Calculate LOAD signal
assign LOAD_internal = (PRGM[11] & PRGM[10]) & (Z);

// Module instantiations
clk_divider clk_inst(
    .clk_in(CLK_IN),
    .clk_out(CLK_internal)
);

PROGRAM_EEPROM rom_inst (
    .ADDRESS(PC),
    .DATA_OUT(PRGM)
);

CONTROL control_inst (
    .PRGM(PRGM[11:8]),
    .OUT(CE)
);

PC pc_inst (
    .CLK(CLK_internal),
    .INPUT(mux_out),
    .SET(LOAD_internal),
    .OUTPUT(PC)
);

MUX mux_inst (
    .A(PRGM[7:0]),
    .B(ram_out_inverted),
    .sel(PRGM[8]),
    .OUT(mux_out)
);

ADDR addr_inst (
    .CLK(CLK_internal),
    .INPUT({CE[0], mux_out}),
    .OUTPUT(addr_out)
);

RAM ram_inst (
    .DATA_IN(ACCUM_internal),
    .ADDRESS(addr_out[7:0]),
    .WE_n(addr_out[8]),
    .DATA_OUT(ram_out)
);

assign ram_out_inverted = ram_out;

ACCUM accum_inst (
    .CLK(CLK_internal),
    .ENB(CE[1]),
    .INPUT(alu_out),
    .OUTPUT(ACCUM_internal)
);

ALU alu_inst (
    .A(ACCUM_internal),
    .B(mux_out),
    .S(CE[7:4]),
    .M(CE[3]),
    .Cn(~CE[2]),
    .F(alu_out),
    .Cout(),
    .Z(Z)
);

endmodule
