module SEG7_CTRL(
	iCLK,
	nRST,
	iSEG7,
	iSEG6,
	iSEG5,
	iSEG4,
	iSEG3,
	iSEG2,
	iSEG1,
	iSEG0,
	oS_COM,
	oS_ENS
);
// I/O definition------------------------------------------	
input iCLK, nRST;
input [6:0] iSEG7, iSEG6, iSEG5, iSEG4,iSEG3, iSEG2, iSEG1, iSEG0;
output [7:0] oS_COM;
output [6:0] oS_ENS; /* a,b,c,d, e,f,g,dp */
reg [7:0] oS_COM;
reg [6:0] oS_ENS;
integer CNT_SCAN; 

/*
   [a]
[f]   [b]
   [g]
[e]   [c]
   [d]   [dp]
*/
always @(posedge iCLK)
begin
	if (nRST)
	  begin
		oS_COM <= 8'b00000000;
		oS_ENS <= 0;
	    CNT_SCAN = 0;
	  end
	else
	  begin
	  	if (CNT_SCAN >= 7)
	  	  CNT_SCAN = 0;
	  	else
	  	  CNT_SCAN = CNT_SCAN + 1;
	  	  	  	
	  	case (CNT_SCAN)
	  	  0 : 
	  	    begin
				oS_COM <= 8'b11111110;
				oS_ENS <= iSEG0;
	  	    end
	  	  1 : 
	  	    begin
				oS_COM <= 8'b11111101;
				oS_ENS <= iSEG1;
	  	    end
	  	  2 : 
	  	    begin
				oS_COM <= 8'b11111011;
				oS_ENS <= iSEG2;
	  	    end
	  	  3 : 
	  	    begin
				oS_COM <= 8'b11110111;
				oS_ENS <= iSEG3;
	  	    end
	  	  4 : 
	  	    begin
				oS_COM <= 8'b11101111;
				oS_ENS <= iSEG4;
	  	    end
	  	  5 : 
	  	    begin
				oS_COM <= 8'b11011111;
				oS_ENS <= iSEG5;
	  	    end
	  	  6 : 
	  	    begin
				oS_COM <= 8'b10111111;
				oS_ENS <= iSEG6;
	  	    end
	  	  7 : 
	  	    begin
				oS_COM <= 8'b01111111;
				oS_ENS <= iSEG7;
	  	    end			 
	  	  default : 
	  	    begin
	  	      oS_COM <= 8'b11111111;
				oS_ENS <= iSEG7;
	  	    end
	  	endcase
      end
end

endmodule