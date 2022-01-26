module lcd_init
(
	input init_flag,
	input clk_50,
	output lcd_rs,
	output lcd_rw,
	output lcd_e,
	output [3 : 0] lcd_d
);

reg [19 : 0] counter = 20'h0;
reg [5 : 0] init_counter = 6'h0;

reg r_lcd_rs = 1'b1;
reg r_lcd_rw = 1'b0;
reg r_lcd_e = 1'b1;
reg [3 : 0] r_lcd_d = 4'h4;

assign lcd_rs = r_lcd_rs;
assign lcd_rw = r_lcd_rw;
assign lcd_e = r_lcd_e;
assign lcd_d = r_lcd_d;

always @(posedge clk_50)
begin
if (init_flag)
	begin
		r_lcd_rs <= 1'b1;
		r_lcd_rw <= 1'b1;
		if (counter <= 19'd1015082)
			counter <= counter + 1'b1;
		
		if (counter == 19'd800000	||
			counter == 19'd1010000 ||
			counter == 19'd1015050)
				init_counter <= init_counter + 1'b1;
		
		if (counter >= 19'd1015051 && counter <= 19'd1015082 )
			init_counter <= init_counter + 1'b1;
			
		//if ( init_counter >= 2'd3 )
		//	init_counter <= init_counter + 1'b1;
		//else
			
			
		case (init_counter)
		//4'd1: lcd_d <= 4'b0011;
		//
		//4'd2: lcd_d <= 4'b0011;
		//
		//4'd3: lcd_d <= 4'b0010;
		//
		//4'd4: lcd_d <= 4'b0010;
		//4'd5: lcd_d <= 4'b1000;
		//
		//4'd6: lcd_d <= 4'b0000;
		//4'd7: lcd_d <= 4'b0001;
		//
		//4'd8: lcd_d <= 4'b0000;
		//4'd9: lcd_d <= 4'b0110;
		//
		//4'd10: lcd_d <= 4'b0000;
		//4'd11: lcd_d <= 4'b1100;
		6'd1: r_lcd_e <= 1'b0;
		6'd2: r_lcd_d <= 4'b1100;
		6'd3: r_lcd_e <= 1'b1;//0
		6'd4: r_lcd_e <= 1'b0;
		6'd5: r_lcd_d <= 4'b1100;
		6'd6: r_lcd_e <= 1'b1;
		6'd7: r_lcd_e <= 1'b0;//1
		6'd8: r_lcd_d <= 4'b1100;
		6'd9: r_lcd_e <= 1'b1;
		6'd10: r_lcd_e <= 1'b0;//1
		6'd11: r_lcd_d <= 4'b1101;
		6'd12: r_lcd_e <= 1'b1;
		6'd13: r_lcd_e <= 1'b0;//1
		6'd14: r_lcd_d <= 4'b1101;
		6'd15: r_lcd_e <= 1'b1;
		6'd16: r_lcd_e <= 1'b0;//1
		6'd17: r_lcd_d <= 4'b1111;
		6'd18: r_lcd_e <= 1'b1;
		6'd19: r_lcd_e <= 1'b0;//1
		6'd20: r_lcd_d <= 4'b1111;
		6'd21: r_lcd_e <= 1'b1;
		6'd22: r_lcd_e <= 1'b0;//1
		6'd23: r_lcd_d <= 4'b0111;
		6'd24: r_lcd_e <= 1'b1;
		6'd25: r_lcd_e <= 1'b0;//1
		6'd26: r_lcd_d <= 4'b1111;
		6'd27: r_lcd_e <= 1'b1;
		6'd28: r_lcd_e <= 1'b0;//1
		6'd29: r_lcd_d <= 4'b1110;
		6'd30: r_lcd_e <= 1'b1;
		6'd31: r_lcd_e <= 1'b0;//1
		6'd32: r_lcd_d <= 4'b1111;
		6'd33: r_lcd_e <= 1'b1;
		6'd34: r_lcd_e <= 1'b0;//1
		6'd35: r_lcd_d <= 4'b0011;
		endcase
		//
	end
end

endmodule