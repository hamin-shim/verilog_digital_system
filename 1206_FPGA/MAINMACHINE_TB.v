
 `timescale 10ns/1ps
 
module MAINMACHINE_TB;
 
reg CLK;
wire RST,C_IN,GAME_START;
wire [6:0] SEG3,SEG4;
wire [7:0] SEG_COM, SEG_DATA;
   
Main_Machine MM (CLK, RST, C_IN, GAME_START, SEG_COM, SEG_DATA, SEG3,SEG4);                    
initial begin
  CLK <= 0;
end
  
always #10
  CLK = ~CLK;
    
endmodule 
