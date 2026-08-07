`timescale 1ns/1ps

module risc_V(
input clk,
input reset
);


wire [31:0] pc_out, pc_plus_4, pc_target_out, pc_next;
wire [31:0] instr;
wire [31:0] rd1, rd2;
wire [31:0] imm_extend;
wire [31:0] src_b;
wire [31:0] alu_result;
wire [31:0] read_data;
wire [31:0] result;

wire pcSrc, memWrite, aluSrc, regWrite;
wire [1:0] resultSrc, immSrc;
wire [2:0] aluControl;
wire zero;


pc_reg pc(
    .clk(clk),
    .reset(reset),
    .pc_next(pc_next),
    .pc_out(pc_out)
);


pc_adder pc4(
    .pc_out(pc_out),
    .pc_plus_4(pc_plus_4)
);


instruction_memory imem(
    .instr_address(pc_out),
    .instr(instr)
);


register_file rf(
    .clk(clk),
    .rs1(instr[19:15]),
    .rs2(instr[24:20]),
    .rd(instr[11:7]),
    .wd3(result),
    .we3(regWrite),
    .rd1(rd1),
    .rd2(rd2)
);


immediate_extender imm_ext(
    .instr(instr),
    .imm_src(immSrc),
    .imm_extend(imm_extend)
);


mux2 alu_mux(
    .rd2(rd2),
    .imm_extend(imm_extend),
    .alu_src(aluSrc),
    .src_b(src_b)
);


alu alu_unit(
    .srcA(rd1),
    .srcB(src_b),
    .alu_control(aluControl),
    .alu_result(alu_result)
);


assign zero = (alu_result == 0);


data_memory dmem(
    .clk(clk),
    .megWrite(memWrite),
    .a(alu_result),
    .wd(rd2),
    .read_data_mem(read_data)
);

mux3 wb_mux(
    .alu_result(alu_result),
    .read_data(read_data),
    .pc_plus_4(pc_plus_4),
    .result_src(resultSrc),
    .result(result)
);


pc_target_adder target(
    .imm_extend(imm_extend),
    .pc_out(pc_out),
    .pc_target_out(pc_target_out)
);


mux1 pc_mux(
    .pc_plus_4(pc_plus_4),
    .pc_target_out(pc_target_out),
    .pc_src(pcSrc),
    .pc_next(pc_next)
);


control_unit cu(
    .opcode(instr[6:0]),
    .funct3(instr[14:12]),
    .funct7(instr[30]),
    .zero(zero),
    .pcSrc(pcSrc),
    .memWrite(memWrite),
    .aluSrc(aluSrc),
    .regWrite(regWrite),
    .resultSrc(resultSrc),
    .immSrc(immSrc),
    .aluControl(aluControl)
);

endmodule
