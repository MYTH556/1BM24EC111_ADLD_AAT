//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2026 08:57:09 PM
// Design Name: 
// Module Name: random_seq_generator
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


module random_seq_generator (
    input        clk,      
    input        reset, 
    output reg [3:0] rand_out // 4-bit pseudo-random output 
);
    // Feedback polynomial: x^4 + x^3 + 1
    wire feedback;
    assign feedback = rand_out[3] ^ rand_out[2];
    always @(posedge clk) begin
        if (reset) begin
            rand_out <= 4'b0001;
        end 
        else begin
            // Shift left and insert the feedback bit into the LSB position
            rand_out <= {rand_out[2:0], feedback};
        end
    end
endmodule

`timescale 1ns / 1ps

module tb_random_seq_generator;
    reg clk;
    reg reset;
    wire [3:0] rand_out;
    random_seq_generator R1 (clk,reset,rand_out);
    always #5 clk = ~clk;
    initial begin
        clk = 0; reset = 1;#12
        reset = 0;#160
        $finish;
    end
    initial begin
        $monitor("Time=%0t | Reset=%b | Binary = %b | Decimal = %d", 
                 $time, reset, rand_out, rand_out);
    end
endmodule

