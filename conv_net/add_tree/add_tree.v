module add_tree#(
    parameter num = 9,//考虑卷积核为3*3，因此一次计算九个加数的�?
    parameter in_width = 8//数据大小�?8位，对应255度灰度�??
)(
    input [num*in_width-1 : 0] a,
    input clk,
    output [11 : 0] result
    //output [in_width+1 : 0] inter_result1,
    //output [in_width+1 : 0] inter_result2,
    //output [in_width+1 : 0] inter_result3
);
reg signed [in_width:0] a_array [num-1:0];//存储加数的二维数�?
wire signed [in_width:0] a1[2:0];//使用三叉树的加法树进行计算，因此将加数分为三�?
wire signed [in_width:0] a2[2:0];
wire signed [in_width:0] a3[2:0];
reg signed [in_width+2:0] sum1[2:0];//保存中间层的�?
reg signed [in_width+4:0] sum ;//保存�?终的加数�?
genvar i;
generate
for(i=0;i<num;i=i+1)begin
    always@(posedge clk) a_array[i] <= a[(i+1)*in_width-1:i*in_width];
end
endgenerate
generate
for(i=0;i<3;i=i+1)begin
    assign a1[i] = a_array[3*i];
    assign a2[i] = a_array[3*i+1];
    assign a3[i] = a_array[3*i+2];
end
endgenerate
generate
for(i=0;i<3;i=i+1)begin
    always@(posedge clk) begin
        sum1[i] <= a1[i]+a2[i]+a3[i];
    end
end
endgenerate
always@(posedge clk) sum <= sum1[0]+sum1[1]+sum1[2];
assign result = sum;
//assign inter_result1=sum1[0];
//assign inter_result2=sum1[1];
//assign inter_result3=sum1[2];
endmodule //add_tree