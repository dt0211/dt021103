module imem(inst,PC);
parameter	INST_WIDTH_LENGTH = 32;
parameter	PC_WIDTH_LENGTH = 32;
parameter	MEM_WIDTH_LENGTH = 32;
parameter	MEM_DEPTH = 18;
output	reg	[INST_WIDTH_LENGTH-1:0]inst;
input		[PC_WIDTH_LENGTH-1:0]PC;

reg		[MEM_WIDTH_LENGTH-1:0]IMEM[0:(2**MEM_DEPTH-1)];

reg		[17:0] pWord;
reg		[1:0]  pByte;

assign		pWord = PC[19:2];
assign		pByte = PC[1:0];

initial begin
$readmemh("\\wsl.localhost\Ubuntu-22.04\home\dt0211\project\risv_sc\drift_fine\factorial.sv ",IMEM);
end

always@(PC)
begin
	if (pByte == 2'b00)
		inst = IMEM[pWord];
	else
		inst = 'hz;
end

endmodule
