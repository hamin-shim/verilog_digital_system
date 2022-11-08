module LAB06_TRAFFIC(RESETN, CLK, CARLED,HUMANLED, Q);
input RESETN,CLK;
output [3:0] Q;
output [3:0] CARLED;
output [1:0] HUMANLED;

reg [3:0] CARLED;
reg [1:0] HUMANLED;
LAB06_UPDNCOUNTER U0(RESETN, CLK, 0, Q);


always @ (posedge CLK or posedge RESETN) begin
    case(Q)
		4'b0000 : CARLED = 4'b0000; 
        4'b0101 : CARLED = 4'b1100; 
        4'b0111 : CARLED = 4'b0010; 
        4'b1110 : CARLED = 4'b0001; 
    endcase
end
always @ (posedge CLK or posedge RESETN) begin
    case(Q)
        4'b0110 : HUMANLED = 2'b10;
        4'b1100 : HUMANLED = 2'b01;
    endcase
end

endmodule