module Main_Machine (
    CLK, RST, C_IN, GAME_START, SEG_COM, SEG_DATA
);  

    parameter s0 = 5'b000; 
    parameter s1 = 5'b001; 
    parameter s2 = 5'b010; 
    parameter s3 = 5'b011; 
    parameter s4 = 5'b100; 

    reg [3:0]cur_state; 
    reg [3:0]nxt_state; 
    reg [1:0] gameset;  


    input CLK, RST, C_IN, GAME_START;
	output [7:0] SEG_COM, SEG_DATA;
	wire a1,b1,c1,d1,e1,f1,g1;
	wire a2,b2,c2,d2,e2,f2,g2;
    wire [3:0] seg1, seg2;
    wire [3:0] coin_seg1, coin_seg2;
    reg STOP1,STOP2,STOP3;
    wire [6:0] SEG1,SEG2,SEG3,SEG4;
    reg [6:0] cur_coin; //max: 2'b1100011 = 99
    wire[7:0] cur_coin_bcd;
	 initial begin
		cur_coin = 7'b1001010; //64+8+2=74
	 end
    Binary_To_Bcd B0(cur_coin,cur_coin_bcd);
    assign coin_seg1 = cur_coin_bcd[7:4];
    assign coin_seg2 = cur_coin_bcd[3:0];
    Number N0(CLK,STOP1,RST,seg1);
    Back_Number N1(CLK,STOP2,RST,seg2);
    // BCD_TO_7SEGMENT B10(seg1,a1,b1,c1,d1,e1,f1,g1);
    // BCD_TO_7SEGMENT B2(seg1,a2,b2,c2,d2,e2,f2,g2);
    BCD_TO_7SEGMENT B3(coin_seg1,a1,b1,c1,d1,e1,f1,g1);
    BCD_TO_7SEGMENT B4(coin_seg2,a2,b2,c2,d2,e2,f2,g2);
    SEG7_CTRL U3(CLK, RST, {a1,b1,c1,d1,e1,f1,g1},{a2,b2,c2,d2,e2,f2,g2},0,0,0,0,0,0,SEG_COM, SEG_DATA); 


    always @ (negedge clrb or posedge clk) begin
    if (!RST) begin
        cur_state = s0;
    end
    else begin
      cur_state <= nxt_state; 
    end
    if(cur_state != s0) begin 
    //slot/cur_coin view
    // slot_a1 <= slot_pic_a1; 
    // slot_b2 <= slot_pic_b2;
    // slot_c3 <= slot_pic_c3;
    // slot_a2 <= slot_pic_a2;
    // slot_b1 <= slot_pic_b1;
    // slot_c1 <= slot_pic_c1;
    // slot_a3 <= slot_pic_a3;
    // slot_b3 <= slot_pic_b3;
    // slot_c2 <= slot_pic_c2;
    end
  end

    
  always @ (cur_state or C_IN or GAME_START) begin
    case (cur_state)
      s0 :
        if(C_IN == 1'b1) begin
         gameset = 1'b1; 
         nxt_state = s1;
        end
        else begin
          gameset = 1'b0;
          nxt_state = s0; 
        end
      s1 :
        if(C_IN == 1'b1) begin
            cur_coin = cur_coin + 1;
        //   if(cur_coin == 1'b1) begin
        //   nxt_state = s2;
        //   end
        end
        else if(cur_coin >=99) begin
          nxt_state = s3;
        end
        else if(GAME_START == 1'b1 )begin
            nxt_state = s2;
        end
      s2 :
          if (/*number 3 selected signal*/) begin
            nxt_state = s1;
          end
          
      s3 :
          nxt_state = s3;
    //   s4 :
    //       nxt_state = s0;
    endcase
  end

  always @ (cur_state or C_IN or btn1 or btn2 or btn3 or btn4 or btn5 or btn6 or btn7 or btn8 or btn9) begin
    case (cur_state)
      s0 :
        if(gameset == 1'b0) begin
        cur_coin = 7'b00000000;
        GAME_START = 0;
        // coin_out = 1'b0;
        // bypass = 1'b0;
        // slot_a1 = 3'b000;
        // slot_a2 = 3'b100;
        // slot_a3 = 3'b000;
        // slot_b1 = 3'b100;
        // slot_b2 = 3'b000;
        // slot_b3 = 3'b100;
        // slot_c1 = 3'b000;
        // slot_c2 = 3'b000;
        // slot_c3 = 3'b100;
        end
      s1 :
        begin
        cur_coin = 7'b00000001;
        bypass = 1'b0;
        end
      s2 :
        begin
        bypass = 1'b1;
        end
      s3 :
          begin
          if(slot_a1 == slot_a2 && slot_a1 == slot_a3 && slot_a2 == slot_a3) begin
            if(slot_a1 == 3'b000) begin
              cur_coin = cur_coin + 8'b00000000;
            end
            if(slot_a1 == 3'b001) begin
              cur_coin = cur_coin + 8'b00000001;
            end
            if(slot_a1 == 3'b010) begin
              cur_coin = cur_coin + 8'b00000010;
            end
            if(slot_a1 == 3'b011) begin
              cur_coin = cur_coin + 8'b00000011;
            end
            if(slot_a1 == 3'b100) begin
              cur_coin = cur_coin + 8'b00000100;
            end
          end

          if(slot_b1 == slot_b2 && slot_b1 == slot_b3 && slot_b2 == slot_a3) begin
            if(slot_b1 == 3'b000) begin
              cur_coin = cur_coin + 8'b00000000;
            end
            if(slot_b1 == 3'b001) begin
              cur_coin = cur_coin + 8'b00000001;
            end
            if(slot_b1 == 3'b010) begin
              cur_coin = cur_coin + 8'b00000010;
            end
            if(slot_b1 == 3'b011) begin
              cur_coin = cur_coin + 8'b00000011;
            end
            if(slot_b1 == 3'b100) begin
              cur_coin = cur_coin + 8'b00000100;
            end
          end

          if(slot_c1 == slot_c2 && slot_c1 == slot_c3 && slot_c2 == slot_c3) begin
            if(slot_c1 == 3'b000) begin
              cur_coin = cur_coin + 8'b00000000;
            end
            if(slot_c1 == 3'b001) begin
              cur_coin = cur_coin + 8'b00000001;
            end
            if(slot_c1 == 3'b010) begin
              cur_coin = cur_coin + 8'b00000010;
            end
            if(slot_c1 == 3'b011) begin
              cur_coin = cur_coin + 8'b00000011;
            end
            if(slot_c1 == 3'b100) begin
              cur_coin = cur_coin + 8'b00000100;
            end
          end

          if(slot_a1 == slot_b1 && slot_a1 == slot_c1 && slot_b1 == slot_c1) begin
            if(slot_a1 == 3'b000) begin
              cur_coin = cur_coin + 8'b00000000;
            end
            if(slot_a1 == 3'b001) begin
              cur_coin = cur_coin + 8'b00000001;
            end
            if(slot_a1 == 3'b010) begin
              cur_coin = cur_coin + 8'b00000010;
            end
            if(slot_a1 == 3'b011) begin
              cur_coin = cur_coin + 8'b00000011;
            end
            if(slot_a1 == 3'b100) begin
              cur_coin = cur_coin + 8'b00000100;
            end
         end

        if(slot_a2 == slot_b2 && slot_a2 == slot_c2 && slot_b2 == slot_c2) begin
            if(slot_a2 == 3'b000) begin
              cur_coin = cur_coin + 8'b00000000;
            end
            if(slot_a2 == 3'b001) begin
              cur_coin = cur_coin + 8'b00000001;
            end
            if(slot_a2 == 3'b010) begin
              cur_coin = cur_coin + 8'b00000010;
            end
            if(slot_a2 == 3'b011) begin
              cur_coin = cur_coin + 8'b00000011;
            end
            if(slot_a2 == 3'b100) begin
              cur_coin = cur_coin + 8'b00000100;
            end
         end

        if(slot_a3 == slot_b3 && slot_a3 == slot_c3 && slot_b3 == slot_c3) begin
            if(slot_a3 == 3'b000) begin
              cur_coin = cur_coin + 8'b00000000;
            end
            if(slot_a3 == 3'b001) begin
              cur_coin = cur_coin + 8'b00000001;
            end
            if(slot_a3 == 3'b010) begin
              cur_coin = cur_coin + 8'b00000010;
            end
            if(slot_a3 == 3'b011) begin
              cur_coin = cur_coin + 8'b00000011;
            end
            if(slot_a3 == 3'b100) begin
              cur_coin = cur_coin + 8'b00000100;
            end
         end
        end
      s4 :
          begin
          gameset = 1'b0;
          cur_coin = 1'b0;
          coin_out = 1'b1;
          end
    endcase
  end


endmodule