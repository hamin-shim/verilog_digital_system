module LAB07_16x4RAM(CLK,WR,RD,A,D_IN,Q);
input CLK, WR, RD;
input [3:0] A;
input [3:0] D_IN;
output [3:0] Q;
reg [3:0] SRAM [15:0];

always @(posedge CLK) begin
	if(WR) SRAM[A] = D_IN;
end
assign Q = (RD==0) ? SRAM[A] : 4'bz;
endmodule

