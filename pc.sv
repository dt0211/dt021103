module pc(in, clk, out);
parameter WIDTH = 32;
input [WIDTH-1:0] in;
input clk;
output reg [WIDTH-1:0] out;

always @(posedge clk) begin
   out <= in;
end

endmodule
