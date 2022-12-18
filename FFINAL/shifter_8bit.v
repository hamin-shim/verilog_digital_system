module shifter_8bit(clk,reset,c_out,sel);
	input clk;
	input reset; 
	input sel;	
	
	output reg [7:0] c_out;

	initial begin
	c_out = 8'b1000000;
	end
	always@(posedge clk)begin
		if(reset == 1'b1) c_out = 8'b10000000;
		if(c_out == 8'b00000001) c_out = 8'b10000000;
		else begin
			case(sel)	
				0:c_out = c_out;	
				1:c_out = {1'b0,c_out[7:1]}; //sel == 010 srl (Shift Right Logical) 
				default: c_out = c_out;
			endcase
		end
	end
endmodule