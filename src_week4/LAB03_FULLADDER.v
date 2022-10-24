module LAB03_FULLADDER(
	x,y,c_in,s,c_out
);
	input x,y,c_in;
	output s,c_out;
	
	assign s = x^y^c_in;
	assign c_out = (x&y)||((x^y)&c_in);
endmodule