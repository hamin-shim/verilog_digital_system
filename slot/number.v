module number(slot_pic,btn,clrb,clk);
  input clrb, clk, btn; 
  output [2:0]slot_pic; 

  reg [2:0]slot_pic;
  always @ (posedge clk or negedge clrb) begin
     if(!clrb) begin
      slot_pic <= 3'b000; 
     end 
     else if(btn==1'b0) begin
      if(slot_pic == 3'b000)
        slot_pic <= 3'b001;
      if(slot_pic == 3'b001)
        slot_pic <= 3'b010;
      if(slot_pic == 3'b010)
        slot_pic <= 3'b011;
      if(slot_pic == 3'b011)
        slot_pic <= 3'b100;
      if(slot_pic == 3'b100)
        slot_pic <= 3'b000;
     end
  end
 endmodule

