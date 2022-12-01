module TOP(rst, clk, keypad_in, seg_display, array_en);
  input rst,clk;
  input [11:0]keypad_in;
  output [6:0]seg_display;
  output [7:0]array_en;
  wire [11:0]scan_out;
  wire valid;
  wire [7:0]r0,r1,r2,r3,r4,r5,r6,r7;
  wire [7:0]seg_0,seg_1,seg_2,seg_3,seg_4,seg_5,seg_6,seg_7;
  wire en;
  
  keypad_scan KS(rst, clk, keypad_in, scan_out, valid);
  display DP(rst, clk, scan_out, valid, r0,r1,r2,r3,r4,r5,r6,r7, en);
  register RG1(clk, rst, r0, en, seg_0);
  register RG2(clk, rst, r1, en, seg_1);
  register RG3(clk, rst, r2, en, seg_2);
  register RG4(clk, rst, r3, en, seg_3);
  register RG5(clk, rst, r4, en, seg_4);
  register RG6(clk, rst, r5, en, seg_5);
  register RG7(clk, rst, r6, en, seg_6);
  register RG8(clk, rst, r7, en, seg_7);
  seg_controller SC(clk, rst, seg_0, seg_1, seg_2, seg_3, seg_4, seg_5, seg_6, seg_7, seg_display, array_en);

endmodule