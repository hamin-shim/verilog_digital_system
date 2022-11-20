module Data_Memory(CLK,WR,A,D_IN,Q);
input CLK, WR;
input [3:0] A;
input [3:0] D_IN;
output [3:0] Q;

// write your code for reading/writing
reg [3:0] SRAM [16:0];
always @(posedge CLK) begin
	if(WR) SRAM[A] = D_IN;
end
assign Q = SRAM[A];
endmodule