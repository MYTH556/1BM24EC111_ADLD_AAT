
//detect 1011
module moore_seq_detect(
    input clk, reset, in,
    output reg out
    );
reg [2:0] ps, ns;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;
always @ (ps, in)
begin
out=0;
case (ps)  
 s0:ns=in?s1:s0;
 s1:ns=in?s1:s2;
 s2:ns=in?s3:s0;
 s3:ns=in?s4:s2;
 s4:begin
  ns=in?s1:s2;
  out=1;
  end
  default: begin
            ns=s0;
            end       
endcase
end
always @ (posedge clk)
begin
 if (reset) ps<=0;
 else ps<=ns;
end
endmodule


`timescale 1ns / 1ps

module moore_tb;
reg clk, reset, in;
wire out;
moore_seq_detect MR1 (clk,reset,in,out);
initial begin
clk=1;reset=1;in=0;#2
reset=0;
in=0;#1
in=1;#1
in=1;#1
in=0;#1
in=1;#1
in=1;#1
in=1;#1
in=0;#1
in=0;#1
in=1;#1
in=0;#1
in=1;#1
in=1;#1
in=0;#1
in=1;#1
reset=1;in=1;#2
$finish;
end
always #0.5 clk=~clk;
endmodule
