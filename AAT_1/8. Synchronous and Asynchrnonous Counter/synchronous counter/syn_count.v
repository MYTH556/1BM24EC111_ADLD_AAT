`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2026 07:40:45 PM
// Design Name: 
// Module Name: syn_count
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
module syn_count(
    input clk,reset,
    output reg [3:0] q
    );
    always @ (posedge clk)
    begin
    if (reset)
    q = 4'b0000;
    else
    q=q+1;
    end
endmodule

module syn_count_tb;
reg clk,reset;
wire [3:0] q;
syn_count sc1 (clk,reset,q);
always #5 clk=~clk;
initial begin
$monitor("Time=%0t | Reset=%b | Q = %b", $time, reset, q);
clk =1; reset =1;#10
reset=0;#60
reset=1;#10
reset=0;#20
$finish;
end
endmodule
