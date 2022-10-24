module LAB03_MULTI_4BIT(
    A,B,Cout
);

    input [3:0] A,B;
    output [7:0] Cout;

    wire [4:0] Sum1,Sum2;
    wire [3:0] D;

    assign D[0] = (A[0] & B[1]);
    assign D[1] = (A[0] & B[2]);
    assign D[2] = (A[0] & B[3]);
    assign D[3] = 0;

    assign Cout[0] = A[0]&B[0];

    LAB03_MULTI_4x1 U0(A[1],B,D,Sum1[4],Sum1[3:0]);
    assign Cout[1] = Sum1[0];

    LAB03_MULTI_4x1 U1(A[2],B,Sum1[4:1],Sum2[4],Sum2[3:0]);
    assign Cout[2] = Sum2[0];

    LAB03_MULTI_4x1 U2(A[3],B,Sum2[4:1],Cout[7],Cout[6:3]);

endmodule

