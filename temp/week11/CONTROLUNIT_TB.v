`timescale 10ns/1ps

module CONTROLUNIT_TB;
reg CLK;
reg [3:0] AData;
wire [1:0] DA, AA, BA;
wire MB, MD, RW, MW;
wire [3:0] FS;
wire [3:0] Constant;
wire [3:0] PC;

ControlUnit CU(CLK, AData, DA, AA, BA, MB, FS, MD, RW, MW, Constant, PC);

initial begin
AData<=4'b0110;CLK<=0;
end

always #5
	CLK = ~CLK;

endmodule
