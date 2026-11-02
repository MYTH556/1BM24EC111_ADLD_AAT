//test bench for 4 bit johnson counter

`timescale 1ns / 1ps

module tb_johnson_counter;
reg clk;
reg reset;
wire [3:0] q;

johnson_counter A1 (clk, reset, q);

always #5 clk = ~clk;

initial begin
$dumpfile ("johnson_counter.vcd");
$dumpvars;
end

initial begin
$monitor ("Time = %0t | Reset = %b | Q = %b ",
			$time, reset, q);
clk = 0; reset = 1; #10
reset = 0; #90
$finish;
end
endmodule
