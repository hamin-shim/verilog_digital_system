
 module LAB05_REGISTER(CLK, D, Q);

 input CLK;
 input [3:0] D;
 output [3:0] Q;
 wire [3:0] NQ;
 LAB05_D_FF U1(.CLK(CLK), .D(D[0]), .Q(Q[0]), .NQ(NQ));
 LAB05_D_FF U2(.CLK(CLK), .D(D[1]), .Q(Q[1]), .NQ(NQ));
 LAB05_D_FF U3(.CLK(CLK), .D(D[2]), .Q(Q[2]), .NQ(NQ));
 LAB05_D_FF U4(.CLK(CLK), .D(D[3]), .Q(Q[3]), .NQ(NQ));
 endmodule

