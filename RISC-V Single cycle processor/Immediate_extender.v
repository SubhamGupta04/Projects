`timescale 1ns / 1ps

module immediate_extender#(parameter WIDTH=32)(
input [WIDTH-1:0] instr,
input [1:0] imm_src,
output reg [WIDTH-1:0] imm_extend
);

always@(*)begin
        case(imm_src)
            2'b00:imm_extend={{20{instr[31]}},instr[31:20]};//I type 12 bit
            2'b01:imm_extend={{20{instr[31]}},instr[31:25],instr[11:7]};//S type 12 bit
            2'b10:imm_extend={{19{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0}; // B 13 bit 
            2'b11:imm_extend={{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0}; // J 21 bit
            
            default:imm_extend={WIDTH{1'b0}};

        endcase


end

endmodule
