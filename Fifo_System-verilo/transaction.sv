class transaction;
  parameter WIDTH=16;
  rand logic wr_en;
  rand logic rd_en;
  rand logic [WIDTH-1:0] data_in;
  
  rand logic rst;
  int id = -1;                
  
  logic [WIDTH-1:0] data_out;
  logic underflow;
  logic overflow;
  logic full;
  logic empty;
  logic almost_empty;
  logic almost_full;
  logic wr_ack;
  
 
  constraint c_ops {
    wr_en dist {1 := 55, 0 := 45};
    rd_en dist {1 := 45, 0 := 55};
  }


  constraint c_reset {
    rst dist {1 := 3, 0 := 97};
  }


  constraint c_data {
    data_in dist {
      16'h0000 := 5,
      16'hFFFF := 5,
      [16'h0001:16'hFFFE] :/ 90
    };
  }
endclass
