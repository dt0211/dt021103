module decoder(Instr, Rs1, Rs2, Rsd);
parameter OUT_WIDTH = 5;
parameter IN_WIDTH = 32;
/* verilator lint_off UNUSED */
input [IN_WIDTH-1:0] Instr;
output [OUT_WIDTH-1:0] Rs1, Rs2, Rsd;

assign Rs1 = Instr[19:15];
assign Rs2 = Instr[24:20];
assign Rsd = Instr[11:7];
/* verilator lint_off UNUSED */
endmodule

