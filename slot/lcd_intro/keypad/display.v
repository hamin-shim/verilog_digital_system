module display(rst, clk, scan_data, valid, r0,r1,r2,r3,r4,r5,r6,r7, en);
  input rst, clk;
  input [11:0]scan_data;
  input valid;
  output [6:0]r0,r1,r2,r3,r4,r5,r6,r7;
  reg [6:0]r0,r1,r2,r3,r4,r5,r6,r7;
  output reg en;
  reg [11:0]r8;
  reg [2:0]r9;
  reg [6:0]w;
  
  initial en <= 0;
  
  always@(posedge clk or negedge rst) begin
    if (!rst) begin
      r8 <= 12'b000000000000;
      r9 <= 3'b000;
      en <= 0;
      w <= 7'b1111110;
      r0 <= 0;
      r1 <= 0;
      r2 <= 0;
      r3 <= 0;
      r4 <= 0;
      r5 <= 0;
      r6 <= 0;
      r7 <= 0;
    end
    else begin
      if (valid) begin
        case(scan_data)
        12'b000000000001 : begin r8 <= 12'b000000000001; w <= 7'b0110000; end //1
        12'b000000000010 : begin r8 <= 12'b000000000010; w <= 7'b1101101; end //2
        12'b000000000100 : begin r8 <= 12'b000000000100; w <= 7'b1111001; end //3
        12'b000000001000 : begin r8 <= 12'b000000001000; w <= 7'b0110011; end //4
        12'b000000010000 : begin r8 <= 12'b000000010000; w <= 7'b1011011; end //5
        12'b000000100000 : begin r8 <= 12'b000000100000; w <= 7'b1011111; end //6
        12'b000001000000 : begin r8 <= 12'b000001000000; w <= 7'b1110000; end //7
        12'b000010000000 : begin r8 <= 12'b000010000000; w <= 7'b1111111; end //8
        12'b000100000000 : begin r8 <= 12'b000100000000; w <= 7'b1111011; end //9
        12'b010000000000 : begin r8 <= 12'b001000000000; en <= 1; end         //*
        12'b001000000000 : begin r8 <= 12'b010000000000; w <= 7'b1111110; end //0
        12'b100000000000 : begin r8 <= 12'b100000000000; r9 <= r9 + 1; w <= 7'b0000000; end //#
        endcase
      end      
      else begin   
        case(r9)
          3'b000 : r0 <= w;
          3'b001 : r1 <= w;
          3'b010 : r2 <= w;
          3'b011 : r3 <= w;
          3'b100 : r4 <= w;
          3'b101 : r5 <= w;
          3'b110 : r6 <= w;
          3'b111 : r7 <= w;
        endcase
      end
    end
  end
endmodule   
      
      
        