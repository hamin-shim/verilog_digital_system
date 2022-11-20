module Instruction_Decoder(Instruction, DA, AA, BA, MB, FS, MD, RW, MW, PL, JB, BC);
input [12:0] Instruction;
output [1:0] DA, AA, BA;
output MB, MD, RW, MW, PL, JB, BC;
output [3:0] FS;
// write your code for reading/writing
wire w1,w2,w3,w4,w5,w6;
assign w1 = ~w6;
assign w2 = ~Instruction[11];
assign w3 = ~Instruction[12];
assign w4 = Instruction[6] & w1;
assign w5 = Instruction[11] & w3;
assign w6 = Instruction[11] & Instruction[12];
assign DA = Instruction[5:4];
assign AA = Instruction[3:2];
assign BA = Instruction[1:0];
assign MB = Instruction[12];
assign FS = {Instruction[9:7],w4};
assign MD = Instruction[10];
assign RW = w2;
assign MW = w5;
assign PL = w6;
assign JB = Instruction[10];
assign BC = Instruction[6];
endmodule