// test bench for 8 bit alu

`timescale 1ns / 1ps

module tb_alu;
parameter n=8;
reg [n-1:0]A,B;
reg [2:0] sel;
wire [n-1:0] out;
wire cout;

alu A1 (A,B,sel,out,cout);
initial begin
$dumpfile ("alu.vcd");
$dumpvars;
end

initial begin
$monitor ("Time = %0t | A = %d | B = %d | sel = %b | out = %d | cout = %d" ,   $time ,A ,B ,sel ,out ,cout);
A=8'h0A; B= 8'h02;
sel = 3'b000;#10
sel = 3'b001;#10
sel = 3'b010;#10
sel = 3'b011;#10
sel = 3'b100;#10
sel = 3'b101;#10
sel = 3'b110;#10
sel = 3'b111;#10
$finish;
end
endmodule