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
        4'b0101 : CARLED = 4'b1100; 
        4'b0111 : begin
            CARLED = 4'b0010; 
            HUMANLED = 2'b10;
        end
        4'b1110 : begin
            CARLED = 4'b0001; 
            HUMANLED = 2'b01;
        end 
    endcase
end

endmodule
