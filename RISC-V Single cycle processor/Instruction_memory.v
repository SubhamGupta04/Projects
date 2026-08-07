`timescale 1ns / 1ps

module instruction_memory#(parameter DATA_WIDTH=32,SIZE=1024)(
input [DATA_WIDTH-1:0] instr_address,
output [DATA_WIDTH-1:0] instr
);

reg [DATA_WIDTH-1:0] instr_mem [0:SIZE-1];

assign instr=instr_mem[instr_address[11:2]];

initial begin
    $readmemh("program2.mem",instr_mem);
 end
    
 endmodule
    
    
    
    
