`timescale 1ns / 1ps
module traffic_light(
    input clk,
    input rst,
    output reg g_led,
    output reg y_led,
    output reg r_led,
    output reg [7:0]an,
    output reg[7:0]seg
    );
    
    wire clk_1hz,clk_500hz;
    
    clock_divider dut(.clk(clk),.rst(rst),.clk_1hz(clk_1hz),.clk_500hz(clk_500hz));
    parameter Green=2'b00,Yellow=2'b01,Red=2'b10;
    
    reg [5:0] countdown;
    reg[1:0] state;
    integer Green_Time=15;
    integer Yellow_Time=5;
    integer Red_Time=15;
    
    //FSM
    
    always@(posedge clk_1hz or posedge rst) begin
    if(rst) begin
        state<=Green;
        countdown<=Green_Time;
        end
    else begin
        if(countdown>0) 
        countdown<=countdown-1;
        
        else begin
        case (state)
            Green :begin state<=Yellow;countdown<=Yellow_Time; end
            Yellow:begin state<=Red;countdown<=Red_Time; end
            Red:begin state<=Green;countdown<=Green_Time;end
            default: begin state<=Green;countdown<=Green_Time;end
        endcase        
        end
    end
 end   
 
        //LED Output
    always@ (*)begin
        g_led=0;y_led=0;r_led=0;
        
        case(state)
        Green:g_led=1;
        Yellow:y_led=1;
        Red:r_led=1;
     endcase 
   end 
   
    //Display and segment
   reg [1:0]mux;reg [3:0]digit;
   always@ (posedge clk_500hz or posedge rst) begin
     if(rst)
        mux<=0;
     else   
           mux<=mux+1;
    end
    
    always@ (*)begin
    case(mux)
        2'b00:begin
                an=8'b11111110;
                digit=countdown%10;
               end 
        2'b01:begin
                an=8'b11111101;
                digit=countdown/10;
                end
        default:begin
                an=8'b11111111;
                digit=0;
                end        
    endcase
    
        case (digit)
            4'd0: seg = 8'b11000000;
            4'd1: seg = 8'b11111001;
            4'd2: seg = 8'b10100100;
            4'd3: seg = 8'b10110000;
            4'd4: seg = 8'b10011001;
            4'd5: seg = 8'b10010010;
            4'd6: seg = 8'b10000010;
            4'd7: seg = 8'b11111000;
            4'd8: seg = 8'b10000000;
            4'd9: seg = 8'b10010000;
            default: seg = 8'b11111111;
        endcase
  end
    
endmodule
