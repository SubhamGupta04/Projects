class generator;
  transaction t;
  mailbox gen2drv;
  mailbox scb2gen;          
  int num_trans;
  int ack_token;
  bit done = 0;

  function new(mailbox gen2drv, mailbox scb2gen, int num_trans);
    this.gen2drv = gen2drv;
    this.scb2gen = scb2gen;
    this.num_trans = num_trans;
  endfunction

  task run();
    for (int i = 0; i < num_trans; i++) begin
      t = new();
     
      if (!t.randomize())
        $fatal(1, "[GENERATOR] Randomization failed at transaction %0d", i);

      t.id = i;
      $display("[GENERATOR] ID=%0d TIME=%0t | rst=%b wr=%b rd=%b data_in=%04h",
               t.id, $time, t.rst, t.wr_en, t.rd_en, t.data_in);
     
      gen2drv.put(t);

     
      scb2gen.get(ack_token);
      if (ack_token != i)
        $fatal(1, "[GENERATOR] Wrong ACK: expected ID=%0d, received ID=%0d", i, ack_token);
      $display("[GENERATOR] Scoreboard ACK received for ID=%0d at TIME=%0t",
               ack_token, $time);
    end
    done = 1;
    $display("[GENERATOR] Completed %0d transactions", num_trans);
  endtask
endclass
