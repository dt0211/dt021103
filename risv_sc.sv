module risv_sc( clk_i,rst_ni,io_sw,io_lcd,io_ledg,io_ledr,io_hex0,io_hex1,io_hex2,io_hex3,io_hex4,io_hex5,io_hex6,io_hex7);
parameter ADDR_REG_WIDTH =5;
parameter OUT_WIDTH = 32;
parameter IN_1_WIDTH = 32;
parameter SEL_WIDTH = 4;
parameter DM_ADDRESS = 12;
parameter IMM_WIDTH = 3;
parameter CONTROL_WIDTH = 15;
parameter MUX_WIDTH =2;

input  [IN_1_WIDTH-1:0]     io_sw;
input                       clk_i,rst_ni;
output [OUT_WIDTH-1:0 ]     io_lcd,io_ledg,io_ledr,io_hex0,io_hex1,io_hex2,io_hex3,io_hex4,io_hex5,io_hex6,io_hex7;

//reg    [4:0           ]     opcode_d;
//reg    [2:0           ]     funct_d;

reg    [IN_1_WIDTH-1:0]     instr;                        
reg    [SEL_WIDTH-1:0 ]     sel_alu ;
reg                         br_sel,sel_A,sel_B,wren_reg,sten_lsu;
reg    [MUX_WIDTH-1:0 ]     wb_mux;
reg    [IMM_WIDTH-1:0 ]     sel_IG ;
reg    [IN_1_WIDTH-1:0]     A_value,B_value,operand1,operand2;
reg    [IN_1_WIDTH-1:0]     data_wb;
reg    [IN_1_WIDTH-1:0]     imm,addr_imem,pc_4,next_pc;
reg    [ADDR_REG_WIDTH-1:0] addr_reg,addr_A,addr_B;
reg    [IN_1_WIDTH-1:0]     data_alu,data_lsu;
reg                         BrUn,Breq,BrLt;
/* verilator lint_off UNOPTFLAT */
/* verilator lint_off UNUSED */
reg    [CONTROL_WIDTH-1:0]  control_signal;
/* verilator lint_off UNUSED */
/* verilator lint_off UNOPTFLAT */

assign br_sel    =  control_signal[14];
assign sel_IG    =  control_signal[13:11];
assign wren_reg  =  control_signal[10];
assign BrUn      =  control_signal[9];
assign sel_B     =  control_signal[8];
assign sel_A     =  control_signal[7];
assign sel_alu   =  control_signal[6:3];
assign sten_lsu  =  control_signal[2];
assign wb_mux    =  control_signal[1:0];

mux mux_pc(
.in0(pc_4), 
.in1(data_alu), 
.sel(br_sel), 
.out(next_pc));

pc program_counter(
.in(next_pc), 
.clk(clk_i), 
.out(addr_imem));

bloodfor plus_4(
.in(addr_imem), 
.out(pc_4));

imem instruction_mem(
.inst(instr),
.PC(addr_imem));

cunit control_unit0(
.Instr(instr), 
.Breq(Breq), 
.BrLt(BrLt), 
.Data_out(control_signal),
/* verilator lint_off PINCONNECTEMPTY */
.sel_d(), 
.opcode_d(),
.funct_d());
/* verilator lint_off PINCONNECTEMPTY */

brcomp comparator(
.DataA(A_value), 
.DataB(B_value), 
.BrUn(BrUn), 
.BrEq(Breq), 
.BrLt(BrLt));

decoder decode0(
.Instr(instr),
.Rs1(addr_A),
.Rs2(addr_B),
.Rsd(addr_reg));

imm_gen imm0(
.Instr(instr), 
.Imm_sel(sel_IG), 
.Imm(imm));

regfile regfile0 (
.clk_i(clk_i),
.rst_ni(rst_ni),
.rs1_addr(addr_A),
.rs2_addr(addr_B),
.rd_addr(addr_reg),
.rd_data(data_wb),
.rd_wren(wren_reg),
.rs1_data(A_value),
.rs2_data(B_value)
);

mux mux_A(
.in0(A_value),
.in1(pc_4),
.sel(sel_A),
.out(operand1));

mux mux_B(
.in0(B_value), 
.in1(imm), 
.sel(sel_B), 
.out(operand2));

alu  alu0(
.DataA(operand1),
.DataB(operand2),
.ALU_sel(sel_alu),
.ALU_out(data_alu));

mux_wb mux_wb0(
.in0(data_lsu),
.in1(data_alu),
.in2(pc_4),
.sel(wb_mux),
.out(data_wb));


lsu lsu0(
.clk_i(clk_i),
.rst_ni(rst_ni),
.addr(data_alu[DM_ADDRESS-1:0]),
.st_data(B_value),
.st_en(sten_lsu),
.io_sw(io_sw),
.ld_data(data_lsu),
.io_lcd(io_lcd),
.io_ledg(io_ledg),
.io_ledr(io_ledr),
.io_hex0(io_hex0),
.io_hex1(io_hex1),
.io_hex2(io_hex2),
.io_hex3(io_hex3),
.io_hex4(io_hex4),
.io_hex5(io_hex5),
.io_hex6(io_hex6),
.io_hex7(io_hex7));


endmodule
