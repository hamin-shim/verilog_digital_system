module LAB06_ELEVATOR(RESETN, CLK, SW, Q, a,b,c,d,e,f,g);
input RESETN,CLK;
input [3:0] SW;

output [3:0] Q;
reg [3:0] Q;
output a,b,c,d,e,f,g;

always @ (posedge CLK or posedge RESETN)
begin
if (RESETN) Q = 4'b0001;
else if (SW>Q) begin 
        if ( Q == 4'b1111 ) Q = 4'b0000;
        else Q=Q+1'b1; 
    end
    else if (SW<Q) begin
        if ( Q == 4'b0000 ) Q = 4'b1111; 
        else Q=Q-1'b1; 
	 end
end
LAB06_SEG U0(Q, a, b, c, d, e, f, g);
endmodule
