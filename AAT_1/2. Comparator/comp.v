
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2026 04:34:20 PM
// Design Name: 
// Module Name: comp
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


module comp #(parameter n=8)(
input [n-1:0] a,b,
output reg agb,aeb,alb);
always @ (*) begin
if (a>b) begin
agb=1;aeb=0;alb=0;
end
else if (a==b) begin
agb=0;aeb=1;alb=0;
end
else if (a<b) begin
agb=0;aeb=0;alb=1;
end
end
endmodule

`timescale 1ns / 1ps

module tb_comp;
parameter n=8;
reg [n-1:0]a,b;
wire agb,aeb,alb;
comp C1 (a,b,agb,aeb,alb);
initial begin
$monitor("Time=%0t | A=%d | B=%d, A>B =%b | A=B =%d, A<B =%b",$time, a, b, agb, aeb, alb);
a=8'b11010101;b=8'b10101101;#10
a=8'b01010101;b=8'b01010101;#10
a=8'b01010101;b=8'b10101111;#10
$finish;
end
endmodule
