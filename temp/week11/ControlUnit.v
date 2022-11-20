module ControlUnit(CLK, AData, DA, AA, BA, MB, FS, MD, RW, MW,  Constant, PC);
input CLK;
input [3:0] AData;

output [3:0] Constant;
output [1:0] DA, AA, BA;
output MB, MD, RW, MW;
output [3:0] FS;
output [3:0] PC;

// write your code for reading/writing
wire [12:0] Instruction;
//wire [3:0] PC;
wire PL,JB,BC;
//Instruction_Memory(CLK,WR,A,D_IN,Q);
Instruction_Memory U0 (CLK,0,PC,0,Instruction);
//Instruction_Decoder(Instruction, DA, AA, BA, MB, FS, MD, RW, MW, PL, JB, BC);
Instruction_Decoder U1 (Instruction, DA, AA, BA, MB, FS, MD, RW, MW, PL, JB, BC);
//Program_Counter(CLK, PL, JB, BC, LAddress, RAddress, AData, PC);
Program_Counter U2 (CLK, PL, JB, BC, DA, BA, AData, PC);
assign Constant = {1'b0, 1'b0, Instruction[1:0]};
endmodule