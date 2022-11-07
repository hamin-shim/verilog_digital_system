`timescale 10ns/1ps 
module LAB07_16x4RAM_TB;
reg CLK, WR, RD;
reg [3:0] A;
reg [3:0] D_IN;
wire [3:0] Q;

LAB07_16x4RAM U1(CLK, WR, RD, A, D_IN, Q);
initial begin
	WR=1; RD=0;
	A=4'b0000; D_IN=4'b1010;
	#2 WR=0; 
	#2 WR=1;
	#2 A=4'b0101; D_IN=4'b1111;
	#2 WR=0;
	#2 A=4'b0000;
	#2 A=4'b0101;
	#2 A=4'b1010;
	#2 RD=1;
end
always begin
	CLK=0;
	#1;
	CLK=1;
	#1;
end
endmodule
