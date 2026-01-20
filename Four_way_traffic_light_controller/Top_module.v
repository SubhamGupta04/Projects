`timescale 1ns / 1ps
module four_way_traffic_light_controller(
    input clk,
    input rst,
    output reg NORTH_GREEN_LED,NORTH_YELLOW_LED,NORTH_RED_LED,
    EAST_GREEN_LED,EAST_YELLOW_LED,EAST_RED_LED,
    SOUTH_GREEN_LED,SOUTH_YELLOW_LED,SOUTH_RED_LED,
    WEST_GREEN_LED,WEST_YELLOW_LED,WEST_RED_LED,
    output reg[7:0] an,
    output reg[7:0] seg
    );
    
    wire clk_1hz,clk_500hz;
    clock_divider cd(.clk(clk),.rst(rst),.clk_1hz(clk_1hz),.clk_500hz(clk_500hz));
    
    integer GREEN_TIME=15;
    integer YELLOW_TIME=5;
   
    
    reg [5:0] countdown;reg [2:0]state;
    
    parameter NORTH_GREEN=4'b000,NORTH_YELLOW=4'b001,
    EAST_GREEN=4'b010,EAST_YELLOW=4'b011,
    SOUTH_GREEN=4'b100,SOUTH_YELLOW=4'b101,
    WEST_GREEN=4'b110,WEST_YELLOW=4'b111;
    
    always @(posedge clk_1hz or posedge rst) begin 
        if(rst) begin
            state<=NORTH_GREEN;
            countdown<=GREEN_TIME;
            end
     else begin
           
    if (countdown > 0)
        countdown <= countdown - 1;
    else begin
        case (state)

            NORTH_GREEN:  begin
                state     <= NORTH_YELLOW;
                countdown <= YELLOW_TIME;
            end

            NORTH_YELLOW: begin
                state     <= EAST_GREEN;
                countdown <= GREEN_TIME;
            end

            EAST_GREEN:   begin
                state     <= EAST_YELLOW;
                countdown <= YELLOW_TIME;
            end

            EAST_YELLOW:  begin
                state     <= SOUTH_GREEN;
                countdown <= GREEN_TIME;
            end

            SOUTH_GREEN:  begin
                state     <= SOUTH_YELLOW;
                countdown <= YELLOW_TIME;
            end

            SOUTH_YELLOW: begin
                state     <= WEST_GREEN;
                countdown <= GREEN_TIME;
            end

            WEST_GREEN:   begin
                state     <= WEST_YELLOW;
                countdown <= YELLOW_TIME;
            end

            WEST_YELLOW:  begin
                state     <= NORTH_GREEN;
                countdown <= GREEN_TIME;
            end

            default: begin
                state     <= NORTH_GREEN;
                countdown <= GREEN_TIME;
            end

        endcase
    end
end
  
        
        end
        
    
    
   always @(*) begin
    NORTH_GREEN_LED  = 0;
    NORTH_YELLOW_LED = 0;
    NORTH_RED_LED    = 1;

    EAST_GREEN_LED   = 0;
    EAST_YELLOW_LED  = 0;
    EAST_RED_LED     = 1;

    SOUTH_GREEN_LED  = 0;
    SOUTH_YELLOW_LED = 0;
    SOUTH_RED_LED    = 1;

    WEST_GREEN_LED   = 0;
    WEST_YELLOW_LED  = 0;
    WEST_RED_LED     = 1;
    
    case(state) 
        NORTH_GREEN:begin NORTH_GREEN_LED  = 1;   NORTH_RED_LED    = 0; end
        NORTH_YELLOW:begin NORTH_YELLOW_LED = 1; NORTH_RED_LED    = 0; end
        
        
        EAST_GREEN:begin EAST_GREEN_LED   = 1 ; EAST_RED_LED     = 0;end     
        EAST_YELLOW:begin EAST_YELLOW_LED  = 1;  EAST_RED_LED     = 0;end
        
        
        SOUTH_GREEN:begin SOUTH_GREEN_LED  = 1; SOUTH_RED_LED    = 0; end
        SOUTH_YELLOW:begin SOUTH_YELLOW_LED = 1; SOUTH_RED_LED    = 0;end
       
        
         WEST_GREEN:begin WEST_GREEN_LED   = 1; WEST_RED_LED     = 0; end
         WEST_YELLOW:begin WEST_YELLOW_LED  = 1; WEST_RED_LED     = 0;end
       
         
         default:begin NORTH_GREEN_LED  = 1; NORTH_RED_LED    = 0;end
         endcase
         end
         
         reg [1:0] mux;
         reg [3:0]digit;
         
         always @(posedge clk_500hz or posedge rst) begin
            if(rst)
                mux<=2'b00;
            else 
                mux<=mux+1;
         end           
 
        always @(*) begin
        
            case(mux)
                2'b00: begin
                        an=8'b11111110;
                        digit=countdown%10;
                        end
                 2'b01: begin
                        an=8'b11111101;
                        digit=countdown/10;
                        end  
                 default: begin
                        an= 8'b11111111;
                        digit = 0;  
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
