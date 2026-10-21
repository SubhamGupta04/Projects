module tb;

    parameter WIDTH = 16;

    

    int_fifo #(WIDTH) fifo_if();


    

    fifo #(
        .WIDTH(WIDTH),
        .DEPTH(16) 
    ) dut (

        .clk          (fifo_if.clk),
        .rst          (~fifo_if.rst),   

        .wr_en        (fifo_if.wr_en),
        .rd_en        (fifo_if.rd_en),
        .data_in      (fifo_if.data_in),

        .data_out     (fifo_if.data_out),
        .underflow    (fifo_if.underflow),
        .overflow     (fifo_if.overflow),

        .full         (fifo_if.full),
        .empty        (fifo_if.empty),

        .almost_empty (fifo_if.almost_empty),
        .almost_full  (fifo_if.almost_full),

        .wr_ack       (fifo_if.wr_ack)
    );


    

    initial begin

        fifo_if.clk = 0;

        forever
            #5 fifo_if.clk = ~fifo_if.clk;

    end


    

    initial begin

        fifo_if.rst = 1;

        fifo_if.wr_en   = 0;
        fifo_if.rd_en   = 0;
        fifo_if.data_in = '0;
        fifo_if.txn_id = -1;

        repeat(4)                       
            @(posedge fifo_if.clk);

        fifo_if.rst = 0;

    end


    

    fifo_assertion assertions(fifo_if);


    

    fifo_program test_program(fifo_if);


    

    initial begin

        $dumpfile("fifo.vcd");
        $dumpvars(0, tb);

    end

endmodule
