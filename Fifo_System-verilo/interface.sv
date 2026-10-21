interface int_fifo #(parameter WIDTH=16);
  logic clk;
  logic clk_d;                     
  assign #1ns clk_d = clk;
  logic rst;
  integer txn_id = -1;        
  
  logic wr_en;
  logic rd_en;
  logic [WIDTH-1:0] data_in;
  
  logic [WIDTH-1:0] data_out;
  logic underflow;
  logic overflow;
  logic full;
  logic empty;
  logic almost_empty;
  logic almost_full;
  logic wr_ack;
  
  clocking driver_cb @(negedge clk);
    default input #1step output #0; 
    	output rst;
    	output wr_en;
    	output rd_en;
        output data_in;
        output txn_id;
    
    
    	input underflow;
    	input data_out;
    	input overflow;
    	input full;
    	input empty;
    	input almost_full;
    	input almost_empty;
    	input wr_ack;
 endclocking
  
  clocking in_mon_cb @(posedge clk);
        default input #1step; 
    		
    		input rst;
    		input wr_en;
    		input rd_en;
    		input data_in;
    		input full;
    		input empty;
        input txn_id;
 endclocking
    
  clocking out_mon_cb @(posedge clk_d); 
    default input #1step;
    		input data_out;
    		input full;
    		input empty;
    		input overflow;
    		input almost_empty;
    		input almost_full;
    		input underflow;
    		input wr_ack;            
        input txn_id;
  endclocking
  
  clocking coverage_t @(posedge clk_d);
    default input #1step;
    	input rst;
    	input wr_en;
    	input rd_en;
        input data_in;
    
    
    	input underflow;
    	input data_out;
    	input overflow;
    	input full;
    	input empty;
    	input almost_full;
    	input almost_empty;
    	input wr_ack;
  endclocking
    
  
  
    modport DUT(
    input  clk,
    input  rst,

    input  wr_en,
    input  rd_en,
    input  data_in,

    output  data_out,
    output  overflow,
    output  underflow,
    output  full,
    output almost_full,
    output almost_empty,
    output empty,
    output wr_ack
   );
  
  
  modport driver(    
    clocking driver_cb         
  );
    

  modport input_monitor(
    clocking in_mon_cb
      );
    
  
   modport output_monitor(
        clocking out_mon_cb
    );
    
    modport coverage_tb(
       clocking coverage_t
     );
          
  
  
endinterface
