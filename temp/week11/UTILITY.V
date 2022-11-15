/*************** 2-4 Decoder ********************/
module DECODER2to4(A1,A0,D3,D2,D1,D0);
input A1,A0;
output D3,D2,D1,D0;
wire b0,b1,b2,b3,b4,b5,b6,b7;
 
assign b0 = ~ A0;
assign b1 = ~ A1;
assign b2 = A0;
assign b3 = ~ A1;
assign b4 = A1;
assign b5 = ~ A0;
assign b6 =  A1;
assign b7 = A0;
assign D0 = b0 & b1;
assign D1 = b2 & b3;
assign D2 = b4 & b5;
assign D3 = b6 & b7;
 
endmodule
/**********************************************/
 
/*************** Multiplexer ****************/
module MUX2to1(D1,D0,S,OUT);
input [3:0] D1,D0;
input S;
output [3:0] OUT;
reg [3:0] OUT;
 
always @(D1 or D0 or S) begin
if( S == 1'b0 )
OUT = D0;
else if( S == 1'b1 )
OUT = D1;
end
endmodule
 
module MUX4to1(D3,D2,D1,D0,S1,S0,OUT);
input [3:0] D3, D2, D1, D0;
input S1, S0;
output [3:0] OUT;
reg [3:0] OUT;
 
always @(D3 or D2 or D1 or D0 or S1 or S0) begin
if( {S1,S0} == 2'b00)
OUT = D0;
else if( {S1,S0} == 2'b01)
OUT = D1;
else if( {S1,S0} == 2'b10)
OUT = D2;
else if( {S1,S0} == 2'b11)
OUT = D3;
end 
endmodule 
/**********************************************/
/************************************************/
/*************** 4bit Adder ****************/
module HALF_ADDER(X,Y,C,S);
 
input X, Y;
     output C, S;

 
xor x0(S, X, Y);
and a0(C, X, Y);
 
endmodule
 
module FULL_ADDER(X,Y,Z,C,S);
 
     input X, Y, Z;
output C, S;
 
wire C0, C1;
wire S0;
 
// First half adder instance
HALF_ADDER H0(X, Y, C0, S0);
// Second half adder instance
HALF_ADDER H1(S0, Z, C1, S);
// Carry
or o0(C, C1, C0);
 
endmodule
 
 
module ADDER_4BIT(A,B,Cin,Cout,Sum);
 
input [3:0] A, B;
input Cin;
output Cout;
output [3:0] Sum;

 
wire [2:0] cw;
 
FULL_ADDER F0 (A[0], B[0], Cin, cw[0], Sum[0]);
FULL_ADDER F1 (A[1], B[1], cw[0], cw[1], Sum[1]);
FULL_ADDER F2 (A[2], B[2], cw[1], cw[2], Sum[2]);
FULL_ADDER F3 (A[3], B[3], cw[2], Cout, Sum[3]);
 
endmodule
 
/***************************************************/
