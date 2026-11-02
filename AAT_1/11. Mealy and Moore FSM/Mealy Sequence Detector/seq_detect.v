`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2026 08:36:59 PM
// Design Name: 
// Module Name: seq_detect
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// 1010 mealy (overlapping) sequence detector 

module seq_detect(
input clk, reset, in,
output reg out
    );
    reg [1:0]ps,ns;
    parameter s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11;
    always @ (ps,in)
    begin 
    out =0;
    case (ps)
    s0:ns=(in?s1:s0);
    s1:ns=(in?s1:s2);
    s2:ns=(in?s3:s0);
    s3:begin 
    ns=(in?s1:s2);
    out=(in?0:1);
    end
    default:ns=s0;
    endcase
    end
    always @(posedge clk or posedge reset) begin
    if (reset)
    ps<=s0;
    else
    ps<=ns;
    end
endmodule

module tb;
reg clk , reset , in;
wire out;
seq_detect sd1 (clk, reset,in, out);
initial begin
clk=0;reset=1; in=0;#10;
reset=0;in=1;#10
in=0;#10
in=1;#10
in=0;#10
in=1;#10
in=0;#10
in=0;#20
$finish;
end
always #5 clk=~clk;
endmodule
