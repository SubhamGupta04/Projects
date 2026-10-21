class scoreboard;

    parameter WIDTH = 16;
    parameter DEPTH = 16;

    
    mailbox in_mon2scb;
    mailbox out_mon2scb;
    mailbox scb2gen;         


    

    transaction in_t;    
    transaction out_t;    


    

    logic [WIDTH-1:0] ref_fifo[$];

    logic [WIDTH-1:0] expected_data;

  
    bit exp_rd;
    bit exp_ovf;
    bit exp_unf;
    bit exp_ack;




    int pass_count;
    int fail_count;

    

    function new(
        mailbox in_mon2scb,
        mailbox out_mon2scb,
        mailbox scb2gen
    );

        this.in_mon2scb  = in_mon2scb;
        this.out_mon2scb = out_mon2scb;
        this.scb2gen     = scb2gen;

        pass_count = 0;
        fail_count = 0;

    endfunction


    

    function void check_flag(string name, logic actual, bit expected);

        if(actual === expected)
            pass_count++;
        else begin
            fail_count++;
            $error("[SCOREBOARD] FAIL | TIME=%0t | %s Expected=%b Actual=%b",
                   $time, name, expected, actual);
        end

    endfunction


    

    task run();

        forever begin

            in_mon2scb.get(in_t);
            out_mon2scb.get(out_t);

           
            if (in_t.id != out_t.id)
              $fatal(1, "[SCOREBOARD] Monitor ID mismatch: input ID=%0d output ID=%0d at TIME=%0t",
                     in_t.id, out_t.id, $time);

           
            if (in_t.id < 0)
              continue;

            

            if(in_t.rst) begin

                ref_fifo.delete();

                $display(
                    "[SCOREBOARD] TIME=%0t | RESET | Reference FIFO cleared",
                    $time
                );

            end

            else begin


                check_flag("FULL (pre)",  in_t.full,  (ref_fifo.size() == DEPTH));
                check_flag("EMPTY (pre)", in_t.empty, (ref_fifo.size() == 0));


                

                exp_rd  = 0;
                exp_ovf = 0;
                exp_unf = 0;
                exp_ack = 0;

                // WRITE
                if(in_t.wr_en) begin

                    if(!in_t.full) begin

                        ref_fifo.push_back(in_t.data_in);
                        exp_ack = 1;

                        $display(
                            "[SCOREBOARD] WRITE | TIME=%0t | DATA=%0h | SIZE=%0d",
                            $time,
                            in_t.data_in,
                            ref_fifo.size()
                        );

                    end

                    else begin
                        exp_ovf = 1;
                    end

                end

                // READ
                if(in_t.rd_en) begin

                    if(!in_t.empty) begin

                        if(ref_fifo.size() == 0) begin

                            fail_count++;

                            $error(
                                "[SCOREBOARD] ERROR | Reference FIFO is empty during valid DUT read"
                            );

                        end

                        else begin

                            expected_data = ref_fifo.pop_front();
                            exp_rd = 1;

                        end

                    end

                    else begin
                        exp_unf = 1;
                    end

                end


                
                // 3. DUT outputs AFTER the same edge
           if(exp_rd) begin

                    $display("[SCOREBOARD] READ | TIME=%0t | EXPECTED=%0h | ACTUAL=%0h",
                             $time, expected_data, out_t.data_out);

                    if(out_t.data_out === expected_data) begin
                        pass_count++;
                        $display("[SCOREBOARD] PASS | DATA MATCH | Expected=%0h Actual=%0h",
                                 expected_data, out_t.data_out);
                    end
                    else begin
                        fail_count++;
                        $error("[SCOREBOARD] FAIL | DATA MISMATCH | Expected=%0h Actual=%0h",
                               expected_data, out_t.data_out);
                    end

                end

                check_flag("OVERFLOW",  out_t.overflow,  exp_ovf);
                check_flag("UNDERFLOW", out_t.underflow, exp_unf);
                check_flag("WR_ACK",    out_t.wr_ack,    exp_ack);

                check_flag("FULL (post)",  out_t.full,          (ref_fifo.size() == DEPTH));
                check_flag("EMPTY (post)", out_t.empty,         (ref_fifo.size() == 0));
                check_flag("ALMOST_FULL",  out_t.almost_full,   (ref_fifo.size() == DEPTH-1));
                check_flag("ALMOST_EMPTY", out_t.almost_empty,  (ref_fifo.size() == 1));

            end

            // Release the generator only for this exact, fully checked ID.
            $display("[SCOREBOARD] ID=%0d TIME=%0t | CYCLE CHECK COMPLETE; ACK sent to generator",
                     in_t.id, $time);
            scb2gen.put(in_t.id);

        end

    endtask


    
    // REPORT
    

    function void report();

        $display("");
        $display("==============================================");
        $display("          SCOREBOARD FINAL REPORT");
        $display("==============================================");

        $display("PASS COUNT = %0d", pass_count);
        $display("FAIL COUNT = %0d", fail_count);
        $display("FIFO SIZE  = %0d", ref_fifo.size());
        if(fail_count == 0)
            $display("RESULT     = TEST PASSED");
        else
            $display("RESULT     = TEST FAILED");

        $display("==============================================");

    endfunction

endclass
      
      
