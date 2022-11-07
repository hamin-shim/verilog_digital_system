module MUX_2to1 (A, B , SEL, OUT);
input [3:0] A, B;
input SEL;
output [3:0] OUT;

assign OUT = (!SEL) ? A : B;

endmodule