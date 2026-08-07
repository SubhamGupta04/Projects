`timescale 1ns /1ps


module alu #(parameter WIDTH=32)(
input [WIDTH-1:0] srcA,
input [WIDTH-1:0] srcB,
input [2:0] alu_control,
output reg [WIDTH-1:0] alu_result

);

always @(*)begin

    case(alu_control)
        3'b000: alu_result=srcA + srcB;
        3'b001: alu_result=srcA - srcB;
        3'b101: alu_result=(srcA<srcB) ? 32'd1:32'd0;
        3'b011: alu_result=srcA |srcB;
        3'b010: alu_result=srcA & srcB;

      default: alu_result=32'd0;
      endcase
      
      

end





endmodule
