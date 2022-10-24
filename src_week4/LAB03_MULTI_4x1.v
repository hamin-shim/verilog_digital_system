module LAB03_MULTI_4x1(A,B,C,c_out,sum);
	input A;
	input [3:0] B,C;
	output c_out;
	output [3:0] sum;
    wire [3:0] D;

    assign D[0] = (A & B[0]);
    assign D[1] = (A & B[1]);
    assign D[2] = (A & B[2]);
    assign D[3] = (A & B[3]);

    LAB03_ADDER_4BIT U1(C,D,0,c_out,sum);
endmodule

