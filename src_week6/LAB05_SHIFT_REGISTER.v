module LAB05_SHIFT_REGISTER(CLK,SI,SO);
 input CLK,SI;
 output [3:0] SO;
 wire [3:0] NSO;
 LAB05_D_FF F1(.CLK(CLK), .D(SI), .Q(SO[0]), .NQ(NSO[0]));
 LAB05_D_FF F2(.CLK(CLK), .D(SO[0]), .Q(SO[1]), .NQ(NSO[1]));
 LAB05_D_FF F3(.CLK(CLK), .D(SO[1]), .Q(SO[2]), .NQ(NSO[2]));
 LAB05_D_FF F4(.CLK(CLK), .D(SO[2]), .Q(SO[3]), .NQ(NSO[3]));
 endmodule