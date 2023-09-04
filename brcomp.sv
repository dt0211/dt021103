module brcomp(DataA, DataB, BrUn, BrEq, BrLt);
parameter WIDTH = 32;
input [WIDTH-1:0] DataA, DataB;
input BrUn;
output reg BrEq, BrLt;

	initial begin
		 BrLt = 1'bz;
	     BrEq = 1'bz;
	end

    always @(DataA or DataB or BrUn) begin
			if(BrUn) begin
				if (DataA == DataB) begin BrEq = 1; BrLt = 0; end
				else if(DataA < DataB) begin BrEq = 0; BrLt = 1; end
				else if(DataA > DataB) begin BrEq = 0; BrLt = 0; end
			end
			else if (!BrUn) begin
				if ($signed(DataA) == $signed(DataB)) begin BrEq = 1; BrLt = 0; end
				else if($signed(DataA) < $signed(DataB)) begin BrEq = 0; BrLt = 1; end
				else if($signed(DataA) > $signed(DataB)) begin BrEq = 0; BrLt = 0; end
			end
			else begin BrEq = 1'bz; BrLt = 1'bz; end
    end

endmodule
