`timescale 1ns / 1ps


module data_memory #(parameter WIDTH=32) (
input clk,megWrite,
input [WIDTH-1:0] a,wd,
output [WIDTH-1:0] read_data_mem

);

reg [WIDTH-1:0] data_mem [0:1023];

always @(posedge clk)begin
    if(megWrite==1)begin
       data_mem[a[31:2]]<= wd;
       end
end

assign read_data_mem=data_mem[a[31:0]];



endmodule
