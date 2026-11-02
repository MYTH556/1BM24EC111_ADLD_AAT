`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2026 07:04:00 PM
// Design Name: 
// Module Name: timer
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

module timer (
    input clk,          
    input reset,     
    input load,         // Load new value into timer
    input en,       
    input [3:0] load_value,   // Starting value for the countdown
    output reg [3:0] timer_out,// Current countdown value
    output expired       // High (1) when timer reaches 0
);
    assign expired = (timer_out == 4'b0000);

    always @(posedge clk) begin
        if (reset) begin
            timer_out <= 4'b0000;
        end
        else if (load) begin
            timer_out <= load_value; // Load initial value
        end
        else if (en && !expired) begin
            timer_out <= timer_out - 1'b1; // Count down
        end
    end
endmodule

module tb_timer;
reg clk;
reg reset;
reg load;
reg en;
reg [3:0] load_value;
wire [3:0] timer_out;
wire expired;
timer T1 (clk,reset,load,en,load_value,timer_out,expired);
always #5 clk=~clk;
initial begin
clk = 0; reset = 1; load = 0; en = 0; load_value = 4'd0;#15        
reset = 0;        
// Load value 5 into the timer
load_value = 4'd5;load = 1;#10        
load = 0;en = 1;#60       
// Pause counting
en = 0;#20
// Load a new value (3) and resume
load_value = 4'd3;load = 1; #10
load = 0; en = 1;#40
$finish;
end
endmodule