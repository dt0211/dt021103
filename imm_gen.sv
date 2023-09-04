module imm_gen(Instr, Imm_sel, Imm);
parameter WIDTH = 32;
parameter IMM_WIDTH = 3;
input [WIDTH-1:0] Instr;
input [IMM_WIDTH-1:0] Imm_sel;
output reg [WIDTH-1:0] Imm;
/* verilator lint_off COMBDLY */
always @(Imm_sel or Instr) begin
    case (Imm_sel)
        // I-type
        3'b000: begin
            Imm[10:0] = Instr[30:20];
            if (Instr[31])
                Imm[31:11] = 21'h1fffff;
            else
                Imm[31:11] = 21'h000000;       
        end
        // S-type
        3'b001: begin
            Imm[10:5] = Instr[30:25];
            Imm[4:0] = Instr[11:7]; 
            if (Instr[31])
                Imm[31:11] = 21'h1fffff;
            else
                Imm[31:11] = 21'h000000;   
        end
        // B-type
        3'b010: begin
            Imm[11] = Instr[7];
            Imm[10:5] = Instr[30:25];
            Imm[4:1] = Instr[11:8];
            Imm[0] = 1'b0;
            if (Instr[31])
                Imm[31:12] = 20'hfffff;
            else
                Imm[31:12] = 20'h00000; 
        end
        // U-type
        3'b011: begin
            Imm[11:0] = 12'h000;
            Imm[31:12] = Instr[31:12];
        end
        // J-type
        3'b100: begin
            // JAL
            if (Instr[6:2] == 5'b11011) begin
                Imm[19:12] = Instr[19:12];
                Imm[11] = Instr[20];
                Imm[10:1] = Instr[30:21];
                Imm[0] = 1'b0;
                if (Instr[31])
                    Imm[31:20] = 12'hfff;
                else
                    Imm[31:20] = 12'h000;
            end
            // JALR
            else begin              // (Instr[6:2] == 5'11001)
                Imm[10:0] = Instr[30:20];
                if (Instr[31])
                    Imm[31:11] = 21'h1fffff;
                else
                    Imm[31:11] = 21'h000000;      
            end
        end
        default: begin
            Imm = 0;
        end
    endcase
end
/* verilator lint_off COMBDLY */
endmodule

