module LAB06_SIGNAL_LAMP(RESETN, CLK, Q, LED);
input RESETN,CLK;
output [2:0] LED;
output [3:0] Q;

wire [3:0] Q;
reg [2:0] LED;
LAB06_UPDNCOUNTER U0(RESETN, CLK, 0, Q);

always @ (posedge CLK or posedge RESETN) begin
    case(Q)
        4'b0101 : LED = 3'b001;
        4'b1010 : LED = 3'b011;
        4'b1111 : LED = 3'b010;
    endcase
end
endmodule

