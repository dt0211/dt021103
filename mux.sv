module mux(in0, in1, sel, out);
parameter WIDTH = 32;
input [WIDTH-1:0] in0, in1;
input sel;
output reg [WIDTH-1:0] out;

always @(*) begin
    out = (sel) ? in1 : in0;
end
    
endmodule

