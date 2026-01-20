`timescale 1ns / 1ps
module clock_divider(
    input clk,
    input rst,
    output reg clk_1hz,
    output reg clk_500hz
    );
    
    reg [26:0] cnt_1hz;
    reg [18:0] cnt_500hz;
    
    always@ (posedge clk or posedge rst)begin
    if(rst)begin
        clk_1hz<=0;
        cnt_1hz<=0;
        end
     else if(cnt_1hz==49999999)begin
        clk_1hz<=~clk_1hz;
        cnt_1hz<=0;
        end 
     else 
        cnt_1hz<=cnt_1hz+1;            
 end
 
 
 always@ (posedge clk or posedge rst)begin
    if(rst)begin
        clk_500hz<=0;
        cnt_500hz<=0;
        end 
    else if(cnt_500hz==99999)begin
        clk_500hz<=~clk_500hz;
        cnt_500hz<=0;
        end  
    else
        cnt_500hz<=cnt_500hz+1;       
 
 end
endmodule
