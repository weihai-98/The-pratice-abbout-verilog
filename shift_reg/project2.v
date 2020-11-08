`timescale 1ns / 1ps
module shift_reg(clock,reset,data,load,sel,shiftreg);
input clock;
input reset;
input[4:0] data;
input load;
input[1:0] sel;
output[4:0] shiftreg;
reg [4:0] shiftreg;
always@(posedge clock)
begin
if(reset) //��ʼ���Ĵ�����ֵ
shiftreg=0;
else if (load)
shiftreg=data; 
else
    case(sel) //�ж����ƻ�������
    2'b00:shiftreg=shiftreg;
    2'b01:shiftreg=shiftreg<<1;
    2'b10:shiftreg=shiftreg>>1;
    default:shiftreg=shiftreg;
   endcase
 end
 endmodule


