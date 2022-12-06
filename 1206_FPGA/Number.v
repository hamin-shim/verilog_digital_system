module Number(CLK,STOP,RST,NUM);
  input RST, CLK, STOP; 
  output [3:0]NUM; 

  reg [3:0]NUM;
  initial begin
	NUM = 4'b0000;
  end
  always @ (posedge CLK ) begin
     if (!STOP) begin
      if(NUM == 4'b1001) NUM = 4'b0000;
      else NUM = NUM + 1;
     end
  end
 endmodule

