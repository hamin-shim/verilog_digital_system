module Main_Machine_SIMPLE (
    CLK, RST, C_IN, GAME_START, SEG_COM, SEG_DATA
);  
    input CLK, RST, C_IN, GAME_START;
	 output [7:0] SEG_COM, SEG_DATA;
	 wire a1,b1,c1,d1,e1,f1,g1;
	 wire a2,b2,c2,d2,e2,f2,g2;
    wire [3:0] coin_seg1, coin_seg2;
    reg [6:0] cur_coin; //max: 2'b1100011 = 99
    wire[7:0] cur_coin_bcd;
	 
	 always @ (posedge CLK) begin
		cur_coin = 7'b1001010; //64+8+2=74
	 end
	 
	 initial begin
		cur_coin = 7'b1001010; //64+8+2=74
	 end
    
	 Binary_To_Bcd B0(cur_coin,cur_coin_bcd);
    
	 assign coin_seg1 = cur_coin_bcd[7:4];
    assign coin_seg2 = cur_coin_bcd[3:0];
	 
    BCD_TO_7SEGMENT B3(coin_seg1,a1,b1,c1,d1,e1,f1,g1);
    BCD_TO_7SEGMENT B4(coin_seg2,a2,b2,c2,d2,e2,f2,g2);
    SEG7_CTRL U3(CLK, RST, {a1,b1,c1,d1,e1,f1,g1},{a2,b2,c2,d2,e2,f2,g2},0,0,0,0,0,0,SEG_COM, SEG_DATA); 
endmodule