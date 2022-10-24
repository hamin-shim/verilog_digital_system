`timescale 10ns/1ps

module LAB03_MULTI_4BIT_TB;

reg [3:0] A,B;
wire [7:0] Cout;

LAB03_MULTI_4BIT M1(A,B,Cout);

initial begin
A<=4'b0000; B<=4'b0000; //00000000
#10 A <= 4'b0100; B<=4'b0011;//00001100
#10 A <= 4'b0011; B<=4'b0111;//00010101 
#10 A <= 4'b1000; B<=4'b0100;//00100000
#10 A <= 4'b0101; B<=4'b1110;//01000110
#10 A <= 4'b0101; B<=4'b0110;//00011110
end

endmodule

