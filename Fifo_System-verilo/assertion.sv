module fifo_assertion
(
    int_fifo vif
);

    
    // 1. FIFO cannot be FULL and EMPTY simultaneously


    property p_full_not_empty;
        @(posedge vif.clk)
        disable iff (vif.rst)
        !(vif.full && vif.empty);
    endproperty

    a_full_not_empty:
        assert property (p_full_not_empty)
        else
            $error("[ASSERTION] FIFO is FULL and EMPTY together");


   
    // 2. Read from EMPTY -> UNDERFLOW

    property p_empty_read_underflow;
        @(posedge vif.clk)
        disable iff (vif.rst)
        (vif.rd_en && vif.empty) |=> vif.underflow;      
    endproperty

    a_empty_read_underflow:
        assert property (p_empty_read_underflow)
        else
            $error("[ASSERTION] Read while EMPTY but UNDERFLOW=0");


 
    // 3. Write to FULL -> OVERFLOW
  

    property p_full_write_overflow;
        @(posedge vif.clk)
        disable iff (vif.rst)
        (vif.wr_en && vif.full) |=> vif.overflow;        
    endproperty

    a_full_write_overflow:
        assert property (p_full_write_overflow)
        else
            $error("[ASSERTION] Write while FULL but OVERFLOW=0");


   
    // 4. Valid READ must not cause UNDERFLOW
   

    property p_valid_read_no_underflow;
        @(posedge vif.clk)
        disable iff (vif.rst)
        (vif.rd_en && !vif.empty) |=> !vif.underflow;    
    endproperty

    a_valid_read_no_underflow:
        assert property (p_valid_read_no_underflow)
        else
            $error("[ASSERTION] Valid READ caused UNDERFLOW");


   
    // 5. Valid WRITE must not cause OVERFLOW
   

    property p_valid_write_no_overflow;
        @(posedge vif.clk)
        disable iff (vif.rst)
        (vif.wr_en && !vif.full) |=> !vif.overflow;      
    endproperty

    a_valid_write_no_overflow:
        assert property (p_valid_write_no_overflow)
        else
            $error("[ASSERTION] Valid WRITE caused OVERFLOW");


  
    // 6. UNDERFLOW and OVERFLOW cannot occur together
    

    property p_no_underflow_overflow;
        @(posedge vif.clk)
        disable iff (vif.rst)
        !(vif.underflow && vif.overflow);
    endproperty

    a_no_underflow_overflow:
        assert property (p_no_underflow_overflow)
        else
            $error("[ASSERTION] UNDERFLOW and OVERFLOW occurred together");


   
    // 7. EMPTY and ALMOST_FULL should not occur together
   

    property p_empty_not_almost_full;
        @(posedge vif.clk)
        disable iff (vif.rst)
        !(vif.empty && vif.almost_full);
    endproperty

    a_empty_not_almost_full:
        assert property (p_empty_not_almost_full)
        else
            $error("[ASSERTION] EMPTY and ALMOST_FULL together");


   
    // 8. FULL and ALMOST_EMPTY should not occur together
    

    property p_full_not_almost_empty;
        @(posedge vif.clk)
        disable iff (vif.rst)
        !(vif.full && vif.almost_empty);
    endproperty

    a_full_not_almost_empty:
        assert property (p_full_not_almost_empty)
        else
            $error("[ASSERTION] FULL and ALMOST_EMPTY together");


   
    // 9. Reset should clear EMPTY/FULL status appropriately
    

    property p_reset_empty;
        @(posedge vif.clk)
        vif.rst |=> vif.empty;          
    endproperty

    a_reset_empty:
        assert property (p_reset_empty)
        else
            $error("[ASSERTION] FIFO is not EMPTY during reset");


endmodule                             
          
          
          
