`timescale 10ns/1ps
module LAB07_MEMORY_APP_TB;
  
reg CLK,WR,RD;
reg [8:0]D_IN;
reg [2:0] A1, A2;
	
LAB07_MEMORY_APP U1(CLK,WR,RD,A1,A2,D_IN,oS_COM,oS_ENS);

initial 
begin
CLK<=1'b0;
WR<=1'b1;
RD<=1'b1;
A1<=4'b0000;
A2<=4'b0000;
D_IN<=4'b0000;
end

initial 
begin
#10 WR<=1'b0; A1<=4'b0101; D_IN<=9'b000000001;
#10 A1<=4'b0000; D_IN<=9'b000000100; 
#10 WR<=1'b1; A1<=4'b0101;RD=1'b0;

end

  
initial
forever #5 CLK<=~CLK;

endmodule