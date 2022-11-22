module HB_PIANO(RESETN,CLK,KEY,PIEZO);
    input RESETN, CLK;
    input [7:0] KEY;
    output PIEZO;

    reg BUFF;
    reg [7:0] CNT_SOUND;
    reg [7:0] LIMIT;

    wire PIEZO;
    always @(KEY) begin
        case (KEY)
            8'b10000000 : LIMIT = 956;
            8'b01000000 : LIMIT = 851;
            8'b00100000 : LIMIT = 758;
            8'b00010000 : LIMIT = 716;
            8'b00001000 : LIMIT = 638;
            8'b00000100 : LIMIT = 568;
            8'b00000010 : LIMIT = 508;
            8'b00000001 : LIMIT = 478;
            default : LIMIT = 0;
        endcase 
    end
    always @ (posedge CLK) begin
        if(RESETN) begin
            BUFF = 1'b0;
            CNT_SOUND = 0;
        end
        else begin
            if(CNT_SOUND >= LIMIT) begin 
                CNT_SOUND = 0;
                BUFF = ~BUFF;
            end
            else CNT_SOUND = CNT_SOUND + 1;
        end
    end
    assign PIEZO = BUFF;
endmodule