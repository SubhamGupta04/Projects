class driver;
   transaction t;
   mailbox gen2drv;
   virtual int_fifo.driver intf;
     
   function new(mailbox gen2drv,virtual int_fifo.driver intf);
       this.gen2drv=gen2drv;
       this.intf=intf;
     endfunction
   
       task run();
         forever begin
           gen2drv.get(t);
           
           @(intf.driver_cb);
           intf.driver_cb.rst<=t.rst;
           intf.driver_cb.wr_en<=t.wr_en;
           intf.driver_cb.rd_en<=t.rd_en;
           intf.driver_cb.data_in<=t.data_in;
           intf.driver_cb.txn_id<=t.id;
           $display("[DRIVER] ID=%0d drive scheduled at TIME=%0t | wr_en=%b rd_en=%b data_in=%0h",
                    t.id, $time, t.wr_en, t.rd_en, t.data_in);
           
     end
         
   endtask
 endclass
         
