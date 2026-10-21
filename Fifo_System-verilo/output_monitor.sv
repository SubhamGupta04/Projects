class output_monitor;
        transaction t;
        mailbox out_mon2scb;
        virtual int_fifo.output_monitor out_mon;
        
        function new(mailbox out_mon2scb,virtual int_fifo.output_monitor out_mon);
          this.out_mon2scb=out_mon2scb;
          this.out_mon=out_mon;   
          
      endfunction
        
        task run();
          	forever begin
              @(out_mon.out_mon_cb);
              t=new();
              t.id=out_mon.out_mon_cb.txn_id;
              
              	t.data_out=out_mon.out_mon_cb.data_out;
              	t.empty=out_mon.out_mon_cb.empty;
              	t.full=out_mon.out_mon_cb.full;
              	t.overflow = out_mon.out_mon_cb.overflow;
                t.underflow = out_mon.out_mon_cb.underflow;

                t.almost_full = out_mon.out_mon_cb.almost_full;
                t.almost_empty = out_mon.out_mon_cb.almost_empty;

                t.wr_ack = out_mon.out_mon_cb.wr_ack;

              
               if (t.id >= 0) $display(
                "[OUTPUT MONITOR] ID=%0d TIME=%0t | data_out=%0h | full=%b | empty=%b | overflow=%b | underflow=%b | wr_ack=%b",
                t.id,
                $time,
                t.data_out,
                t.full,
                t.empty,
                t.overflow,
                t.underflow,
                t.wr_ack
            );


           
            out_mon2scb.put(t);

              
              
            end
          
        endtask
        
    endclass
      
      
