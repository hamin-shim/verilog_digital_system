module Instruction_Memory(CLK,WR,A,D_IN,Q);
input CLK, WR;
input [3:0] A; // address
input [12:0] D_IN; // input instruction
output [12:0] Q; // output instruction

reg [12:0] SRAM [15:0];

initial begin
SRAM[0] = 13'b1000010011011; // 1000010(Add Immediate) 01(R1) 10(R2) 11(3), R1 = R2 + 3
SRAM[1] = 13'b0010000100100; // 0010000(Load) 10(R2) 01(R1), R2 = M(R1);
SRAM[2] = 13'b1110000001100; // 1110000(Jump), PC = R3;
// SRAM[2] = 13'b0000010111001; // 0000010(Add), R3 = R2+R1;
// SRAM[3] = 13'b1110000001100; // 1110000(Jump), PC = R3; 
end

// write your code for reading/writing
always @(posedge CLK) begin
	if(WR) SRAM[A] = D_IN;
end
assign Q = SRAM[A];
endmodule