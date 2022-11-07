// » 기본 신호등 설계
module LAB06_SIGNAL_LAMP(RESETN, CLK, Q, LED);
input RESETN,CLK,UPDN;
output [2:0] LED;
output [3:0] Q;

wire [3:0] Q;
reg [2:0] LED;


LAB06_UPDNCOUNTER U0(RESETN, CLK, UPDN, Q);
//UPDNCOUNTER 모듈 호출

always @ (posedge CLK or posedge RESETN)
begin
case(Q)
//조건문 작성
begin 
//Q값에 따라 LED할당;
// //– Q가 5일 때는 Red, LED = 3’b001
//     Q가 10일 때는 Yellow, LED = 3’b011
//     Q가 15일 때는 Green, LED = 3’b010
4'b0101 : LED = 3’b001;
4'b1010 : LED = 3’b011;
4'b1111 : LED = 3’b010;

end


endcase
end
endmodule

