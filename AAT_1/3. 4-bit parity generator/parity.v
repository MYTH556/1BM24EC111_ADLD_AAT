
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2026 06:29:28 PM
// Design Name: 
// Module Name: parity
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


module parity(
//transmittor
input [3:0]tx_data,
output tx_parity,
//reciever
input [3:0]rx_data,
input rx_parity,
output error
    );
    assign tx_parity = ^(tx_data);
    assign error= (^rx_data)^rx_parity;
endmodule

`timescale 1ns / 1ps

module tb_parity;
reg [3:0] tx_data;
wire tx_parity;
reg [3:0] rx_data;
reg rx_parity;
wire error;
parity P1 (tx_data,tx_parity,rx_data,rx_parity,error);
initial begin
$monitor("%0t\t%b\t%b\t%b\t%b\t%b", 
                 $time, tx_data, tx_parity, rx_data, rx_parity, error);
// Case 1: Clean Transmission (tx_data = 1011 -> 3 ones, tx_p = 1)
tx_data = 4'b1011; #5;
rx_data   = tx_data;
rx_parity = tx_parity; 
#10;
                 
//Case 2: Data Bit Flip Error (rx_data becomes 1001, tx_p remains 1)
tx_data = 4'b1011; #5;
rx_data   = 4'b1001; // Bit 1 flipped!
rx_parity = tx_parity; 
#10;
                 
//Case 3: Parity Bit Flip Error (rx_data intact, rx_parity corrupted)
tx_data = 4'b0110; #5;
rx_data   = tx_data;
rx_parity = ~tx_parity; // Parity bit flipped!
#10;
                 
//Case 4: Clean Transmission (tx_data = 1111 -> 4 ones, tx_p = 0)
tx_data = 4'b1111; #5;
rx_data   = tx_data;
rx_parity = tx_parity; 
#10;
$finish;
end
endmodule

