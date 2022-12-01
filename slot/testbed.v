module testbed();
  wire coin_out,bypass;
  wire [2:0]slot_a1;
  wire [2:0]slot_a2;
  wire [2:0]slot_a3;
  wire [2:0]slot_b1;
  wire [2:0]slot_b2;
  wire [2:0]slot_b3;
  wire [2:0]slot_c1;
  wire [2:0]slot_c2;
  wire [2:0]slot_c3;
  reg clrb, clk, coin_in, btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9;

  slotmachine my_slotmachine(slot_a1,slot_a2,slot_a3,slot_b1,slot_b2,slot_b3,slot_c1,slot_c2,slot_c3,coin_out,bypass,btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9,clrb,clk,coin_in);

  initial begin
  btn1 = 1'b0; btn2 = 1'b0; btn3 = 1'b0; btn4 = 1'b0; btn5 = 1'b0; btn6 = 1'b0; btn7 = 1'b0; btn8 = 1'b0; btn9 = 1'b0; clk = 1'b0; coin_in = 1'b0; clrb = 1'b1;
  #1 clrb = 1'b0;
  #1 clrb = 1'b1;
  #25
  #25
  #14 coin_in = 1'b1;
  #14 coin_in = 1'b0;
  #25 
  #14 
  #20 coin_in = 1'b1;
  #14 coin_in = 1'b0;
  #14 btn2 = 1'b1;
  #25
  #25 btn1 = 1'b1;
  #14 btn3 = 1'b1;
  #25 btn8 = 1'b1;
  #25 
  #25 
  #25 btn4 = 1'b1;
  #25 btn5 = 1'b1;
  #25 btn6 = 1'b1;
  #25 btn7 = 1'b1;
  #25 btn9 = 1'b1;
  #25  
  #25
  #25 btn1 = 1'b0; btn2 = 1'b0; btn3 = 1'b0; btn4 = 1'b0; btn5 = 1'b0; btn6 = 1'b0; btn7 = 1'b0; btn8 = 1'b0; btn9 = 1'b0;  
  #25
  #25
  #25 
  #50
  #25
  #25 coin_in = 1'b1;
  #15 coin_in = 1'b0;
  #50;
  end

  always #14 clk = ~clk;

  initial begin
  #800 $finish;
  end

endmodule
