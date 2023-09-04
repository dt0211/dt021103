module regfile( clk_i,rst_ni,rs1_addr,rs2_addr,rd_addr,rd_data,rd_wren,rs1_data,rs2_data);
parameter OUT_WIDTH = 32;
parameter IN_1_WIDTH = 32;
parameter IN_2_WIDTH = 5;
input [IN_2_WIDTH-1:0] rs1_addr,rs2_addr,rd_addr;
input [IN_1_WIDTH-1:0] rd_data;
input rd_wren,clk_i,rst_ni;
output [OUT_WIDTH-1:0] rs1_data,rs2_data ;

reg [31:0] Reg_bank [0:31];
reg [IN_1_WIDTH-1:0] file;

integer i;
initial begin
    for (i = 0; i < 32; i = i + 1) begin
        Reg_bank[i] = 32'b0;
    end
end

assign rs1_data = Reg_bank[rs1_addr];
assign rs2_data = Reg_bank[rs2_addr];


integer j;
always @(negedge clk_i) begin
    if (rst_ni) begin
        for (j = 0; j < 32; j = j + 1) begin
            Reg_bank[i] <= 32'b0;
        end
    end
    else begin
        if (rd_wren) begin
            if (rd_addr != 0)
                Reg_bank[rd_addr] <= rd_data;
        end
    end    
    // x0 always is zero
    Reg_bank[0] <= 0;
end


always @(negedge clk_i) begin
    if (!rd_wren) begin
        //  Open the file for writing
            file = $fopen("regfile.data", "w");
  
        // Write data to the file using $fwrite
            for (i = 0; i < 32; i = i + 1) begin
                $fwrite(file,"%d", Reg_bank[i],"\n" );
            end

        // Close the file
            $fclose(file);

       
        end
    end
endmodule

