`timescale 1ns / 1ps



module pc_reg#(parameter WIDTH=32)(
    input clk,
    input reset,
    input [WIDTH-1:0] pc_next,
    output reg [WIDTH-1:0] pc_out
    );
    
    always @(posedge clk or posedge reset)begin
            if(reset)
                pc_out<=32'd0;
            else
                pc_out<=pc_next;
    
                end
  initial pc_out = 0;                
endmodule
