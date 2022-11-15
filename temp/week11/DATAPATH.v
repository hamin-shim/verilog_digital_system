module RegisterFile(CLK, Ddata, Write, Daddr, Aaddr, Baddr, Adata, Bdata, Reg0,Reg1,Reg2,Reg3);

input CLK;
input [3:0] Ddata;
input [1:0] Daddr, Aaddr, Baddr;
input Write;

output [3:0] Adata;
output [3:0] Bdata;
output [3:0] Reg0, Reg1, Reg2, Reg3;

reg [3:0] R0, R1, R2, R3;

wire [3:0] L0,L1,L2,L3;

DECODER2to4 U0(Daddr[1], Daddr[0],L3,L2,L1,L0);

always @(posedge CLK) begin
    if(Write == 1)begin
        if (L0) R0 = Ddata;
        else if (L1) R1 = Ddata;
        else if (L2) R2 = Ddata;
        else if (L3) R3 = Ddata;
    end
end


MUX4to1 U1(R3, R2, R1, R0,Aaddr[1],Aaddr[0],Adata);
MUX4to1 U2(R3, R2, R1, R0,Baddr[1],Baddr[0],Bdata);
assign Reg0  =  R0;
assign Reg1  =  R1;
assign Reg2  =  R2;
assign Reg3  =  R3;
endmodule

module InputLogic(Bdata, S1, S0, Bout);
input [3:0] Bdata;
input S1, S0;
output [3:0] Bout;

MUX4to1 U3 (4'b1111, Bdata^4'b1111, Bdata, 4'b0000,S1,S0,Bout);
endmodule

module ArithmeticCircuit(Adata, Bdata, S1, S0, Cin, Gout, Cout);
input [3:0] Adata, Bdata;
input S1,S0,Cin;
output [3:0] Gout;
output Cout;

wire [3:0] LogicOut;
InputLogic U0(Bdata, S1, S0, LogicOut);
ADDER_4BIT U1(Adata,LogicOut,Cin,Cout,Gout);
endmodule

module LogicCircuit(Adata, Bdata, S1, S0, Gout);
input [3:0] Adata, Bdata;
input S1, S0;
output [3:0] Gout;
wire [3:0] logic0,logic1,logic2,logic3;
assign logic0 = Adata&Bdata;
assign logic1 = Adata|Bdata;
assign logic2 = Adata^Bdata;
assign logic3 = ~Adata;

MUX4to1 U0(logic3,logic2,logic1,logic0,S1,S0,Gout);
endmodule

module FunctionUnit(Adata, Bdata, FS, Fout);
input [3:0] Adata, Bdata;
input [3:0] FS;
output [3:0] Fout;

wire [3:0] ArithOut,LogicOut;
wire Cout;

ArithmeticCircuit U0(Adata, Bdata, FS[1], FS[0], FS[3], ArithOut, Cout);
LogicCircuit U1(Adata, Bdata, FS[1], FS[0], LogicOut);
MUX2to1 U2(LogicOut,ArithOut,FS[2],Fout);
endmodule

module DATAPATH(CLK, ControlWord, ConstantIn, DataIn, Reg0, Reg1, Reg2, Reg3);
input [12:0] ControlWord;
input [3:0] ConstantIn;
input [3:0] DataIn;
input CLK;
output [3:0] Reg0, Reg1, Reg2, Reg3;

wire [3:0] Ddata, Adata, Bdata;
wire [3:0] MUXBout, Fout;
wire [1:0] DA,AA,BA;
wire  MB,MD,RW;
wire [3:0] FS;

assign DA = ControlWord[12:11];
assign AA = ControlWord[10:9];
assign BA = ControlWord[8:7];
assign MB = ControlWord[6];
assign FS = ControlWord[5:2];
assign MD = ControlWord[1];
assign RW = ControlWord[0];

// RegisterFile(CLK, Ddata, Write, Daddr, Aaddr, Baddr, Adata, Bdata, Reg0,Reg1,Reg2,Reg3)
RegisterFile U0(CLK, Ddata, RW, DA, AA, BA, Adata, Bdata, Reg0,Reg1,Reg2,Reg3);
MUX2to1 U1(ConstantIn, Bdata,MB,MUXBout);
// FunctionUnit(Adata, Bdata, FS, Fout)
FunctionUnit U2(Adata, MUXBout, FS, Fout);
MUX2to1 U3(DataIn,Fout,MD,Ddata);

endmodule