// » 엘리베이터 모듈
module LAB06_ELEVATOR(RESETN, CLK, SW, Q, a,b,c,d,e,f,g);
input RESETN,CLK;
input [3:0] SW;

output [3:0] Q;
output a,b,c,d,e,f,g;

reg [3:0] Q;

always @ (posedge CLK or posedge RESETN)
begin
//조건문 작성
// 리셋일 때 1층
//SW가 Q보다 클 때, 엘리베이터 상승
//SW가 Q보다 작을 때, 엘리베이터 하강
if (RESETN) begin 
    Q = 4'b0001;
    end//리셋이 1일 때
else if (SW > Q) begin  

while (SW > Q) begin
    Q++;
end

end

else if (SW < Q) begin  

while (SW < Q) begin
    Q--;
end

end

end

LAB06_SEG U0(Q, a, b, c, d, e, f, g);
//LAB06_SEG 함수 호출
endmodule



module LAB06_SEG(SW, a, b, c, d, e, f, g);

input [3:0] SW;
output a, b, c, d, e, f, g;
reg [6:0] SEG;

always @(SW)
begin
  case(SW)
4'b0000 : SEG = 7'b1111110; //0
4'b0001 : SEG = 7'b0110000; //1
4'b0010 : SEG = 7'b1101101; //2
4'b0011 : SEG = 7'b1111001; //3
4'b0100 : SEG = 7'b0110011; //4
4'b0101 : SEG = 7'b1011011; //5
4'b0110 : SEG = 7'b1011111; //6
4'b0111 : SEG = 7'b1110000; //7
4'b1000 : SEG = 7'b1111111; //8
4'b1001 : SEG = 7'b1111011; //9
default : SEG = 7'b0000000; //NULL
  endcase
end
assign {a, b, c, d, e, f, g} = SEG;
