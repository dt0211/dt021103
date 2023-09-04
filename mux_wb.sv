module mux_wb(in0, in1, in2, sel, out);
parameter DATA_WIDTH = 32;
parameter SEL_WIDTH = 2;
input [DATA_WIDTH-1:0] in0, in1, in2;
input [SEL_WIDTH-1:0] sel;
output reg [DATA_WIDTH-1:0] out;

always @(*) begin
/* verilator lint_off CASEINCOMPLETE */
    case(sel)
        2'b00: out = in0; // DMEM
        2'b01: out = in1; // ALU
        2'b10: out = in2; // PC+4  
    endcase  
/* verilator lint_off CASEINCOMPLETE */
end

endmodule
