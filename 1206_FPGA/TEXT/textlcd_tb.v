`timescale 1ns/1ps

module textlcd_tb;

//input
reg RESETN,CLK;

//output
wire LCD_RW,LCD_RS,LCD_E;
wire [7:0] LCD_DATA;

textlcdforSLOT U1(
    RESETN,CLK,LCD_E,LCD_RS,LCD_RW,LCD_DATA
);

initial begin
    RESETN = 1; CLK = 0;
    #5 RESETN = 0;
end
    
endmodule