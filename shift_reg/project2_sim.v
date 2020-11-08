`timescale 1ns / 1ps
module testbench; // declare testbench name
  reg clock;
  reg load;
  reg reset;  // declaration of signals
  wire [4:0] shiftreg;
  reg [4:0] data;
  reg [1:0] sel;
   // instantiation of the shift_reg design below
  shift_reg dut(.clock (clock),
.load (load),
.reset (reset),
.shiftreg (shiftreg),
               .data (data),
.sel (sel));
   //this process block sets up the free running clock
  initial begin
  clock = 0;
  forever #50 clock = ~clock;
  end
  initial begin// this process block specifies the stimulus.
    reset = 1;
    data = 5'b00000;
    load = 0;
    sel = 2'b00;
   #200
    reset = 0;
    load = 1;
   #200
    data = 5'b00001;
   #100
    sel = 2'b01;
    load = 0;
   #200
    sel = 2'b10;
   #1000 $stop;
  end
 initial begin// this process block pipes the ASCII results to the
//terminal or text editor
  $timeformat(-9,1,"ns",12);
  $display("   Time Clk Rst Ld SftRg Data Sel");
  $monitor("%t %b %b %b %b %b %b", $realtime,
       clock, reset, load, shiftreg, data, sel);
 end
 endmodule