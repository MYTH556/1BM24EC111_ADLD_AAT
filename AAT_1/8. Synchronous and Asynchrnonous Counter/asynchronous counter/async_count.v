`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2025 09:40:18
// Design Name: 
// Module Name: asyn_count_jk
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


module async_count(
input clk,reset,
output [3:1] q
    );    
    //up counter(0-6)
     jk_ff jk4 (clk,1,1,reset,q[1]);
     jk_ff jk5 (~q[1],1,1,reset,q[2]);
     jk_ff jk6 (~q[2],1,1,reset,q[3]);
endmodule

module jk_ff (
input clk,j,k,reset,
output reg q);
always @ (posedge clk or posedge reset)
begin 
if (reset)
 q=0;
else
case ({j,k})
2'b00:q=q;
2'b01:q=0;
2'b10:q=1;
2'b11:q=~q;
endcase
end
endmodule

module async_count_tb;
reg clk,reset;
wire [3:1]q;
async_count as1 (clk,reset,q);
initial
forever #5 clk = ~clk;
initial begin
clk =1;reset=1;#10
reset=0;#60
reset=1;#10
reset=0;#20
$finish;
end
endmodule