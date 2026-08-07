`timescale 1ns / 1ps

module register_file#(parameter WIDTH=32)(
input clk,
input [4:0] rs1,rs2,rd,
input [WIDTH-1:0] wd3,
input we3,
output [WIDTH-1:0] rd1,rd2
);
      reg [WIDTH-1:0] regs[0:WIDTH-1];
      
      
integer i;
     initial begin
        for(i=0;i<32;i=i+1)
        regs[i]=0;
        
      end
                  
   assign rd1= (rs1==0) ? 0: regs[rs1];
   assign  rd2=(rs2==0) ? 0: regs[rs2];
   
   always @(posedge clk) begin
            if( we3==1 && rd!=0)
            regs[rd]<=wd3;
            end
       
       
       endmodule
       
       
       
       
       
       
       
     
