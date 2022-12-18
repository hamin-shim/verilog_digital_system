module clk_divide(
    input clk, rst,
    output reg clk_2, clk_4, clk_6
);

reg [1:0] count;
reg [1:0] count2;
reg enb;

// assign clk_out = count[3];

always @ (posedge clk) begin
    if (rst) begin
        count <= 2'b0;
        count2 <= 2'b0;
        clk_2 <= 1'b0;
        clk_4 <= 1'b0;
        clk_6 <= 1'b0;
    end
    else begin
        count <= count + 2'b1;

        clk_2 <= ~clk_2;
        
        if (count[0]) begin
            clk_4 <= ~clk_4;
        end
        

        if (count2 == 2'd2) begin
            count2 <= 2'b0;
            clk_6 <= ~clk_6;
        end
        else begin
            count2 <= count2 + 2'b1;
        end
    end
end

endmodule