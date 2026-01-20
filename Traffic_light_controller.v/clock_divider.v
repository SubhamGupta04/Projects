`timescale 1ns / 1ps
module clock_divider(
    input clk,
    input rst,
    output reg clk_1hz,
    output reg clk_500hz
    );
    reg [31:0] cnt_1hz;
    reg [24:0] cnt_500hz;
    
                //Converting 100 Mhz into 1 hz
    always@ (posedge clk or posedge rst)begin
    if(rst) begin
        clk_1hz<=0;
        cnt_1hz<=0;
     end 
     else if(cnt_1hz==49999999)begin
        clk_1hz<=~clk_1hz;
        cnt_1hz<=0;
     end
     else begin
        cnt_1hz<=cnt_1hz+1;
       end 
     end  
     
            //Converting 100 Mhz into 500hz
     always@ (posedge clk or posedge rst) begin
     if(rst) begin
        clk_500hz<=0;
        cnt_500hz<=0;
       end 
      else if(cnt_500hz == 99999) begin
        clk_500hz<=~clk_500hz;
        cnt_500hz<=0;
       end  
      else begin
        cnt_500hz<=cnt_500hz+1;
       end 
    end    
    
endmodule
