`timescale 10ns/1ps

module LAB03_ADDSUB_4BIT_TB;

reg [3:0] A,B;
reg Sel;
wire [3:0] Sum;
wire Cout;

LAB03_ADDSUB_4BIT M1(A,B,Sel,Cout,Sum);

initial begin
A<=4'b0000; B<=4'b0000; Sel <=1'b0; //0000, 0
#10 A <= 4'b0011; B<=4'b0100; Sel<=1'b0;//0111, 0
#10 A <= 4'b0011; B<=4'b0100; Sel<=1'b1;//0001, 1
#10 A <= 4'b0111; B<=4'b0011; Sel<=1'b0;//1010, 0
#10 A <= 4'b0111; B<=4'b0011; Sel<=1'b1;//1100, 0
#10 A <= 4'b0100; B<=4'b1000; Sel<=1'b0;//1100, 0
#10 A <= 4'b0100; B<=4'b1000; Sel<=1'b1;//0100, 1
#10 A <= 4'b1110; B<=4'b0101; Sel<=1'b0;//0011, 1
#10 A <= 4'b1110; B<=4'b0101; Sel<=1'b1;//0111, 0
end

endmodule


// JK-FlipFlop Module
module JK_flipflop (clk, RESET, K, J, Q, Qbar);
input clk, RESET, K, J;
output Q, Qbar;
reg Q;
// JK f/f
assign Qbar = ~Q;
always @(negedge clk, negedge RESET)
begin
if(!RESET)
Q <= 0;
else if (K==0 && J==0)
Q <= Q;
else if (K==1 && J==0)
Q <= 0;
else if (K==0 && J==1)
Q <= 1;
else
Q <= ~Q;
end
endmodule



// 3bits Ripple Down Counter
module rippleDownCounter (clk, CLR, Q, Qbar);
input clk, CLR;
output [2:0] Q, Qbar;
supply1 H;
JK_flipflop U0 (clk, CLR, H, H, Q[0], Qbar[0]);
JK_flipflop U1 (Qbar[0], CLR, H, H, Q[1], Qbar[1]);
JK_flipflop U2 (Qbar[1], CLR, H, H, Q[2], Qbar[2]);
endmodule

