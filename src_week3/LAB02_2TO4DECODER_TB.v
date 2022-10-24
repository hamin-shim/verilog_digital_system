`timescale 10ns/1ps

module LAB02_2TO4DECODER_TB;

reg A,B;
wire W,X,Y,Z;
LAB02_2TO4DECODER U1(A,B,W,X,Y,Z);
initial begin
    A<=0; B<=0;
    #10 A<=0; B<=1;
    #10 A<=1; B<=0;
    #10 A<=1; B<=1;
    
end
    
endmodule