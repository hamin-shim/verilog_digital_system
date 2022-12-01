module keypad_scan(
input rst, clk,
input [11:0] keypad_in,
output reg [11:0] scan_out = 0,
output reg valid = 0);

reg en;

always @(posedge clk or negedge rst) begin

if (~rst) begin		//active-low reset
	en <= 0;
	scan_out <= 0;
	valid <= 0;
end
else begin
	if (keypad_in && ~en) begin	//if keypad input occurred, generate output and valid signal
		scan_out <= keypad_in;
		valid <= 1'b1;
		en <= 1'b1;
	end
	else if (keypad_in && en) begin	//after 1 clock passed, make valid signel to 0
		valid <= 0;
		scan_out <= 0;
	end
	else begin		//when keypad input disappear, return to initial condition
		en <= 0;
		valid <= 0;
		scan_out <= 0;
	end
end

end

endmodule