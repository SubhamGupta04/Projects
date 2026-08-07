`timescale 1ns/1ps

module alu_decoder(
input [1:0] aluop,
input  funct7,
input [2:0] funct3,
input opcode_5,
output reg [2:0] alu_control
);


always @(*) begin
        alu_control=3'b000;
        case(aluop)
         2'b00:alu_control=3'b000;     // lw and sw adition
         2'b01:alu_control=3'b001;     //branch if equal
         2'b10:begin
                 case(funct3)
                    3'b000:begin
                            if(funct7 & opcode_5)
                              alu_control=3'b001;  //r type sub
                            else
                                alu_control='b000; // add
                             end
                     3'b010:alu_control=3'b101;    // slt
                     3'b110:alu_control=3'b011;     //or
                     3'b111:alu_control=3'b010;     //and
                endcase
            
             end
    
        endcase

end

endmodule
