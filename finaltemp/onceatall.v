module Main_Machine (
    CLK, RST, C_IN, GAME_START,SBTN, SEG_COM, SEG_DATA, LCD_DATA, LCD_E,LCD_RS,LCD_RW
);  
  parameter s0 = 3'b000;
  parameter s1 = 3'b001;
  parameter s2 = 3'b010;
  parameter s3 = 3'b011;
  parameter s4 = 3'b100;
  parameter random1 = 150;
  input CLK, RST, C_IN, GAME_START,SBTN;
	output [7:0] SEG_COM, SEG_DATA,LCD_DATA;
	output LCD_E,LCD_RS,LCD_RW;
	wire [3:0] seg1, seg2,seg_3;
  wire [3:0] coin_seg1, coin_seg2;
	wire clk_2, clk_4, clk_6, clk_8;
  wire [6:0] SEG1,SEG2,SEG3,COIN_1,COIN_10;
  wire [7:0] cur_coin_bcd;
  reg [6:0] cur_coin; //max: 2'b1100011 = 99
	reg STOP1,STOP2,STOP3;
  reg [1:0] gameset;
	reg [3:0] cur_state;
  reg [3:0] nxt_state;
  reg [1:0] cnt;
	clk_divide CK1(CLK, RST, clk_2, clk_4, clk_6);
	clk_div8 CK2(CLK, RST, clk_8);
	always @ (posedge RST or posedge CLK) begin
    if (RST) cur_state <= s0;
    else cur_state <= nxt_state;
	 end
	always @ (cur_state or C_IN or GAME_START or cnt or SBTN) begin
    case (cur_state)
      s0 :begin
        cur_coin <= 0;
		    STOP1 <= 1;
		    STOP2 <= 1;
		    STOP3 <= 1;
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
          cur_coin <= cur_coin + 7'b0000001;
			 nxt_state <= s1;
        end
        //if(cur_coin >=99) begin
        //  nxt_state <= s3;
        //end
        if(GAME_START == 1'b1 )begin
            nxt_state <= s2;
				cnt <= 0;
        end
		  else begin
		  nxt_state <= s1;
		  end
		  end
      s2 : 
         begin
			STOP1<=0;
			STOP2<=0;
			STOP3<=0;
			if(cnt==0 && SBTN==1) begin 
			STOP1<=1;
			cnt <= 1;
			end
			else if(cnt==1 && SBTN==1) begin
			STOP2<=1;
			cnt<=2;
			end
			else if(cnt==2 && SBTN==1) begin
			STOP3<=1;
			cnt<=3;
			end
			else if(cnt==3) begin
			if(seg1 == seg2 == seg3) begin
			end
			else if(seg1 == seg2 || seg1 == seg3 || seg2 == seg3) begin
			end
			else begin
			end
			nxt_state = s1;
			end
			else nxt_state = s2;
			end
      s3 :
          nxt_state = s0;
    //   s4 :
    //       nxt_state = s0;
    endcase
	end
  wire [7:0] LCD_DATA_0,LCD_DATA_1,LCD_DATA_2,LCD_DATA_3;
	wire LCD_E0,LCD_RS0,LCD_RW0;
	wire LCD_E1,LCD_RS1,LCD_RW1;
	wire LCD_E2,LCD_RS2,LCD_RW2;
	wire LCD_E3,LCD_RS3,LCD_RW3;
  textlcd0 L0(RST,CLK,LCD_E0,LCD_RS0,LCD_RW0,LCD_DATA_0);
	textlcd1 L1(RST,CLK,LCD_E1,LCD_RS1,LCD_RW1,LCD_DATA_1);
	textlcd2 L2(RST,CLK,LCD_E2,LCD_RS2,LCD_RW2,LCD_DATA_2);
	textlcd3 L3(RST,CLK,LCD_E3,LCD_RS3,LCD_RW3,LCD_DATA_3);
	assign LCD_DATA = cur_state==s0 ? LCD_DATA_0 : (cur_state==s1 ? LCD_DATA_1 : (cur_state==s2 ? LCD_DATA_2 : LCD_DATA_3));
  assign LCD_E = LCD_E0;
  assign LCD_RS = LCD_RS0;
  assign LCD_RW = LCD_RW0;
	Binary_To_Bcd B0(cur_coin,cur_coin_bcd);
  assign coin_seg1 = cur_coin_bcd[7:4];
  assign coin_seg2 = cur_coin_bcd[3:0];
  Back_Number N0(clk_6,STOP1,RST,seg1);
  Number N1(clk_6,STOP2,RST,seg2);
  Back_Number N2(clk_6,STOP3,RST,seg3);
	BCD_TO_7SEGMENT S1(seg1,SEG1);
	BCD_TO_7SEGMENT S2(seg2,SEG2);
	BCD_TO_7SEGMENT S3(seg3,SEG3);
  BCD_TO_7SEGMENT S4(coin_seg1,COIN_10);
  BCD_TO_7SEGMENT S5(coin_seg2,COIN_1);
	//CLK = 2, clk_2 = 4, clk_4 = 2, clk_6 = 2
  SEG7_CTRL U3(CLK, RST, SEG3,SEG2,SEG1,0,0,0,COIN_1,COIN_10,SEG_COM, SEG_DATA);
	//TEXT_LCD(RST,CLK,LCD_E,LCD_RS,LCD_RW,LCD_DATA);
endmodule