module alu(DataA, DataB, ALU_sel, ALU_out);
parameter DATA_WIDTH = 32;
parameter SEL_WIDTH = 4;
input signed [DATA_WIDTH-1:0] DataA, DataB;
input [SEL_WIDTH-1:0] ALU_sel;
output reg [DATA_WIDTH-1:0] ALU_out;

parameter [3:0] ADD     = 4'b0000;
parameter [3:0] SUB     = 4'b0001;
parameter [3:0] SLL     = 4'b0010;
parameter [3:0] SLT     = 4'b0011;
parameter [3:0] SLTU    = 4'b0100;
parameter [3:0] XOR     = 4'b0101;
parameter [3:0] SRL     = 4'b0110;
parameter [3:0] SRA     = 4'b0111;
parameter [3:0] OR      = 4'b1000;
parameter [3:0] AND     = 4'b1001;
parameter [3:0] B_OUT   = 4'b1111;

reg [DATA_WIDTH-1:0]  B_inverted, B_plus_one, difference; 
reg                   LessThan;

// Invert B
assign  B_inverted = ~DataB;

// Add 1 to the inverted B
assign B_plus_one = B_inverted + 1;

// A-B
assign difference =  DataA + B_plus_one;

 // Check for equality
//assign Equal = (difference == 0);

   // Check if A is less than B
assign LessThan = (difference[DATA_WIDTH] == 1'b1);

    // Check if A is greater than B
//assign GreaterThan = (difference[DATA_WIDTH] == 1'b0);

`ifdef VERILATOR
  /* verilator lint_off LATCH */
always @(*) begin
    case (ALU_sel)
        ADD: begin
            ALU_out = DataA + DataB;
        end
        SUB: begin
            ALU_out = DataA + B_plus_one;
        end
        SLL: begin
            ALU_out = DataA << $unsigned(DataB);
        end
        SLT: begin
            ALU_out = (LessThan == 1) ? 1 : 0;
        end
        SLTU: begin
            ALU_out = ($unsigned(DataA) < $unsigned(DataB)) ? 1 : 0;
        end
        XOR: begin
            ALU_out = DataA ^ DataB;
        end
        SRL: begin
            ALU_out = DataA >> $unsigned(DataB);
        end
        SRA: begin
            ALU_out = DataA >>> $unsigned(DataB);
        end
        OR: begin
            ALU_out = DataA | DataB;
        end
        AND: begin
            ALU_out = DataA & DataB;
        end
        B_OUT: begin
            ALU_out = DataB;
        end
        default: begin
            ALU_out = ALU_out + 0;
        end
    endcase
end
  /*verilator lint_on LATCH*/
`endif

endmodule

