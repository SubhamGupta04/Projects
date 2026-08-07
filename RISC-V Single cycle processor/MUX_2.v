`timescale 1ns / 1ps


module mux2#(parameter WIDTH=32)(
input [WIDTH-1:0] rd2,
input [WIDTH-1:0] imm_extend,
input alu_src,
output [WIDTH-1:0] src_b
    );
    
    assign src_b= alu_src? imm_extend: rd2;
endmodule
