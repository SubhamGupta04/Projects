`timescale 1ns / 1ps


module clock(
input clk_1hz,clk_500hz,
input rst,
output reg [3:0]out,
output reg [7:0]seg
);
reg [5:0] minutes,seconds;
reg [4:0] hour;
reg [1:0] counter;
reg [3:0] digit;

always @(posedge clk_1hz or posedge rst)begin
if(rst)begin
seconds<=0;
minutes<=0;
hour<=0;
end
else begin
       if(seconds<59)
            seconds<=seconds+1;
        else begin
                seconds<=0;
                if(minutes<59)
                         minutes<=minutes+1;
                 else begin
                        minutes<=0;
                        if(hour<23)
                                hour<=hour+1;
                        else
                                hour<=0;       
                 end
        end
 end
        
end
always @(posedge clk_500hz or posedge rst)begin
    if(rst)
        counter<=0;
    else 
        counter<=counter+1;
end

always @(*)begin
    case(counter) 
        2'b00:begin
                out=4'b0001;
                digit=hour/10;
              end  
        2'b01:begin
                out=4'b0010;
                digit=hour%10;
               end 
        2'b10:begin
                out=4'b0100;
                digit=minutes/10;
              end  
        2'b11:begin
                out=4'b1000;
                digit=minutes%10;
               end 
    endcase    
                            
end


always @(*)begin
    case(digit)
        4'b0000: seg=8'b00000011;
        4'b0001: seg=8'b10011111;
        4'b0010: seg=8'b00100101;
        4'b0011: seg=8'b00001101;
        4'b0100: seg=8'b10011001;
        4'b0101: seg=8'b01001001;
        4'b0110: seg=8'b01000001;
        4'b0111: seg=8'b00011111;
        4'b1000: seg=8'b00000001;
        4'b1001: seg=8'b00011001;
        default: seg=8'b11111111;
         

endcase

end







endmodule
