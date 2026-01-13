
`timescale 1ns / 1ps
module Clock_divider(
input clk,
input rst,
output reg clk_1hz,
output reg clk_500hz
);

    
 reg [31:0] cnt_clk_1=0;
 reg [24:0] cnt_clk_500=0;
 
 always @(posedge clk or posedge rst)begin
    if(rst)  begin
        cnt_clk_1<=0;
        clk_1hz<=0;
    end
    else if(cnt_clk_1==50000000-1)begin
        cnt_clk_1<=0;
        clk_1hz<=~clk_1hz;
    end
    else begin
        cnt_clk_1<=cnt_clk_1+1;
     end
 end 
 
 always @(posedge clk or posedge rst)begin
    if(rst)begin
        cnt_clk_500<=0;
        clk_500hz<=0;
    end
    else if(cnt_clk_500==100000-1)begin
        cnt_clk_500<=0;
        clk_500hz<=~clk_500hz;
    end
    else begin
         cnt_clk_500<=cnt_clk_500+1;
    end
 end
    
    
    
endmodule
