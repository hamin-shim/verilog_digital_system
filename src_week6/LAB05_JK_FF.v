
module LAB05_JK_FF(J,K,CLK,Q,NQ);
//입력, 출력, wire
input J,K,CLK;
output Q,NQ;
wire w1,w2,w3;

assign w1 = NQ&J;
assign w2 = ~K&Q;
assign w3 = w1|w2;

//D FF 함수호출, CLK 설정 주의!
LAB05_D_FF F1(.CLK(CLK), .D(w3), .Q(Q), .NQ(NQ));

endmodule
