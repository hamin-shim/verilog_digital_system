module LAB04_BINTOBCD(B,P);
input [3:0] B;
output [9:0] P;

wire [10:0] T;
LAB04_LINEDECODER C1(0,0,0,B[3],T[3],T[2],T[1],T[0]);
LAB04_LINEDECODER C2(T[2],T[1],T[0],B[2],T[7],T[6],T[5],T[4]);
LAB04_LINEDECODER C3(0,0,0,T[3],P[9],T[10],T[9],T[8]);
LAB04_LINEDECODER C4(T[6],T[5],T[4],B[1],P[4],P[3],P[2],P[1]);
LAB04_LINEDECODER C5(T[10],T[9],T[8],T[7],P[8],P[7],P[6],P[5]);
assign P[0] = B[0];
endmodule