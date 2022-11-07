module LAB06_TRAFFIC(RESETN, CLK, Q1,Q2, LED);
input RESETN,CLK;
output [2:0] LED;
output [3:0] CARLED;
output [3:0] HUMANLED;

wire [3:0] Q;
reg [2:0] CARLED;
reg [2:0] HUMANLED;
LAB06_UPDNCOUNTER U0(RESETN, CLK, 0, Q);

// – 차량용
// • Q<5: 직/좌,  Q<7: 황, Q< 15: 적
// – 보행자용
// • Q<7: 적, Q<15: 청

always @ (posedge CLK or posedge RESETN) begin
    case(Q)
        4'b0101 : CARLED = 3'b001; //직/좌
        4'b1010 : CARLED = 3'b011; //황
        4'b1111 : CARLED = 3'b010; //적
    endcase
end
always @ (posedge CLK or posedge RESETN) begin
    case(Q)
        4'b1010 : HUMANLED = 3'b010; //적
        4'b1111 : HUMANLED = 3'b001; //청
    endcase
end

assign 
endmodule


