module slotmachine(slot_a1,slot_a2,slot_a3,slot_b1,slot_b2,slot_b3,slot_c1,slot_c2,slot_c3,coin_out,bypass,btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9,clrb,clk,coin_in);
  parameter s0 = 5'b000; 
  parameter s1 = 5'b001; 
  parameter s2 = 5'b010; 
  parameter s3 = 5'b011; 
  parameter s4 = 5'b100; 

  input btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9,clrb,clk,coin_in; 
  output coin_out,bypass;
  output [2:0]slot_a1; 
  output [2:0]slot_a2; 
  output [2:0]slot_a3; 
  output [2:0]slot_b1; 
  output [2:0]slot_b2; 
  output [2:0]slot_b3; 
  output [2:0]slot_c1; 
  output [2:0]slot_c2; 
  output [2:0]slot_c3; 
  
  reg [3:0]cur_state; 
  reg [3:0]nxt_state; 
  reg [7:0]cur_coin; 
  reg gameset; 

  reg coin_out;
  reg bypass;
  reg [2:0]slot_a1;
  reg [2:0]slot_a2;
  reg [2:0]slot_a3;
  reg [2:0]slot_b1;
  reg [2:0]slot_b2;
  reg [2:0]slot_b3;
  reg [2:0]slot_c1;
  reg [2:0]slot_c2;
  reg [2:0]slot_c3;
  

  wire [2:0]slot_pic_a1; 
  wire [2:0]slot_pic_a2; 
  wire [2:0]slot_pic_a3; 
  wire [2:0]slot_pic_b1; 
  wire [2:0]slot_pic_b2; 
  wire [2:0]slot_pic_b3; 
  wire [2:0]slot_pic_c1; 
  wire [2:0]slot_pic_c2; 
  wire [2:0]slot_pic_c3; 

  number a1_state(slot_pic_a1,btn1,clrb,clk); 
  backnumber a2_state(slot_pic_a2,btn2,clrb,clk);
  number a3_state(slot_pic_a3,btn3,clrb,clk);
  backnumber b1_state(slot_pic_b1,btn4,clrb,clk);
  number b2_state(slot_pic_b2,btn5,clrb,clk);
  backnumber b3_state(slot_pic_b3,btn6,clrb,clk);
  number c1_state(slot_pic_c1,btn7,clrb,clk);
  number c2_state(slot_pic_c2,btn8,clrb,clk);
  backnumber c3_state(slot_pic_c3,btn9,clrb,clk);
  

  always @ (negedge clrb or posedge clk) begin
    if(!clrb) begin
      cur_state <= s0; 
    end
    else begin
      cur_state <= nxt_state; 
    end
    if(cur_state != s0) begin 
    slot_a1 <= slot_pic_a1; 
    slot_b2 <= slot_pic_b2;
    slot_c3 <= slot_pic_c3;
    slot_a2 <= slot_pic_a2;
    slot_b1 <= slot_pic_b1;
    slot_c1 <= slot_pic_c1;
    slot_a3 <= slot_pic_a3;
    slot_b3 <= slot_pic_b3;
    slot_c2 <= slot_pic_c2;
    end
  end
  
  always @ (cur_state or coin_in or btn1 or btn2 or btn3 or btn4 or btn5 or btn6 or btn7 or btn8 or btn9) begin
    case (cur_state)
      s0 :
        if(coin_in == 1'b1) begin
         gameset = 1'b1; 
         nxt_state = s1;
        end
        else begin
          gameset = 1'b0;
          nxt_state = s0; 
        end
      s1 :
        if(coin_in == 1'b1) begin
          if(cur_coin == 1'b1) begin
          nxt_state = s2;
          end
        end
        else if(btn1 == 1'b1 && btn2 == 1'b1 && btn3 == 1'b1 && btn4 == 1'b1 && btn5 == 1'b1 && btn6 == 1'b1 && btn7 == 1'b1 && btn8 == 1'b1 && btn9 == 1'b1) begin
          nxt_state = s3;
        end
      s2 :
          nxt_state = s1;
      s3 :
          nxt_state = s4;
      s4 :
          nxt_state = s0;
    endcase
  end

  always @ (cur_state or coin_in or btn1 or btn2 or btn3 or btn4 or btn5 or btn6 or btn7 or btn8 or btn9) begin
    case (cur_state)
      s0 :
        if(gameset == 1'b0) begin
        cur_coin = 8'b00000000;
        coin_out = 1'b0;
        bypass = 1'b0;
        slot_a1 = 3'b000;
        slot_a2 = 3'b100;
        slot_a3 = 3'b000;
        slot_b1 = 3'b100;
        slot_b2 = 3'b000;
        slot_b3 = 3'b100;
        slot_c1 = 3'b000;
        slot_c2 = 3'b000;
        slot_c3 = 3'b100;
        end
      s1 :
        begin
        cur_coin = 8'b00000001;
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



