module seg_controller(
  input clk,
  input rst_x,
  input[7-1:0]seg_0,
  input[7-1:0]seg_1,
  input[7-1:0]seg_2,
  input[7-1:0]seg_3,
  input[7-1:0]seg_4,
  input[7-1:0]seg_5,
  input[7-1:0]seg_6,
  input[7-1:0]seg_7,
  output[7-1:0]seg_display,
  output[8-1:0]array_en);
  
  reg[7-1:0] seg_display_internal;
  reg[8-1:0] array_en_internal;
  
  reg[3-1:0] scan_loc;
  
  always@(posedge clk or negedge rst_x) begin
    if(~rst_x) begin
      array_en_internal <= 8'b00000000;
      seg_display_internal <= 7'b0000000;
      scan_loc <= 3'b000;
    end
    else begin
      if(scan_loc == 3'b111) begin
        scan_loc <= 3'b000;
      end
    else begin
      scan_loc <= scan_loc + 1'b1;
    end
    case(scan_loc)
      3'd0: begin array_en_internal <= 8'b11111110; seg_display_internal <= seg_0; end
      3'd1: begin array_en_internal <= 8'b11111101; seg_display_internal <= seg_1; end
      3'd2: begin array_en_internal <= 8'b11111011; seg_display_internal <= seg_2; end
      3'd3: begin array_en_internal <= 8'b11110111; seg_display_internal <= seg_3; end
      3'd4: begin array_en_internal <= 8'b11101111; seg_display_internal <= seg_4; end
      3'd5: begin array_en_internal <= 8'b11011111; seg_display_internal <= seg_5; end
      3'd6: begin array_en_internal <= 8'b10111111; seg_display_internal <= seg_6; end
      3'd7: begin array_en_internal <= 8'b01111111; seg_display_internal <= seg_7; end
      default: begin array_en_internal <= 8'b11111111; seg_display_internal <= seg_0; end
    endcase
  end
end

  assign seg_display = seg_display_internal;
  assign array_en = array_en_internal;
      

endmodule