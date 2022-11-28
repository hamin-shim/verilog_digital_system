module SIMPLECOMPUTER(CLK, OutData, Reg0, Reg1, Reg2, Reg3, ControlWord, AData, BData, Constant, DataIn, PC);
input CLK;
output [3:0] OutData; // multiplication result
output [3:0] Reg0, Reg1, Reg2, Reg3; // of Register File
output [12:0] ControlWord;
output [3:0] AData, BData, Constant, DataIn, PC;
 
//write your code
 
wire [1:0] DA,AA,BA;
wire MB,MD,RW,PL,MW;
wire [3:0] FS;

assign ControlWord[0]=RW;
assign ControlWord[1]=MD;
assign ControlWord[5:2]=FS;
assign ControlWord[6]=MB;
assign ControlWord[8:7]=BA;
assign ControlWord[10:9]=AA;
assign ControlWord[12:11]=DA;

ControlUnit U0(CLK, AData, DA, AA, BA, MB, FS, MD, RW, MW,  Constant, PC);
DATAPATH U0(CLK, ControlWord, Constant, DataIn, Reg0, Reg1, Reg2, Reg3,AData, BData);
Data_Memory U0(CLK,MW,AData,BData,DataIn);

assign OutData = DataIn;
endmodule
 
