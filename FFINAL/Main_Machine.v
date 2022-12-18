module Main_Machine (
    CLK, RST, C_IN, GAME_START,SBTN1,SBTN2,SBTN3, SEG_COM, SEG_DATA, LCD_DATA, LCD_E,LCD_RS,LCD_RW,LED_OUT
);  
  //parameter
  parameter s0 = 3'b000;
  parameter s1 = 3'b001;
  parameter s2 = 3'b010;
  parameter s3 = 3'b011;
  parameter s4 = 3'b100;
  parameter s5 = 3'b101;
  parameter s6 = 3'b110;
  parameter random1 = 150;

  //input & output
  input CLK, RST, C_IN, GAME_START, SBTN1,SBTN2,SBTN3;
  
  output [7:0] SEG_COM, SEG_DATA,LCD_DATA,LED_OUT;
  output LCD_E,LCD_RS,LCD_RW;
  
  //wire & reg 
  wire [3:0] seg1, seg2,seg3;
  wire [3:0] coin_seg1, coin_seg2;
  wire clk_2, clk_4, clk_6;
  wire [6:0] SEG1,SEG2,SEG3,COIN_1,COIN_10,CNT;
  wire [7:0] cur_coin_bcd;

  reg [6:0] cur_coin;
  reg STOP1,STOP2,STOP3,LED_IN;
  reg [1:0] gameset;
  reg [3:0] cur_state;
  reg [3:0] nxt_state;
  
  //clk divider
  clk_divide CK1(CLK, RST, clk_2, clk_4, clk_6);

  //RST or state transition
  always @ (posedge RST or posedge CLK) begin
	if (RST) begin
	  cur_state <= s0;
	  nxt_state <= s0;
	end
  else begin 
    cur_state <= nxt_state;
    case (cur_state)
    s0 :begin
      cur_coin <= 0;
		  STOP1 <= 1;
		  STOP2 <= 1;
		  STOP3 <= 1;
		  LED_IN<=0;
		  if(C_IN == 1'b1) begin
		  	gameset <= 1'b1;
		  	cur_coin <= 1;
		  	nxt_state <= s1;
      end
      else begin
		  	gameset <= 1'b0;
		  	nxt_state <= s0;
      end
	  end
    s1 :begin
      if(C_IN == 1'b1) begin
        cur_coin <= cur_coin + 1;
        nxt_state <= s1;
      end
      if(GAME_START == 1'b1 )begin
        if(cur_coin>0) nxt_state <= s2;
      end
		  else begin
		  nxt_state <= s1;
		  end
		end
    s2 : begin
			STOP1<=0;
			STOP2<=0;
			STOP3<=0;
			LED_IN<=1;
			if(SBTN1 == 1'b1) begin
				STOP3 <= 1;
        nxt_state <= s3;
      end
			else nxt_state <= s2;
		end
    s3 : begin
			STOP1<=0;
			STOP2<=0;
			LED_IN<=1;
			if(SBTN2 == 1'b1) begin
				STOP2 <= 1;
				nxt_state <= s4;
			end
			else nxt_state <= s3;
    end
    s4 : begin
			STOP1<=0;
			LED_IN<=1;
			if(SBTN3 == 1'b1) begin
				STOP1 <= 1;
				nxt_state <= s5;
			end
      else nxt_state = s4;
    end
    s5: begin
	    STOP1<=1;
	    STOP2<=1;
	    STOP3<=1;
	    LED_IN<=0;
      if(seg1==seg2==seg3) cur_coin <= cur_coin + 10;
      else if(seg1==seg2) cur_coin <= cur_coin + 5;
      else if(seg2==seg3) cur_coin <= cur_coin + 5;
      else if(seg1==seg3) cur_coin <= cur_coin + 5;
		  else cur_coin <= cur_coin + 1;
		  
      if(cur_coin >= 97) nxt_state <= s6;
      else nxt_state <= s1;
    
    end
	  s6: begin
		  nxt_state <= s6;
		  cur_coin <= 0;
	  end	
    endcase
  end
	end
  
  //for text lcd 
  wire [7:0] LCD_DATA_0,LCD_DATA_1,LCD_DATA_2,LCD_DATA_3,LCD_DATA_4,LCD_DATA_5,LCD_DATA_6;
	wire LCD_E0,LCD_RS0,LCD_RW0;
	wire LCD_E1,LCD_RS1,LCD_RW1;
	wire LCD_E2,LCD_RS2,LCD_RW2;
	wire LCD_E3,LCD_RS3,LCD_RW3;
	wire LCD_E4,LCD_RS4,LCD_RW4;
	wire LCD_E5,LCD_RS5,LCD_RW5;
	wire LCD_E6,LCD_RS6,LCD_RW6;

  textlcd0 L0(RST,CLK,LCD_E0,LCD_RS0,LCD_RW0,LCD_DATA_0);
	textlcd1 L1(RST,CLK,LCD_E1,LCD_RS1,LCD_RW1,LCD_DATA_1);
	textlcd2 L2(RST,CLK,LCD_E2,LCD_RS2,LCD_RW2,LCD_DATA_2);
	textlcd3 L3(RST,CLK,LCD_E3,LCD_RS3,LCD_RW3,LCD_DATA_3);
	textlcd4 L4(RST,CLK,LCD_E4,LCD_RS4,LCD_RW4,LCD_DATA_4);
	textlcd6 L6(RST,CLK,LCD_E6,LCD_RS6,LCD_RW6,LCD_DATA_6);

  assign LCD_DATA = cur_state==s0 ? LCD_DATA_0 : 
  (cur_state==s1 ? LCD_DATA_1 : 
  (cur_state==s2 ? LCD_DATA_2 : 
  (cur_state==s3 ? LCD_DATA_3 : 
  (cur_state==s4 ? LCD_DATA_4 :
  LCD_DATA_6))));

  assign LCD_E = LCD_E0;
  assign LCD_RS = LCD_RS0;
  assign LCD_RW = LCD_RW0;

  //for led flash
  shifter_8bit sh1(clk_4,RST,LED_OUT,LED_IN);
  

  //7bit coin to bcd
  Binary_To_Bcd B0(cur_coin,cur_coin_bcd);
  assign coin_seg1 = cur_coin_bcd[7:4];
  assign coin_seg2 = cur_coin_bcd[3:0];

  //slot number 1,2,3
  Back_Number N0(clk_6,STOP1,RST,seg1);
  Number N1(clk_6,STOP2,RST,seg2);
  Back_Number N2(clk_6,STOP3,RST,seg3);

  //coin, slot number to 7 segment
  BCD_TO_7SEGMENT S1(seg1,SEG1);
	BCD_TO_7SEGMENT S2(seg2,SEG2);
	BCD_TO_7SEGMENT S3(seg3,SEG3);
  BCD_TO_7SEGMENT S4(coin_seg1,COIN_10);
  BCD_TO_7SEGMENT S5(coin_seg2,COIN_1);
  SEG7_CTRL U3(CLK, RST, SEG3,SEG2,SEG1,0,0,0,COIN_1,COIN_10,SEG_COM, SEG_DATA);
endmodule