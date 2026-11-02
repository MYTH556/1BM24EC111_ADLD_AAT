`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2026 08:11:32 PM
// Design Name: 
// Module Name: divide_by_n
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




module divide_by_n #(parameter N = 5 )(
    input        clk,   
    input        reset,   
    output reg   div_out); // Divided output pulse
    // Automatically calculate the number of bits required for count (0 to N-1)
    reg [$clog2(N)-1:0] count;
    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            div_out <= 0;
        end 
        else if (count == N - 1) begin
            count <= 0;
            div_out <= 1'b1;
        end 
        else begin
            count <= count + 1'b1;
            div_out <= 1'b0;
        end
    end
endmodule

`timescale 1ns / 1ps

module tb_divide_by_n;
    reg        clk;
    reg        reset;
    wire       div_out;

    divide_by_n N1 (clk, reset, div_out);
    always #5 clk = ~clk;
    initial begin
        clk = 0;reset = 1;#12
        reset = 0;#100 
        $finish;
    end
    initial begin
        $monitor("Time=%0t | Reset=%b | Div_Out=%b", $time, reset, div_out);
    end
endmodule