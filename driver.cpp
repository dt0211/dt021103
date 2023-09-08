#define MAX_SIM 2000



void set_random(Vtop *dut, vluint64_t sim_unit) {
        //WRITE
        if(sim_unit > 15 && sim_unit <20   || 
           sim_unit > 30 && sim_unit <40   ||
           sim_unit > 50 && sim_unit <60   ||
           sim_unit > 70 && sim_unit <80   ||
           sim_unit > 90 && sim_unit <100     
           )
           {dut -> wr_en=1;} 
         else 
           {dut -> wr_en=0;};

        //READ
        if(sim_unit > 0  && sim_unit <10   ||
           sim_unit > 20 && sim_unit <30   ||
           sim_unit > 40 && sim_unit <50   ||
           sim_unit > 60 && sim_unit <70   ||
           sim_unit > 80 && sim_unit <90
           )
           {dut -> rd_en=1;}
         else
           {dut -> rd_en=0;};



        dut->rst_n   =1;
        dut-> wr_data = rand();
}
