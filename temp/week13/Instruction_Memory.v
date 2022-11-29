module Instruction_Memory(CLK,WR,A,D_IN,Q);
input CLK, WR;
input [3:0] A; // address
input [12:0] D_IN; // input instruction
output [12:0] Q; // output instruction

reg [12:0] SRAM [15:0];

initial begin
//multiply
SRAM[0]=13'b1100000100111;  //BRZ R1 1011
SRAM[1]=13'b0000010111100; //add r3 r3 r0 pc=0001

SRAM[2]=13'b0000110010101;// DECREMENT R1 R1 01, PC=0010
SRAM[3]=13'b1110000001000;// JUMP 00 R2 00, PC=0011

//main
SRAM[5]=13'b1000010000000;// ADDI R0 R0 00, PC=0101
SRAM[6]=13'b1000010010101;// ADDI R1 R1 01, PC=0110
SRAM[7]=13'b0010000000000;// LOAD R0 M(R0) 00, PC=0111
SRAM[8]=13'b0010000010100;// LOAD R1 M(R1) 00, PC=1000
SRAM[9]=13'b1000010101000;// ADDI R2 R2 00, PC=1001
SRAM[10]=13'b1110000001000;// JUMP 00 R2 00 , PC=1010
SRAM[11]=13'b0100000001011;// STORE 00 R2 R3, PC=1011

// add  0000010
// load 0010000
// decrement 0000110
// jump 1110000
// addi 1000010
end

// write your code for reading/writing
always @(posedge CLK) begin
	if(WR) SRAM[A] = D_IN;
end
assign Q = SRAM[A];
endmodule