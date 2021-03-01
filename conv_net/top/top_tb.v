`timescale 1ns/1ps
module add_tree_tb ();
wire [35:0] filter;
reg [99:0] image;
wire [9*12-1:0] result;
wire [9*12-1:0]ans_;  //写成reg形式就不能传递？？？？
reg clk;
reg reset;
assign filter=36'h111_111_111;//卷积核数值
//assign image=100'h2111111111111111111111121;
initial
begin
    clk=0;
    image = 100'h21111_11111_11111_11111_11121;
    forever #10 clk=~clk;
end
initial begin
    reset=1;
    //#50 image = image<<1;
    #100 reset=0;
   //image = image<<1;
    #150 image = image<<1;
    #250 image = image<<1;
end
top top(
.filter(filter),
.image(image),
.clk(clk),
.ans(result),
.reset(reset),
.ans_(ans_)
);
endmodule 