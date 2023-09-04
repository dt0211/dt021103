// PC+4 module
module bloodfor(in, out);
parameter WIDTH = 32;
input [WIDTH-1:0] in;
output reg [WIDTH-1:0] out;

always @(*) begin
    out = in+4;
end

endmodule

