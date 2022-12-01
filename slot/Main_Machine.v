module Main_Machine (
    CLK, RST, C_IN, GAME_START
);  
    input CLK, RST, C_IN, GAME_START;
    wire [3:0] seg1, seg2;
    wire [3:0] coin_seg1, coin_seg2;
    reg STOP1,STOP2,STOP3;
    wire [6:0] SEG1,SEG2,SEG3,SEG4;
    reg [6:0] cur_coin; //max: 2'b1100011 = 99
    wire[7:0] cur_coin_bcd;
    reg [1:0] gameset;  //0 : initial state / 1 : 3 number are changing / 2 : cur_coin >=99, game end
    cur_coin = 2'b1001010 //64+8+2=74
    Binary_To_Bcd B0(cur_coin,cur_coin_bcd);
    assign coin_seg1 = cur_coin_bcd[7:4];
    assign coin_seg2 = cur_coin_bcd[3:0];
    Number N0(CLK,STOP1,RST,seg1);
    Back_Number N1(CLK,STOP2,RST,seg2);
    BCD_TO_7SEGMENT B1(seg1,SEG1);
    BCD_TO_7SEGMENT B2(seg1,SEG2);
    BCD_TO_7SEGMENT B3(coin_seg1,SEG3);
    BCD_TO_7SEGMENT B4(coin_seg2,SEG4);
    SEG7_CTRL U3(CLK, RST, SEG1,SEG2, 0,0,0,0,SEG3,SEG4,SEG_COM, SEG_DATA); // 8 array should be : ------74
endmodule