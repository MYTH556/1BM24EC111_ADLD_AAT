// 8 bit arithmetic logic unit

`timescale 1ns/1ps

module alu ( A, B, sel, out, cout);
  parameter n=8;
  input [n-1:0] A, B; //8 bit inputs
  input [2:0] sel;  // 3 bit selector
  output reg [n-1:0] out; //bit 8 output
  output reg cout; // 1 bit carry

  always @(*) begin
    out ={(n){1'b0}}; // default value of out to prevent latch synthesis
    cout = 1'b0; //default value of carry

    case (sel)
      3'b000: {cout,out} = A + B;  // addition (carry at cout)
      3'b001: {cout,out} = A - B;  // subtraction (borrow at cout)  
      3'b010: out = A & B;  // bitwise AND
      3'b011: out = A | B;  // bitwise OR
      3'b100: out = A ^ B;  // bitwise XOR
      3'b101: out = A << 1; // logocal shift left by 1
      3'b110: out = A >> 1; //logical shift right by 1
      3'b111: out = (A == B); // equality comparison
      default : {cout,out} = {(n+1){1'b0}}; //default
    endcase
  end
endmodule