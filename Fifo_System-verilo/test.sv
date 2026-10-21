class fifo_test;

    

    environment env;


    

    virtual int_fifo vif;


    

    int num_trans = 100;




    function new(
        virtual int_fifo vif
    );

        this.vif = vif;

    endfunction


    

    task run();

        $display("==============================================");
        $display("              FIFO TEST STARTED              ");
        $display("==============================================");


        

        env = new(
            vif,
            num_trans
        );


        

        env.run();


        

        $display("==============================================");
        $display("              FIFO TEST COMPLETED            ");
        $display("==============================================");

    endtask

endclass
          
