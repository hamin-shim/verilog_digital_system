module LAB02_3TO8DECODER (
    A2,A1,A0,D7,D6,D5,D4,D3,D2,D1,D0
);
    input A2,A1,A0;
    output D7,D6,D5,D4,D3,D2,D1,D0;
    wire b0,b1,w0,w1,w2,w3;
    
    LAB02_2TO4DECODER U1 (
    A0, A1, w3, w2, w1, w0
    );
    LAB02_1TO2DECODER U2 (
    A2, b1, b0
    );
    
    assign D0 = w0 & b1;
    assign D1 = w1 & b1;
    assign D2 = w2 & b1;
    assign D3 = w3 & b1;
    assign D4 = w0 & b0;
    assign D5 = w1 & b0;
    assign D6 = w2 & b0;
    assign D7 = w3 & b0;
    

endmodule