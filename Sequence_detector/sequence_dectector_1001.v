`timescale 1ns / 1ps
module Sequence_1001(
    input clk,input reset,input x,output reg out
    );
    
    parameter s0=2'b00;
    parameter s1=2'b01;
    parameter s2=2'b10;
    parameter s3=2'b11;
    
    
    reg [1:0] state,next_state;
    
    always @(*)begin
    next_state=state;
    out=1'b0;
    
    case (state)
    s0:begin
    if(x)
      next_state=s1;
    else 
      next_state=s0;
    end
    
    s1:begin
    if(x)
      next_state=s1;
    else
      next_state=s2;
    end
    
    s2:begin
    if(x)
      next_state=s1;
    else
      next_state=s3;
    end
    
    s3:begin
    if(x)begin
      out=1'b1;
      next_state=s1;
    end
    else
      next_state=s0;
    end
    
    endcase
    end
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= s0;              
        else
            state <= next_state;      
    end
    endmodule
