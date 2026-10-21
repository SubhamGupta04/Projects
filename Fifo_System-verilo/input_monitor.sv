class input_monitor;
    transaction t;
    mailbox in_mon2scb;
    virtual int_fifo.input_monitor in_mon;
    	
    function new(mailbox in_mon2scb,virtual int_fifo.input_monitor in_mon);
      	this.in_mon2scb=in_mon2scb;
      	this.in_mon=in_mon;
     endfunction
    
    task run();
      forever begin
        
        
        @(in_mon.in_mon_cb);
               t=new();
        		
        	t.id=in_mon.in_mon_cb.txn_id;
        	t.rst=in_mon.in_mon_cb.rst;
        	t.wr_en=in_mon.in_mon_cb.wr_en;
        	t.rd_en=in_mon.in_mon_cb.rd_en;
        	t.data_in=in_mon.in_mon_cb.data_in;
        
        
        	t.empty=in_mon.in_mon_cb.empty;
        	t.full=in_mon.in_mon_cb.full;
        
        
        if (t.id >= 0)
          $display("[INPUT MONITOR] ID=%0d TIME=%0t | rst=%b wr_en=%b rd_en=%b empty=%b full=%b",
                   t.id, $time, t.rst, t.wr_en, t.rd_en, t.empty, t.full);
        
        in_mon2scb.put(t);
        
   end
    endtask                    
   endclass
