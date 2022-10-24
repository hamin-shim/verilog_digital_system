module LAB03_FULLADDER(
	x,y,c_in,s,c_out
);
	input x,y,c_in;
	output s,c_out;
	
	assign s = x^y^c_in;
	assign c_out = (x&y)||((x^y)&c_in);
endmodule

module LAB03_ADDER_4BIT(
	a,b,c_in,c_out,sum
);
	input [3:0]a;
	input [3:0]b;
	input c_in;
	output [3:0]sum;
	output c_out;
	wire c1, c2, c3;
	LAB03_FULLADDER f0(a[0],b[0],c_in,sum[0],c1);
	LAB03_FULLADDER f1(a[1],b[1],c1,sum[1],c2);
	LAB03_FULLADDER f2(a[2],b[2],c2,sum[2],c3);
	LAB03_FULLADDER f3(a[3],b[3],c3,sum[3],c_out);
	
endmodule


module LAB03_4BIT_ABS(
	a,b,sum
);
	input [3:0]a;
	input [3:0]b;
	wire sel;
	output [3:0]sum;
	wire c_out;
	assign sel = a[3];
	wire [3:0] cmpl;
	assign cmpl = (sel==1) ? (a^{4{sel}}+4'b0001) : a;
	LAB03_ADDER_4BIT U1 (cmpl,b,0,c_out,sum);
	
endmodule