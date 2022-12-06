module clk_div8(clk,reset,next_clk);
input clk,reset;
output reg next_clk;
 
integer i;
 
always @(negedge reset, posedge clk) begin
    if(~reset) begin
        i = 0;
        next_clk = 0;
    end
    else begin
        i = i+1;
        if(i==10) begin
            i = 0;
            next_clk = next_clk+1;
        end
    end
end
 
endmodule
