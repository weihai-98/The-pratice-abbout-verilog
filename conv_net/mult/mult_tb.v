`timescale 1ns/1ps
module add_tree_tb ();
wire [35:0] filter;
wire [99:0] image;
wire [8*9-1:0] ans;
wire [11:0] re_;
reg clk;
assign filter=36'h111_111_111;
assign image=100'h84444_44444_44444_44444_44484;
initial
begin
    clk=0;
end
always #10 clk=~clk;
mult mul(
.filter(filter),
.image(image),
.clk(clk),
.ans(ans),
.re_(re_)
);
endmodule 