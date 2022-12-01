module Back_Number(CLK,STOP,RST,NUM);
  input RST, CLK, STOP; 
  output [3:0]NUM; 

  reg [3:0]NUM;
  always @ (posedge CLK or negedge RST) begin
     if(!RST) begin
      NUM <= 4'b1001; 
     end 
     else if (STOP !== 1'b0) begin
      if(NUM == 4'b0000) NUM <= 4'b1001;
      else NUM -= 1;
     end
  end
 endmodule

