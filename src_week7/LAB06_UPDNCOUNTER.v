// » 동기식 Up/Down Counter
module LAB06_UPDNCOUNTER(RESETN, CLK, UPDN, Q);
input RESETN,CLK,UPDN;
output [3:0] Q;
reg [3:0] Q;

always @ (posedge CLK or posedge UPDN)
begin
//조건문 작성
if (RESETN) begin 
    Q = 4'b0000;
    end//리셋이 1일 때
else if (UPDN==0) begin  //UP Counter일 때, 

if ( Q == 4'b1111 ) begin 
    Q = 4'b0000; // 1111이 되면 0000으로
end
else begin
    Q++; 
end

end
else if (UPDN==1)begin //Down Counter일 때
if ( Q == 4'b0000 ) begin 
    Q = 4'b1111; 
end
else begin
    Q--; 
end
// 0000이 되면 1111으로 
end
endmodule

