`timescale 10ns/1ps

module LAB03_ADDER_4BIT_TB;

reg [3:0] A,B;
reg Cin;
wire Cout;
wire [3:0] S;

LAB03_ADDER_4BIT M1(A,B,Cin,Cout,S);

initial begin
A<=4'b0000; B<=4'b0000; Cin <=0; //0, 0000
#10 A <= 4'b0100; B<=4'b0011; Cin<=1'b1;//0, 1000
#10 A <= 4'b0011; B<=4'b0111; Cin<=1'b1;//0, 1011
#10 A <= 4'b0101; B<=4'b0001; Cin<=1'b0;//0, 0110
#10 A <= 4'b0101; B<=4'b1110; Cin<=1'b1;//1, 0100
#10 A <= 4'b1100; B<=4'b1101; Cin<=1'b0;//1, 1001
#10 A <= 4'b1011; B<=4'b1100; Cin<=1'b0;//1, 0111
#10 A <= 4'b1101; B<=4'b1010; Cin<=1'b1;//1, 1000


end

endmodule
