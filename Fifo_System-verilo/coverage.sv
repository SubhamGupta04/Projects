class fifo_coverage;

    virtual int_fifo.coverage_tb intf;

    covergroup fifo_cg;

        option.per_instance = 1;

        

        cp_reset:
        coverpoint intf.coverage_t.rst {

            bins reset_active   = {1'b1};
            bins reset_inactive = {1'b0};
        }


        
        // WRITE
        

        cp_wr_en:
        coverpoint intf.coverage_t.wr_en {

            bins write    = {1'b1};
            bins no_write = {1'b0};
        }


        
        // READ
        

        cp_rd_en:
        coverpoint intf.coverage_t.rd_en {

            bins read    = {1'b1};
            bins no_read = {1'b0};
        }


        
        // FULL
        

        cp_full:
        coverpoint intf.coverage_t.full {

            bins full     = {1'b1};
            bins not_full = {1'b0};
        }


        
        // EMPTY
 

        cp_empty:
        coverpoint intf.coverage_t.empty {

            bins empty     = {1'b1};
            bins not_empty = {1'b0};
        }


        
        // OVERFLOW
        

        cp_overflow:
        coverpoint intf.coverage_t.overflow {

            bins overflow     = {1'b1};
            bins no_overflow  = {1'b0};
        }


        
        // UNDERFLOW
        

        cp_underflow:
        coverpoint intf.coverage_t.underflow {

            bins underflow    = {1'b1};
            bins no_underflow = {1'b0};
        }


        
        // ALMOST FULL
        

        cp_almost_full:
        coverpoint intf.coverage_t.almost_full {

            bins almost_full     = {1'b1};
            bins not_almost_full = {1'b0};
        }


        
        // ALMOST EMPTY
        

        cp_almost_empty:
        coverpoint intf.coverage_t.almost_empty {

            bins almost_empty     = {1'b1};
            bins not_almost_empty = {1'b0};
        }


        
        // WRITE ACK
        

        cp_wr_ack:
        coverpoint intf.coverage_t.wr_ack {

            bins acknowledged = {1'b1};
            bins not_ack      = {1'b0};
        }


        
        // DATA
        

        cp_data:
        coverpoint intf.coverage_t.data_in {

            bins zero = {16'h0000};

            bins ones = {16'hFFFF};

            bins low_values =
                {[16'h0001 : 16'h00FF]};

            bins middle_values =
                {[16'h0100 : 16'h7FFF]};

            bins high_values =
                {[16'h8000 : 16'hFFFE]};
        }


        
        // WRITE + READ
        

        cross_wr_rd:
        cross cp_wr_en, cp_rd_en;


        
        // WRITE + FULL
        

        cross_write_full:
        cross cp_wr_en, cp_full;


        
        // READ + EMPTY
        

        cross_read_empty:
        cross cp_rd_en, cp_empty;



        // WRITE + FULL + OVERFLOW
        

        cross_overflow:
        cross cp_wr_en,
              cp_full,
              cp_overflow;


       
        // READ + EMPTY + UNDERFLOW
        

        cross_underflow:
        cross cp_rd_en,
              cp_empty,
              cp_underflow;



        // SIMULTANEOUS READ + WRITE + FULL
        

        cross_rd_wr_full:
        cross cp_wr_en,
              cp_rd_en,
              cp_full;


        
        // SIMULTANEOUS READ + WRITE + EMPTY
        

        cross_rd_wr_empty:
        cross cp_wr_en,
              cp_rd_en,
              cp_empty;


    endgroup


    
    // CONSTRUCTOR
    

    function new(virtual int_fifo.coverage_tb intf);

        this.intf = intf;

        fifo_cg = new();

    endfunction




    task run();
        forever begin
            @(intf.coverage_t);
            fifo_cg.sample();
        end
    endtask

   
    function void report();
        $display("");
        $display("==============================================");
        $display("        DEDICATED FIFO FUNCTIONAL COVERAGE");
        $display("==============================================");
        $display("Covergroup coverage = %0.2f%%",
                 fifo_cg.get_inst_coverage());
        $display("==============================================");
    endfunction

endclass
          
