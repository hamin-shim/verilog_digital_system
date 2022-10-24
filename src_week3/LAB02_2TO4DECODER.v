module LAB02_2TO4DECODER_EN (
    A0, A1, D3, D2, D1, D0
);
    input A1,A0;
    output D3,D2,D1,D0;

    wire b0, b1, b2, b3, b4, b5, b6, b7;
    assign b0 = ~A0;
    assign b1 = ~A1;
    assign b2 = A0;
    assign b3 = ~A1;
    assign b4 = A1;
    assign b5 = ~A0;
    assign b6 = A1;
    assign b7 = A0;

    assign D0 = b0 & b1 ;
    assign D1 = b2 & b3 ;
    assign D2 = b4 & b5 ;
    assign D3 = b6 & b7 ;


endmodule

