//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2026 07:29:08 PM
// Design Name: 
// Module Name: johnson_counter
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

module johnson_counter (
    input clk, 
    input reset, 
    output reg [3:0]q );
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;  
        end 
        else begin
            q <= {q[2:0], ~q[3]};
        end
    end
endmodule

`timescale 1ns / 1ps

module tb_johnson_counter;
    reg clk;
    reg reset;
    wire [3:0]q;
    johnson_counter J1 (clk,reset,q);
    always #5 clk = ~clk;
    initial begin
        clk = 0;reset = 1;#12
        reset = 0;#90 
        $finish;
    end
    initial begin
        $monitor("Time=%0t | Reset=%b | Q = %b", $time, reset, q);
    end
endmodule