
`timescale 10ns/1ps

module LAB03_FULLADDER_TB;

reg A,B,C;
wire Y,Z;

LAB03_FULLADDER F1(A,B,C,Y,Z);

initial begin
A<=0; B<=0;C<=0;
#10 A<=0; B<=0;C<=1;
#10 A<=0; B<=1;C<=0;
#10 A<=0; B<=1;C<=1;
#10 A<=1; B<=0;C<=0;
#10 A<=1; B<=0;C<=1;
#10 A<=1; B<=1;C<=0;
#10 A<=1; B<=1;C<=1;

end

endmodule
