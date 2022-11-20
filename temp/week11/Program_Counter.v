module Program_Counter(CLK, PL, JB, BC, LAddress, RAddress, AData, PC);
input CLK, PL, JB, BC;
input [1:0] LAddress, RAddress;
input [3:0] AData;
output [3:0] PC;

// write your code for reading/writing
reg [3:0] PC;
initial begin 
	PC = 4'b0000; 
end
always @(posedge CLK) begin
	if(PL==0) PC = PC+1;
	else if(JB) PC = AData;
	if(BC) begin
		if(AData[3]) PC = PC+{LAddress,RAddress};
		else PC = PC+1;
	end
	if(BC==0) begin
		if(AData == 4'b0000) PC = PC+{LAddress,RAddress};
		else PC = PC+1;
	end
end
endmodule