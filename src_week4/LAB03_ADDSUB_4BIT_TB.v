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


