module LAB07_MEMORY_APP(CLK,WR,RD,A1,A2,D_IN,oS_COM,oS_ENS);

input CLK, WR, RD;
input [2:0] A1, A2;
input [8:0] D_IN;
output [7:0] oS_COM;
output [6:0] oS_ENS;
reg [3:0] SRAM [7:0];
wire P9,P8,P7,P6,P5,P4,P3,P2,P1,P0;
wire a1,b1,c1,d1,e1,f1,g1;
wire a2,b2,c2,d2,e2,f2,g2;
wire [3:0] Q;

always @(posedge CLK) begin
	if(WR) begin
		case(D_IN)
			9'b000000001 :SRAM[A1] <= 4'b0001;
			9'b000000010 :SRAM[A1] <= 4'b0010;
			9'b000000100 :SRAM[A1] <= 4'b0011;
			9'b000001000 :SRAM[A1] <= 4'b0100;
			9'b000010000 :SRAM[A1] <= 4'b0101;
			9'b000100000 :SRAM[A1] <= 4'b0110;
			9'b001000000 :SRAM[A1] <= 4'b0111;
			9'b010000000 :SRAM[A1] <= 4'b1000;
			9'b100000000 :SRAM[A1] <= 4'b1001; 
			default :SRAM[A1] <= 4'b0000;
		endcase
	end
end

MUX_2to1 U0 (4'bz, (SRAM[A1]+SRAM[A2]), RD, Q);
Binary_to_BCD U1 (Q[3],Q[2],Q[1],Q[0],P9,P8,P7,P6,P5,P4,P3,P2,P1,P0);
BCD_to_7segment U2 (P3,P2,P1,P0,a1,b1,c1,d1,e1,f1,g1);
BCD_to_7segment U3 (P7,P6,P5,P4,a2,b2,c2,d2,e2,f2,g2);
SevenSeg_CTRL U4 (CLK,0,0,0,0,0,0,0,{a2,b2,c2,d2,e2,f2,g2},{a1,b1,c1,d1,e1,f1,g1},oS_COM,oS_ENS);

endmodule
