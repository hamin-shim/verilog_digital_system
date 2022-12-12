module textlcds3(resetn,clk,LCD_E,LCD_RS,LCD_RW,LCD_DATA);

input resetn,clk;
output LCD_E,LCD_RS,LCD_RW;
output [7:0]LCD_DATA;

wire LCD_E;
reg LCD_RS,LCD_RW;
reg [7:0] LCD_DATA;
reg [2:0] state;

parameter   delay          =3'b000, 
            function_set   =3'b001,
            entry_mode     =3'b010,
            disp_onoff     =3'b011,
            line1          =3'b100,  
            line2          =3'b101,
            delay_t        =3'b110,
            clear_disp     =3'b111;

integer CNT;

always @(negedge resetn or posedge clk)
begin
   if(!resetn) state = delay;
   else
   begin   
      case(state)
         delay:            if(CNT==70)    state = function_set;
         function_set:     if(CNT==30)    state = disp_onoff;
         disp_onoff:       if(CNT==30)    state = entry_mode;
         entry_mode:       if(CNT==30)    state = line1;
         line1:            if(CNT==20)    state = line2;
         line2:            if(CNT==20)    state = delay_t;
         delay_t:          if(CNT==400)   state = clear_disp;
         clear_disp:       if(CNT==200)   state = line1;
         default:                         state = delay;
      endcase
   end
end


always @(negedge resetn or posedge clk)
begin
   if(!resetn) CNT=0;
   else
      begin   
         case(state)
            delay:          if(CNT>=70)CNT=0;
                           else CNT=CNT+1;
            function_set:    if(CNT>=30)CNT=0;
                           else CNT=CNT+1;
            disp_onoff:      if(CNT>=30)CNT=0;
                           else CNT=CNT+1;
            entry_mode:      if(CNT>=30)CNT=0;
                           else CNT=CNT+1;
            line1:         if(CNT>=20)CNT=0;
                           else CNT=CNT+1;
            line2:         if(CNT>=20)CNT=0;
                           else CNT=CNT+1;
            delay_t:         if(CNT>=400)CNT=0;
                           else CNT=CNT+1;
            clear_disp:    if(CNT>=200)CNT=0;
                           else CNT=CNT+1;
            default:         CNT=0;
         endcase
      end
end




always @(posedge resetn or posedge clk)
begin
   if(!resetn) begin
      LCD_RS=1'b1;
      LCD_RW=1'b1;
      LCD_DATA=8'b00000000;
   end
   else
      begin   
         case(state)
            function_set:    begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00111000;
                           end
            disp_onoff:      begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00001100;
                           end
            entry_mode:      begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00000110;
                           end
            line1:         begin
                              LCD_RW=1'b0;
                              case(CNT)
                                 0:begin
                                    LCD_RS=1'b0;LCD_DATA=8'b10000000;//address
                                 end
                                 1:begin
                                    LCD_RS=1'b1;
                                    //d
                                 end
                                 2:begin
                                    LCD_RS=1'b1;
                                    //i
                                 end
                                 3:begin
                                    LCD_RS=1'b1;
                                    //g
                                 end
                                 4:begin
                                    LCD_RS=1'b1;
                                    //i
                                 end
                                 5:begin
                                    LCD_RS=1'b1;
                                    //t
                                 end
                                 6:begin
                                    LCD_RS=1'b1;
                                    //a
                                 end
                                 7:begin
                                    LCD_RS=1'b1;
                                    //l
                                 end
                                 8:begin
                                    LCD_RS=1'b1;
                                    //
                                 end
                                 9:begin
                                    LCD_RS=1'b1;
                                    //s
                                 end
                                 10:begin
                                    LCD_RS=1'b1;
                                    //y
                                 end
                                 11:begin
                                    LCD_RS=1'b1;
                                    //s
                                 end
                                 12:begin
                                    LCD_RS=1'b1;
                                    //t
                                 end
                                 13:begin
                                    LCD_RS=1'b1;
                                    //e
                                 end
                                 14:begin
                                    LCD_RS=1'b1;
                                    //m
                                 end
                                 15:begin
                                    LCD_RS=1'b1;
                                    //
                                 end
                                 16:begin
                                    LCD_RS=1'b1;
                                    //
                                 end
                                 default:begin
                                    LCD_RS=1'b1;LCD_DATA=8'b00100000;//
                                 end
                              endcase
                           end
            line2:         begin
                              LCD_RW=1'b0;
                              case(CNT)
                                 0:begin
                                    LCD_RS=1'b0;LCD_DATA=8'b11000000;//address
                                 end
                                 1:begin
                                    LCD_RS=1'b1;
                                    //h
                                 end
                                 2:begin
                                    LCD_RS=1'b1;
                                    //e
                                 end
                                 3:begin
                                    LCD_RS=1'b1;
                                    //l
                                 end
                                 4:begin
                                    LCD_RS=1'b1;
                                    //l
                                 end
                                 5:begin
                                    LCD_RS=1'b1;
                                    //o
                                 end
                                 6:begin
                                    LCD_RS=1'b1;
                                    //
                                 end
                                 7:begin
                                    LCD_RS=1'b1;
                                    //w
                                 end
                                 8:begin
                                    LCD_RS=1'b1;
                                    //o
                                 end
                                 9:begin
                                    LCD_RS=1'b1;
                                    //r
                                 end
                                 10:begin
                                    LCD_RS=1'b1;
                                    //l
                                 end
                                 11:begin
                                    LCD_RS=1'b1;
                                    //d
                                 end
                                 12:begin
                                    LCD_RS=1'b1;
                                    //!
                                 end
                                 13:begin
                                    LCD_RS=1'b1;
                                    // 
                                 end
                                 14:begin
                                    LCD_RS=1'b1;
                                    // 
                                 end
                                 15:begin
                                    LCD_RS=1'b1;
                                    // 
                                 end
                                 16:begin
                                    LCD_RS=1'b1;
                                    // 
                                 end
                                 default:begin
                                    LCD_RS=1'b1;LCD_DATA=8'b00100000;//
                                 end
                              endcase
                           end
            delay_t:         begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00000010;
                           end
            clear_disp:    begin
                              LCD_RS=1'b0;
                              LCD_RW=1'b0;
                              LCD_DATA=8'b00000001;
                           end
            default:         begin
                              LCD_RS=1'b1;
                              LCD_RW=1'b1;
                              LCD_DATA=8'b00000000;
                           end
         endcase
      end
end

assign LCD_E=clk;

endmodule
