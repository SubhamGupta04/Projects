program automatic fifo_program
(
    int_fifo fifo_if
);

    

    fifo_test test;


    

    initial begin

        $display("==============================================");
        $display("          FIFO PROGRAM STARTED               ");
        $display("==============================================");


        

        test = new(fifo_if);

       
        
        wait (fifo_if.rst == 1'b0);
        @(negedge fifo_if.clk);

        

        test.run();


        $display("==============================================");
        $display("          FIFO PROGRAM COMPLETED             ");
        $display("==============================================");

    end

endprogram
