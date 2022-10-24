module LAB03_ADDSUB_4BIT(
	a,b,sel,c_out,sum
);
	input [3:0]a;
	input [3:0]b;
	input sel;
	output [3:0]sum;
	output c_out;
	
	wire [3:0] cmpl;
	assign cmpl=a^{4{sel}};

	LAB03_ADDER_4BIT U1 (cmpl,b,sel,c_out,sum);
endmodule