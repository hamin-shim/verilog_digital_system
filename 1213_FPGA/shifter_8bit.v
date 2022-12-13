module shifter_8bit(clk,reset,c_in,c_out,sel);
	input clk;
	input reset; 
	input [7:0]c_in;
	output reg [7:0] c_out;
	input [2:0]sel;	

	always@(posedge clk)begin
		if(reset == 1'b1)	
			c_out = 8'b10000000;
		else begin
			case(sel)	
				3'd1:c_out = {c_out[6:0],1'b0};	
				3'd2:c_out = {1'b0,c_out[7:1]}; //sel == 010 srl (Shift Right Logical) 
				3'd3:c_out = {c_out[6:0],1'b0};		
				3'd4:c_out = {c_out[7],c_out[7:1]};	
				3'd5:c_out = {c_out[6:0],c_out[7]};	
				3'd6:c_out = {c_out[0],c_out[7:1]};	
				default: c_out = c_out;
			endcase
		end
	end
endmodule