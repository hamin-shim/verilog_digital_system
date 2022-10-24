module LAB02_1TO2DECODER (
    A0, D1, D0
);
    input A0;
    output D1, D0;

    assign D0 = A0 & 1;
    assign D1 =~A0 & 1;
    
endmodule

