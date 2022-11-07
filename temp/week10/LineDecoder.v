module LineDecoder(A3,A2,A1,A0,S3,S2,S1,S0);

input A3,A2,A1,A0;
output S3,S2,S1,S0;

reg [3:0] out; 

always @(A3,A2,A1,A0)
begin
case({A3,A2,A1,A0})
4'b0000 : out <= 4'b0000; //0
4'b0001 : out <= 4'b0001; //1
4'b0010 : out <= 4'b0010; //2
4'b0011 : out <= 4'b0011; //3
4'b0100 : out <= 4'b0100; //4
4'b0101 : out <= 4'b1000; //5
4'b0110 : out <= 4'b1001; //6
4'b0111 : out <= 4'b1010; //7
4'b1000 : out <= 4'b1011; //8
4'b1001 : out <= 4'b1100; //9
default : out <= 4'b0000; //NULL
endcase 
end

assign {S3,S2,S1,S0} = out;

endmodule