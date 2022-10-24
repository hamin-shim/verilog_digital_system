`timescale 10ns/1ps

module LAB02_3TO8DECODER_TB;

reg A2,A1,A0;
wire D7,D6,D5,D4,D3,D2,D1,D0;
LAB02_3TO8DECODER_2 U1 (
    A2,A1,A0,D7,D6,D5,D4,D3,D2,D1,D0
);
initial begin
    A2<=0; A1<=0; A0<=0;
    #10 A2<=0; A1<=0; A0<=1;
    #10 A2<=0; A1<=1; A0<=0;
    #10 A2<=0; A1<=1; A0<=1;
    #10 A2<=1; A1<=0; A0<=0;
    #10 A2<=1; A1<=0; A0<=1;
    #10 A2<=1; A1<=1; A0<=0;
    #10 A2<=1; A1<=1; A0<=1;
    
end
    
endmodule