module top#(
    parameter filter_demension = 3,
    parameter stride = 1,
    parameter input_demension = 5,
    parameter width = 4,
    localparam filter_size=filter_demension*filter_demension,
    localparam input_size=input_demension*input_demension,
    localparam ans_width=width+width
)(
    input [filter_size*width-1 : 0] filter,
    input [input_size*width-1 : 0] image,
    input clk,
    input reset,
    output reg [12*9-1 : 0] ans_,
    output [12*9-1 : 0] ans
); 
//wire signed [7 : 0] a [2:0][2:0];
wire signed [11 : 0] ans_a[2:0][2:0];//存储加数和也即卷积后的像素值
genvar i,j;
//reg [0:2] x;
generate
            for(i=0;i<3;i=i+1)begin
                for(j=0;j<3;j=j+1)begin
                            mult #(.m(i),
                            .n(j))
                            mul(
                                .clk(clk),
                                .filter(filter),
                                .image(image),
                                //.ans(a[i][j]),
                                .re_(ans_a[i][j])
                            );
                end
            end
endgenerate
generate
    for(i=0;i<3;i=i+1)begin
        for(j=0;j<3;j=j+1)begin
            assign ans[(3*i+j+1)*12-1:(3*i+j)*12]=ans_a[i][j];
        end
    end
endgenerate
always@(posedge clk)begin
    if(reset==1)
        ans_=0;
    else begin
        //for(x=0;x<36;x=x+1)
        ans_ <= ans;
    end
end
endmodule //top