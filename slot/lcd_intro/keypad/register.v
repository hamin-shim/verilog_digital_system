module register(clk, rst, in, en, out);
  input clk, rst, en;
  input [6:0]in;
  output reg [6:0]out;
  
  always@(posedge clk or negedge rst) begin
    if (!rst) begin
      out <= 7'b0000000;
    end
    else begin
      if (en) out <= in;
    end
  end
endmodule