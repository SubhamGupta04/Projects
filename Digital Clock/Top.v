`timescale 1ns / 1ps
module top(
input clk,
input rst,
output [3:0] out,
output [7:0] seg
    );
    wire clk_1hz,clk_500hz;
    
 Clock_divider dut1(.clk(clk),
                    .rst(rst),
                    .clk_1hz(clk_1hz),
                    .clk_500hz(clk_500hz));
clock dut2(.clk_1hz(clk_1hz),
            .clk_500hz(clk_500hz),
            .rst(rst),
            .out(out),
            .seg(seg));                    
                    
    
    
    
endmodule
