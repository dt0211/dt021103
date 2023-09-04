module lsu(clk_i,rst_ni,addr,st_data, st_en, io_sw,ld_data,io_lcd,io_ledg,io_ledr,io_hex0,io_hex1,io_hex2,io_hex3,io_hex4,io_hex5,io_hex6,io_hex7);
parameter DM_ADDRESS = 12;
parameter DATA_WIDTH = 32;
input [DM_ADDRESS-1:0] addr;
input [DATA_WIDTH-1:0] st_data,io_sw;
input st_en ,rst_ni , clk_i;
output reg [DATA_WIDTH-1:0] ld_data,io_lcd,io_ledg,io_ledr,io_hex0,io_hex1,io_hex2,io_hex3,io_hex4,io_hex5,io_hex6,io_hex7;

reg [DATA_WIDTH-1:0] LSU [0:(2**DM_ADDRESS)-1];
reg [3:0] sel1, sel0;

assign sel1 = addr[DM_ADDRESS-1 : DM_ADDRESS-4];
assign sel0 = addr[DM_ADDRESS-5 : DM_ADDRESS-8];

integer i,j;

initial begin
	for (i = 0; i <= ((2**DM_ADDRESS)-1); i = i + 1) begin
		LSU[i] = 0;
	end
end 

`ifdef VERILATOR

  /* verilator lint_off LATCH */
always @(*) begin
    if (rst_ni) begin
        for (j = 0; j <= ((2**DM_ADDRESS)-1); j = j + 1) begin
           LSU[i] = 0;
        end
    end
end
/*verilator lint_on LATCH*/
`endif

always @(negedge clk_i) begin
//STORE DATA
    if (st_en == 1) begin
        LSU[addr] <= st_data;
    end 
    if( sel1 == 5) begin
        LSU[addr] <= io_sw;
    end
end
  
/* verilator lint_off LATCH */
always @(*) begin
    if (st_en == 0) begin
    if (sel1 < 4 || sel1 > 5) begin
            ld_data = LSU[addr]; 
        end
        //OUTPUT PERIPHERALS
        //HEX
        if (sel1 == 4) begin
        //HEX0
            if (sel0 == 0 ) begin
                io_hex0 = LSU[addr];   
            end
            else begin
                io_hex0 = 0;
            end
        //HEX1
            if (sel0 == 1 ) begin
                io_hex1 = LSU[addr];
            end
            else begin
                io_hex1 = 0;
            end
        //HEX2
            if (sel0 == 2 ) begin
                io_hex2 = LSU[addr];
            end
        //HEX3
            if (sel0 == 3 ) begin
                io_hex3 = LSU[addr];
            end
        //HEX4
            if (sel0 == 4 ) begin
                io_hex4 = LSU[addr];
            end
        //HEX5
            if (sel0 == 5 ) begin
                io_hex5 = LSU[addr];
            end
        //HEX6
            if (sel0 == 6 ) begin
                io_hex6 = LSU[addr];
            end
        //HEX7
            if (sel0 == 7 ) begin
                io_hex7 = LSU[addr];
            end

        //LEDR
            if (sel0 == 8 ) begin
                io_ledr = LSU[addr];
            end
    
        //LEDG
            if (sel0 == 9 ) begin
                io_ledg = LSU[addr];
            end
    
        //LCD
            if (sel0 > 9 ) begin
                io_lcd = LSU[addr];
            end
        end
    end
/* verilator lint_off LATCH */
end
 endmodule

