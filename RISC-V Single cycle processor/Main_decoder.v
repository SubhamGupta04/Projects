`timescale 1ns / 1ps


module main_decoder(
input [6:0] opcode,
input zero,
output reg pc_src,
output reg regWrite,alu_src,memWrite,branch,jump,
output reg [1:0] imm_src,result_src,aluop
);
    
    always @(*) begin
    {regWrite,imm_src,alu_src,memWrite,result_src,branch,aluop,jump}=11'b00000000000;
        case(opcode)
        
            7'b0000011:{regWrite,imm_src,alu_src,memWrite,result_src,branch,aluop,jump}=11'b1_00_1_0_01_0_00_0;
            7'b0100011:{regWrite,imm_src,alu_src,memWrite,result_src,branch,aluop,jump}=11'b0_01_1_1_xx_0_00_0;
            7'b0110011:{regWrite,imm_src,alu_src,memWrite,result_src,branch,aluop,jump}=11'b1_xx_0_0_00_0_01_0;
            7'b1100011:{regWrite,imm_src,alu_src,memWrite,result_src,branch,aluop,jump}=11'b0_10_0_0_xx_1_01_0;
            7'b0010011:{regWrite,imm_src,alu_src,memWrite,result_src,branch,aluop,jump}=11'b1_00_1_0_00_0_10_0;
            7'b1101111:{regWrite,imm_src,alu_src,memWrite,result_src,branch,aluop,jump}=11'b1_11_x_0_10_0_xx_1;
            
            default:{regWrite,imm_src,alu_src,memWrite,result_src,branch,aluop,jump}=11'b00000000000;
    endcase
            
    end
    
    always@(*)begin
     pc_src=(zero && branch) || jump;  
    end  
endmodule
