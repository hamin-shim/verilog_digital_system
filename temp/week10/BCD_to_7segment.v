module BCD_to_7segment(	D3,D2,D1,D0, A,B,C,D,E,F,G );

input D3,D2,D1,D0;
output A,B,C,D,E,F,G;
reg [7:0] out; 

always @(D3,D2,D1,D0)
begin
case({D3,D2,D1,D0})
	4'b0000 : out <= 7'b1111110; //0
	4'b0001 : out <= 7'b0110000; //1
	4'b0010 : out <= 7'b1101101; //2
	4'b0011 : out <= 7'b1111001; //3
	4'b0100 : out <= 7'b0110011; //4
	4'b0101 : out <= 7'b1011011; //5
	4'b0110 : out <= 7'b1011111; //6
	4'b0111 : out <= 7'b1110010; //7
	4'b1000 : out <= 7'b1111111; //8
	4'b1001 : out <= 7'b1111011; //9
	default : out <= 7'b0000000; //NULL
endcase 
end

assign {A,B,C,D,E,F,G} = out;

endmodule