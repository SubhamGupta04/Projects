`timescale 1ns / 1ps


module pc_adder#(parameter WIDTH=32)(
    input [WIDTH-1:0] pc_out,
    output [WIDTH-1:0] pc_plus_4
    );
    localparam [WIDTH-1:0] four=4;
    assign pc_plus_4=pc_out+four;
endmodule
