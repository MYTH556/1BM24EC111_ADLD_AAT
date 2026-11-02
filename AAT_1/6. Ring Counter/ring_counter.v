`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2026 07:21:16 PM
// Design Name: 
// Module Name: ring_counter
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


module ring_counter (
    input clk, reset,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001;
        end 
        else begin
            q <= {q[2:0], q[3]};
        end
    end
endmodule

`timescale 1ns / 1ps

module tb_ring_center;

    reg        clk;
    reg        reset;
    wire [3:0] q;
    ring_counter R1 (clk,reset,q);
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;#12
        reset = 0;#60
        $finish;
    end
    initial begin
        $monitor("Time=%0t | Reset=%b | Q = %b", $time, reset, q);
    end
endmodule