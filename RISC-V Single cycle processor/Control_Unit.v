`timescale 1ns/1ps

module control_unit(
input[6:0] opcode,
input [2:0] funct3,
input funct7,zero,
output  pcSrc,memWrite,aluSrc,regWrite,
output  [1:0] resultSrc,immSrc,
output  [2:0] aluControl
);

wire [1:0] aluOp;
wire jump,branch;

main_decoder  main(.opcode(opcode),.zero(zero),.pc_src(pcSrc),.regWrite(regWrite),.branch(branch),.jump(jump),.memWrite(memWrite),.result_src(resultSrc),.aluop(aluOp),.imm_src(immSrc),.alu_src(aluSrc));

alu_decoder alu_deco(.aluop(aluOp),.funct7(funct7),.funct3(funct3),.opcode_5(opcode[5]),.alu_control(aluControl));
 







endmodule
