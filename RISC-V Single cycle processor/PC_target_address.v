`timescale 1ns / 1ps

module pc_target_adder#(parameter WIDTH=32)(
input [WIDTH-1:0] imm_extend,
input [WIDTH-1:0] pc_out,
output [WIDTH-1:0] pc_target_out
);

assign pc_target_out=pc_out+imm_extend;

endmodule
