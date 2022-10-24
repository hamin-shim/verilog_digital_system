module LAB01_PRACTICE(
	inp1, inp2, res
);

	input inp1, inp2;
	output res;
	wire t1, t2;
	
	assign t1 = ~(inp1 & inp1);
	assign t2 = ~(inp2 & inp2);
	
	assign res = ~(t1&t2);
	
endmodule