class environment;

    

    generator       gen;
    driver          drv;
    input_monitor   in_mon;
    output_monitor  out_mon;
    scoreboard      scb;
    fifo_coverage   cov;




    mailbox gen2drv;
    mailbox in_mon2scb;
    mailbox out_mon2scb;
    mailbox scb2gen;


    

    virtual int_fifo vif;




    int num_trans;


    

    function new(
        virtual int_fifo vif,
        int num_trans
    );

        this.vif       = vif;
        this.num_trans = num_trans;


        

        gen2drv     = new(1);   
        in_mon2scb  = new();
        out_mon2scb = new();
        scb2gen     = new(1);  


        

        gen = new(
            gen2drv,
            scb2gen,
            num_trans
        );


        drv = new(
            gen2drv,
            vif.driver
        );


        in_mon = new(
            in_mon2scb,
            vif.input_monitor
        );


        out_mon = new(
            out_mon2scb,
            vif.output_monitor
        );


        scb = new(
            in_mon2scb,
            out_mon2scb,
            scb2gen
        );


        cov = new(
            vif.coverage_tb
        );

    endfunction


    

    task run();

        fork

            gen.run();

            drv.run();

            in_mon.run();

            out_mon.run();

            scb.run();

            cov.run();              

        join_none


        wait (gen.done);
        #2; // Let the final ACK/display settle without adding another FIFO cycle.

        scb.report();
        cov.report();
        disable fork; // Stop monitors before stale controls are sampled again.

    endtask


endclass
          
