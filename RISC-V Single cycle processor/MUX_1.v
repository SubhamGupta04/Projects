`timescale 1ns / 1ps


module mux1#(parameter WIDTH=32)(
    input [WIDTH-1:0] pc_plus_4,
    input [WIDTH-1:0] pc_target_out,
    input pc_src,
    output [WIDTH-1:0] pc_next
    );
    
    assign pc_next=pc_src ? pc_target_out : pc_plus_4;
endmodule
