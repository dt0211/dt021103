

module cunit(Instr, Breq, BrLt, Data_out,sel_d, opcode_d,funct_d);
parameter OUT_WIDTH = 15;
parameter IN_WIDTH = 32;
/* verilator lint_off UNUSED */
input [IN_WIDTH-1:0] Instr;
input Breq, BrLt;
output reg [OUT_WIDTH-1:0] Data_out;
output reg [4:0] opcode_d;
output reg [2:0] funct_d;
output reg       sel_d;
/* verilator lint_off UNUSED */
reg [4:0] opcode;
reg [2:0] funct;
/* verilator lint_off UNOPTFLAT */
reg [1:0] comp;
/* verilator lint_off UNOPTFLAT */
reg       sel;

assign sel    = Instr[30];  
assign funct = Instr[14:12];
assign opcode   = Instr[6:2];
assign comp   = {Breq,BrLt}; 
assign funct_d = funct;
assign opcode_d = opcode;
assign sel_d = sel;
//" R-type
//parameter ADD   = 11'b0_000_01100_x_x;
//parameter SUB   = 11'b1_000_01100_x_x;
//parameter SLL   = 11'b0_001_01100_x_x;
//parameter SLT   = 11'b0_010_01100_x_x;
//parameter SLTU  = 11'b0_011_01100_x_x;
//parameter XOR   = 11'b0_100_01100_x_x;
//parameter SRL   = 11'b0_101_01100_x_x;
//parameter SRA   = 11'b1_101_01100_x_x;
//parameter OR    = 11'b0_110_01100_x_x;
//parameter AND   = 11'b0_111_01100_x_x;
//
//// I-type
//parameter ADDI  = 11'bx_000_00100_x_x;
//parameter SLLI  = 11'b0_001_00100_x_x;
//parameter SLTI  = 11'bx_010_00100_x_x;
//parameter SLTIU = 11'bx_011_00100_x_x;
//parameter XORI  = 11'bx_100_00100_x_x;
//parameter SRLI  = 11'b0_101_00100_x_x;
//parameter SRAI  = 11'b1_101_00100_x_x;
//parameter ORI   = 11'bx_110_00100_x_x;
//parameter ANDI  = 11'bx_111_00100_x_x;
//
//
//parameter LW    = 11'bx_010_00000_x_x;
//
//// S-type
//parameter SW    = 11'bx_010_01000_x_x;
//
//// B-type
//parameter BEQ_TRUE      = 11'bx_000_11000_1_x;
//parameter BEQ_FALSE     = 11'bx_000_11000_0_x;
//parameter BNE_TRUE      = 11'bx_001_11000_0_x;
//parameter BNE_FALSE     = 11'bx_001_11000_1_x;
//parameter BLT_TRUE      = 11'bx_100_11000_x_1;
//parameter BLT_FALSE     = 11'bx_100_11000_x_0;
//parameter BGE_TRUE      = 11'bx_110_11000_x_0;
//parameter BGE_FALSE     = 11'bx_110_11000_x_1;
//parameter BLTU_TRUE     = 11'bx_101_11000_x_1;
//parameter BLTU_FALSE    = 11'bx_101_11000_x_0;
//parameter BGEU_TRUE     = 11'bx_111_11000_x_0;
//parameter BGEU_FALSE    = 11'bx_111_11000_x_1;
//
//// U-type
//parameter LUI   = 11'bx_xxx_01101_x_x;
//parameter AUIPC = 11'bx_xxx_00101_x_x;
//
//// J-type
//parameter JAL   = 11'bx_xxx_11011_x_x;
//parameter JALR  = 11'bx_000_11001_x_x;"
//






/* verilator lint_off WIDTH */
always @(*) begin
/* verilator lint_off WIDTH */
    case (opcode)
        //R-type
        12: begin
            if(funct == 0) begin 
                if(sel ==0) begin //ADD
                    Data_out = 15'b0_000_1_0_0_0_0000_0_01;
                end
                if(sel ==1) begin //SUB
                    Data_out = 15'b0_000_1_0_0_0_0001_0_01;
                end
            end
            if(funct==1) begin    // SLL
                Data_out = 15'b0_000_1_0_0_0_0010_0_01;
            end
            if(funct==2) begin    // SLT 
                Data_out = 15'b0_000_1_0_0_0_0011_0_01;
            end
            if(funct==3) begin    // SLTU
                Data_out = 15'b0_000_1_0_0_0_0100_0_01;
            end
            if(funct==4) begin    // XOR
                Data_out = 15'b0_000_1_0_0_0_0101_0_01;
            end
            if(funct==5) begin    // SRL
                if(sel ==0) begin
                Data_out = 15'b0_000_1_0_0_0_0110_0_01;
                end 
                else    begin    // SRA
                Data_out = 15'b0_000_1_0_0_0_0111_0_01;
                end
            end
            if(funct==6) begin    // OR
                Data_out = 15'b0_000_1_0_0_0_1000_0_01;
            end
            if(funct==7) begin    // AND
                Data_out = 15'b0_000_1_0_0_0_1001_0_01;
            end
        end
        
        //I-type
        4: begin
            if(funct==0) begin  //ADDI
                Data_out = 15'b0_000_1_0_1_0_0000_0_01 ;
            end
            if(funct==1) begin    // SLLI
                Data_out = 15'b0_000_1_0_1_0_0010_0_01;
            end
            if(funct==2) begin    // SLTI
                Data_out = 15'b0_000_1_0_1_0_0011_0_01;
            end
            if(funct==3) begin    // SLTIU
                Data_out = 15'b0_000_1_0_1_0_0100_0_01;
            end
            if(funct==4) begin    // XORI
                Data_out = 15'b0_000_1_0_1_0_0101_0_01;
            end
            if(funct==5) begin
                if(sel ==0) begin // SRLI
                    Data_out = 15'b0_000_1_0_1_0_0110_0_01 ;
                end
                else begin        // SRAI
                    Data_out = 15'b0_000_1_0_1_0_0111_0_01;
                end    
            end
            if(funct==6) begin    // ORI
                Data_out = 15'b0_000_1_0_1_0_1000_0_01  ;
            end
            if(funct==7) begin    // ANDI
                Data_out = 15'b0_000_1_0_1_0_1001_0_01;
            end
        end
        0: begin
            if (funct==2) begin
                Data_out = 15'b0_000_1_0_1_0_0000_0_00;
            end
            else 
                Data_out = 0;
        end
        //S-TYPE
        8: begin
            Data_out = 15'b0_001_0_0_1_0_0000_1_00;
        end
        
        //B-TYPE
        24: begin
            if(funct == 0) begin
                if(comp==2 || comp==3) begin //BEQ_TRUE
                    Data_out = 15'b1_010_0_0_1_1_0000_0_00;
                end
                else begin                   //BEQ_FALSE
                    Data_out = 15'b0_010_0_0_1_1_0000_0_00;
                end
            end
            if(funct == 0) begin    
                if(comp==0 || comp==1) begin //BNE_TRUE
                    Data_out = 15'b1_010_0_0_1_1_0000_0_00;
                end
                else begin                   //BNE_FALSE
                    Data_out = 15'b0_010_0_0_1_1_0000_0_00;
                end
            end
            if(funct==4) begin   
                if(comp==1 || comp==3) begin //BLT_TRUE
                    Data_out = 15'b1_010_0_0_1_1_0000_0_00;
                end
                else begin                   //BLT_FALSE
                    Data_out = 15'b0_010_0_0_1_1_0000_0_00;
                end
            end
            if(funct==5) begin   
                if(comp==3 ||comp==1) begin  //BLTU_TRUE
                    Data_out = 15'b1_010_0_1_1_1_0000_0_00;
                end
                else begin                   //BLTU_FALSE
                    Data_out = 15'b0_010_0_1_1_1_0000_0_00;
                end
            end
            if(funct==6) begin    
                if(comp==2 || comp ==0) begin //BGE_TRUE
                    Data_out = 15'b1_010_0_0_1_1_0000_0_00;
                end
                else begin                   //BGE_FALSE
                    Data_out = 15'b0_010_0_0_1_1_0000_0_00;
                end
            end
            if(funct==7) begin    
                if(comp==2 || comp==0) begin //BGEU_TRUE
                    Data_out = 15'b1_010_0_1_1_1_0000_0_00;
                end
                else begin                   //BGEU_FALSE
                    Data_out = 15'b0_010_0_1_1_1_0000_0_00;
                end
            end
        end        
        //U_TYPE
        13: begin                         //LUI
            Data_out = 15'b0_011_1_0_1_0_1111_0_01;
        end
        5 :  begin                        //AUIPC
            Data_out = 15'b0_011_1_0_0_1_0000_0_01;
        end
        //J_type
        27: begin                        //JAL
            Data_out = 15'b0_011_1_0_1_0_1111_0_01;
        end                                     
        25: begin                        //JALR
            Data_out = 15'b1_100_1_0_1_0_0000_0_10;
        end

        default: Data_out = 0;
    endcase
end
endmodule

