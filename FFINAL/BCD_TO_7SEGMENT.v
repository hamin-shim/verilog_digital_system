module BCD_TO_7SEGMENT(BCD,SEGMENT);

input [3:0] BCD;
output [6:0] SEGMENT;

reg [6:0] DECODE;

always @(BCD) begin
    case(BCD)
    4'b0000 : DECODE <= 7'b1111110; //segment 0
    4'b0001 : DECODE <= 7'b0110000; //segment 1
    4'b0010 : DECODE <= 7'b1101101; //segment 2
    4'b0011 : DECODE <= 7'b1111001; //segment 3
    4'b0100 : DECODE <= 7'b0110011; //segment 4
    4'b0101 : DECODE <= 7'b1011011; //segment 5
    4'b0110 : DECODE <= 7'b1011111; //segment 6
    4'b0111 : DECODE <= 7'b1110010; //segment 7
    4'b1000 : DECODE <= 7'b1111111; //segment 8
    4'b1001 : DECODE <= 7'b1111011; //segment 9
    default : DECODE <= 7'b0000000; //NULL
    endcase
end

assign SEGMENT = DECODE;

endmodule




