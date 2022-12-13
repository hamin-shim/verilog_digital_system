module Main_Machine (
    CLK, RST, C_IN, GAME_START, SEG_COM, SEG_DATA
);  
    input CLK, RST, C_IN, GAME_START;
	 wire clk_2, clk_4, clk_6, clk_8;
	 output [7:0] SEG_COM, SEG_DATA;
    wire [3:0] seg1, seg2;
    wire [3:0] coin_seg1, coin_seg2;
    reg STOP1,STOP2,STOP3;
    wire [6:0] SEG1,SEG2,SEG3,SEG4;
    reg [6:0] cur_coin; //max: 2'b1100011 = 99
    wire[7:0] cur_coin_bcd;
    reg [1:0] gameset;  
	 clk_divide CK1(CLK, RST, clk_2, clk_4, clk_6);
	 clk_div8 CK2(CLK, RST, clk_8);
	 always @(posedge CLK) begin
		cur_coin = 7'b1001010; //64+8+2=74
		STOP1 = 0;
		STOP2 = 0;
	 end
    Binary_To_Bcd B0(cur_coin,cur_coin_bcd);
    assign coin_seg1 = cur_coin_bcd[7:4];
    assign coin_seg2 = cur_coin_bcd[3:0];
    Number N0(clk_6,STOP1,RST,seg1);
    Back_Number N1(clk_8,STOP2,RST,seg2);
    BCD_TO_7SEGMENT S1(seg1,SEG1);
	 BCD_TO_7SEGMENT S2(seg2,SEG2);
    BCD_TO_7SEGMENT S3(coin_seg1,SEG3);
    BCD_TO_7SEGMENT S4(coin_seg2,SEG4);
	 //CLK = 2, clk_2 = 4, clk_4 = 2, clk_6 = 2
    SEG7_CTRL U3(CLK, RST, SEG3,SEG4,0,0,0,0,SEG2,SEG1,SEG_COM, SEG_DATA); 


    wire LCD_RW,LCD_RS,LCD_E;
wire [7:0] LCD_DATA;
  always @ (cur_state or RST or clk) begin
    case (cur_state)
      s0 :
      begin
        textlcds0 L0(
    RST,CLK,LCD_E,LCD_RS,LCD_RW,LCD_DATA
);
        end
      s1 :
        begin
        textlcds1 L1(
    RST,CLK,LCD_E,LCD_RS,LCD_RW,LCD_DATA
);
        end
      s2 :
        begin
        textlcds2 L2(
    RST,CLK,LCD_E,LCD_RS,LCD_RW,LCD_DATA
);
        end
      s3 :
          begin
          textlcds3 L3(
    RST,CLK,LCD_E,LCD_RS,LCD_RW,LCD_DATA
);
        end
      
    endcase
  end
endmodule


//reg calend ;

//   always @ (cur_state) begin
//     case (cur_state)
//       s0 :
//         if(gameset == 1'b0) begin
//         cur_coin = 8'b00000000;
//  
//         calend = 1'b0;
//         GAME_START = 0;
       
//         end
//       s1 :
//         begin
//         cur_coin = 8'b00000001;
//         calend = 1'b0;
//         end
      
//       s2 :
//           begin
//           if (calend==1) begin
            
//           end
//           else if(STOP1 == STOP2 && STOP1 == STOP3 && STOP2 == STOP3) begin
//             cur_coin <= cur_coin + 8'b1100011;
//             calend <= calend + 1;
//           end
//           else if (STOP1 == STOP2 || STOP1 == STOP3 || STOP2 == STOP3) begin
//             cur_coin <= cur_coin + 8'b00000101;
//             calend <= calend +1;
//           end
//           else begin
//             cur_coin <= cur_coin + 8'b00000000;
//             calend <= calend +1;
//           end
//           //calend = 1이면 s2->s1
//           //s1으로 됬을때 calend = 0으로 초기화

//         end
//     endcase
//   end
