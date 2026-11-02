//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2026 08:01:19 PM
// Design Name: 
// Module Name: shift_reg_sipo
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


module shift_reg_sipo (
    input clk,    
    input reset,  
    input serial_in,
    output reg [3:0] q     
);
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end else begin
            q <= {serial_in, q[3:1]};
        end
    end
endmodule

`timescale 1ns / 1ps

module tb_shift_regt;
reg clk;
reg reset;
reg serial_in;
wire [3:0] q;
shift_reg_sipo S1 (clk,reset,serial_in,q);
always #5 clk = ~clk;
initial begin
    clk = 0;reset = 1;serial_in = 0;#12
    reset = 0;
    // Shift in a sequence of bits: 1, 0, 1, 1
    serial_in = 1'b1; #10;
    serial_in = 1'b0; #10;
    serial_in = 1'b1; #10;
    serial_in = 1'b1; #10;
    serial_in = 1'b0; #40;
    $finish;
 end
 initial begin
    $monitor("Time=%0t | Reset=%b | Serial_In=%b | Q=%b", $time, reset, serial_in, q);
 end
endmodule