module alu #(parameter n=8)(
    input  wire [n-1:0] A, // First Operand (e.g., 8 bits: 7:0)
    input  wire [n-1:0] B, // Second Operand (e.g., 8 bits: 7:0)
    input  wire [2:0] sel, // Operation Selector Opcode
    output reg  [n:0] out ); // Output scaled to n:0 (e.g., 9 bits: 8:0)

    always @(*) begin
        out = {(n+1){1'b0}};// Default assignment to prevent accidental latch synthesis
        case(sel)
            3'b000: out = A + B;// Addition (Carry automatically goes to out[n])     
            3'b001: out = A - B;// Subtraction (Borrow/Carry goes to out[n])       
            3'b010: out = {1'b0, (A & B)}; // Bitwise AND           
            3'b011: out = {1'b0, (A | B)};// Bitwise OR
            3'b100: out = {1'b0, (A ^ B)};// Bitwise XOR       
            3'b101: out = {1'b0, (A << 1)};// Logical Shift Left
            3'b110: out = {1'b0, (A >> 1)};// Logical Shift Right
            3'b111: out = (A == B);// Equal Comparison
            default: out = {(n+1){1'b0}};
        endcase
    end
endmodule

`timescale 1ns / 1ps

module tb_alu;
parameter n=8;
reg [n-1:0]A;
reg [n-1:0]B;
reg [2:0]sel;
wire [n:0] out;
alu A1 (A,B,sel,out);
initial begin
$monitor ("Time=%0t | Sel=%b | A=%d, B=%d | Out=%d",$time, sel, A, B, out);
A=8'h0A;B=8'h02;sel=3'b000;#10
sel=3'b001;#10
sel=3'b010;#10
sel=3'b011;#10
sel=3'b100;#10
sel=3'b101;#10
sel=3'b110;#10
sel=3'b111;#10
$finish;
end
endmodule
 


