`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2026 06:49:30 PM
// Design Name: 
// Module Name: barrel_shift
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


module barrel_shift(
input  [3:0]data_in,    // 4-bit input data
input  [1:0]shift_amt,  // Shift amount (0 to 3)
input  dir,        // Direction: 0 = Shift Right, 1 = Shift Left
output [3:0]data_out    // 4-bit shifted output
    );
    
   assign data_out = dir ? (data_in << shift_amt) : (data_in >> shift_amt);
endmodule


module tb_barrel_shift;
reg  [3:0]data_in;
reg  [1:0]shift_amt;
reg  dir;
wire [3:0]data_out;
barrel_shift B1 (data_in,shift_amt,dir,data_out);
initial begin
$monitor("Time =%0t  direction =%b  shifted amount =%d  data in =%b  data out =%b", 
                  $time, dir, shift_amt, data_in, data_out);
// Test 1: Shift Right by 1 (dir = 0)
data_in = 4'b1101; dir = 1'b0; shift_amt = 2'd1; #10;
//Test 2: Shift Right by 2
data_in = 4'b1101; dir = 1'b0; shift_amt = 2'd2; #10;
//Test 3: Shift Left by 1 (dir = 1)
data_in = 4'b0110; dir = 1'b1; shift_amt = 2'd1; #10;
//Test 4: Shift Left by 3
data_in = 4'b0011; dir = 1'b1; shift_amt = 2'd3; #10;
$finish;
end
endmodule

