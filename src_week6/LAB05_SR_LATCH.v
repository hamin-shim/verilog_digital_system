//SR Latch
module LAB05_SR_LATCH(S,R,Q,NQ);
 input S, R;
 output Q, NQ;
 

 //SR Latch 설계
 assign Q = ~(S&NQ);
 assign NQ = ~(R&Q);


endmodule

