`timescale 10ns / 1ps



module LAB02_BINTOBCD_TB;



reg A3,A2,A1,A0;

wire S3,S2,S1,S0;



LAB02_BINTOBCD U1 (A3,A2,A1,A0 , S3,S2,S1,S0)



initial begin

{A3,A2,A1,A0} <= 4’b0000;

#10 {A3,A2,A1,A0} <= 4’b0001;

#10 {A3,A2,A1,A0} <= 4’b0010;

#10 {A3,A2,A1,A0} <= 4’b0011;

#10 {A3,A2,A1,A0} <= 4’b0100;

#10 {A3,A2,A1,A0} <= 4’b0101;

#10 {A3,A2,A1,A0} <= 4’b0110;

#10 {A3,A2,A1,A0} <= 4’b0111;

#10 {A3,A2,A1,A0} <= 4’b1000;

#10 {A3,A2,A1,A0} <= 4’b1000;

end

endmodule