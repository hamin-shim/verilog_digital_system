/**************************************************************************/
/* Register File                         */
/* INPUT : CLK, Ddata, Write, Daddr, Aaddr, Baddr                        */
/* OUTPUT : Adata, Bdata, Reg0, Reg1, Reg2, Reg3 // For Debugging    */
/*******************************************************/
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
 
DECODER2to4 U0(Daddr,L0,L1,L2,L3);

always @(posedge CLK) begin
    if(Write == 1)begin
        if ({L0,L1,L2,L3} == 4'b1000) begin
        R0 = Ddata;
        end
        else if ({L0,L1,L2,L3} == 4'b0100) begin
        R1 = Ddata;
        end
        else if ({L0,L1,L2,L3} == 4'b0010) begin
        R2 = Ddata;
        end
        else if ({L0,L1,L2,L3} == 4'b0001) begin
        R3 = Ddata;
        end
        


    end
end


MUX4to1 U1(R3, R2, R1, R0,Aaddr,Adata);
MUX4to1 U2(R3, R2, R1, R0,Baddr,Bdata);
assign Reg0  =  R0;
assign Reg1  =  R1;
assign Reg2  =  R2;
assign Reg3  =  R3;
endmodule
 
// 1. Register File 모듈 구현
// - 4개의 Register로 구성된 Register File 모듈을 구현한다. 4개의 Register로 구성되어 있기 때문에 Destination Address, A Address, B Address 등은 2bit 의 값을 가지게 된다. 각각의 Register는 4bit의 값을 저장하도록 구현한다. 
// - Clock, Destination Address, Destination Data, Write, A Address, B Address 를 입력으로 하고, A Data, B Data를 출력으로 하는 모듈을 작성한다. 
// - Write는 Clock의 Positive Edge에서 발생하도록 구현한다.
/*******************************************************/
 
 
 
 
 
 
/*******************************************************/
/*      InputLogic                         */
/* INPUT  : Bdata, S1,S0 (Selection Bit)               */
/* OUTPUT : Bout                            */
/*******************************************************/
module InputLogic(Bdata, S1, S0, Bout);
input [3:0] Bdata;
input S1, S0;
output [3:0] Bout;
 
MUX4to1 U3 (4'b1111, Bdata^4'b1111, Bdata, 4'b0000,S1,S2,Bout)
endmodule

// - 위 그림에서 Input 부분을 작성
// - MUX4to1 함수 호출,  4’b1111, Bdata^4’b1111, Bdata, 4’b0000 할당
/*******************************************************/
 
/*******************************************************/
/* Arithmetic Circuit                         */
/* INPUT  : Adata, Bdata, S1, S0, Cin                  */
/* OUTPUT : Gout (Value), Cout (Carry)      */
/*******************************************************/
module ArithmeticCircuit(Adata, Bdata, S1, S0, Cin, Gout, Cout);
input [3:0] Adata, Bdata;
input S1,S0,Cin;
output [3:0] Gout;
output Cout;
 
wire [3:0] LogicOut ;
InputLogic U0(Bdata, S1, S0, LogicOut);
ADDER_4BIT U1(Adata,LogicOut,Cin,Cout,Gout);
endmodule

// - wire 4bit로  LogicOut 선언
//   - InputLogic 함수 호출하여 값 할당
//   - ADDER_4BIT 함수 호출하여 InputLogic 결과와 Adata 입력으로 할당
/*******************************************************/
 
/*******************************************************/
/* Logic Circuit        */
/* INPUT  : Adata, Bdata, S1, S0      */
/* OUTPUT : Gout                          */
/*******************************************************/
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

// - wire 4bit로 logic0~logic3 선언
// - 회로도와 같이 logic0에 Adata&Bdata을 assign한다. 회로도에 따라  logic1~3까지 assign 반복한다.
// - MUX4to1 함수 호출하여 assign 결과를 logic3~logic0순서로 할당
/*******************************************************/
 
 
/*******************************************************/
/* Function Unit       */
/* INPUT  : Adata, Bdata, FS     */
/* OUTPUT : Fout                         */
/*******************************************************/
module FunctionUnit(Adata, Bdata, FS, Fout);
input [3:0] Adata, Bdata;
input [3:0] FS;
output [3:0] Fout;

wire [3:0] ArithOut,LogicOut;
wire Cout;

ArithmeticCircuit U0(Adata, Bdata, FS[2], FS[3], FS[0], , );
MUX2to1 U1(LogicOut,ArithOut,FS[1],Fout)
// endmodule
//  - Arithmetic의 V,C,N 출력 무시, Shifter, Zero Detect 부분 무시
//   - wire 4bit로 ArithOut, LogicOut 선언
//   - wire로 Cout 부분 선언
//   - ArithmeticCircuit 함수 호출하여 (A, B data 입력, S1, S0, Cin 자리는 FS의 {Cin,S2,S1,S0}순서를 참고하여 입력, ArithOut, Cout) 순으로 입력한다.
//   - LogicCircuit 함수 호출, (A,B data, FS의 S1, S0입력, Logicout)순으로 입력한다.
//   - MUX2to1 함수 호출, LogicOut과 ArithOut중 선택하여 FS의 S2에 따라 Fout결과 출력 결정


// 2. Function Unit 모듈 구현 
// - Function Unit은 Arithmetic Circuit, Logic Circuit으로 구성된다. 
// - A Data, B Data, {Cin, S2, S1, S0}의 4bit 입력에 따라 4bit의 연산 결과를 출력하는 회로를 구현한다.
/*******************************************************/
 
 
/*******************************************************/
/* DATAPATH Circuit      */
/* INPUT  : CLK, ControlWord, ConstantIn, DataIn       */
/* OUTPUT : Reg0, Reg1, Reg2, Reg3                  */
/*******************************************************/
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
assign DA = ControlWord[0:1];
assign AA = ControlWord[2:3];
assign BA = ControlWord[4:5];
assign MB = ControlWord[6];
assign FS = ControlWord[7:10];
assign MD = ControlWord[11];
assign RW = ControlWord[12];


RegisterFile U0(CLK, Ddata, RW, DA, AA, BA, Adata, Bdata, Reg0,Reg1,Reg2,Reg3);
MUX2to1 U1(ConstantIn, Bdata,MB,MUXBout);
FunctionUnit  U2(Adata, MUXBout, FS, Fout);
MUX2to1 U3(DataIn,Fout,MD,{??});
endmodule
// /*******************************************************/
// 3. Data Path 모듈 구현 및 시뮬레이션
// - Register File, Function Unit 그리고 MUX B, MUX D를 연결하여 전체 Data Path 회로를 구현하고 결과를 시뮬레이션 한다. 
// - Control Word 는 13bit 로 정의된다.

//  - wire 4bit로 Ddata, Adata, Bdata 선언
//   - wire 4bit로 MUXBout, Fout 선언
//   - 위 그림이 DATAPATH 모듈에서 작성하는 ControlWord 13bit 이를 이용하여 아래 함수 호출 과정의 인자로 활용
//      RegisterFile함수 호출  // 데이터 입력
//      MUX2to1 함수 호출 //ConstantIn와 Bdata중 MB에 따라 선택
//      FunctionUnit 함수 호출 // Adata와 위의 MUX결과와 연산(FS에 따라 연산 결정)
//      MUX2to1 함수 호출  //DataIn과 FunctionUnit 연산결과 중 MD에 따라 저장할 것을 선택

// - Data Path를 통해 Micro Operation의 수행을 정의, 제어하기 위한 입력
//  - DA : 연산 결과를 저장할 레지스터 주소
//  - AA : 첫 번째 입력 A가 저장된 레지스터 주소
//  - BA : 두 번째 입력 B가 저장된 레지스터 주소
//  - MB : 두 번째 입력 값을 B와 Constant와 선택하기 위한 MUX
//  - FS : ALU에서의 수행할 연산을 결정하는 함수, Function Selection {Cin, S2, S1, S0}
//  - MD : 연산 수행을 저장할지, 외부로부터의 새로운 데이터를 저장할지 결정
//  - RW : 연산 결과를 저장할지 결정