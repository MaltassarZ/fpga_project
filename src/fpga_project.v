module fpga_project
(
	input clk_50,
	input reset,
	
	//buttons
	input [3 : 0] buttons_num,
	
	//leds
	output [3 : 0] leds, //инверсия
	
	//signal
	//output reg signal = 1'b1,
	
	//lcd-display
	output lcd_rs,
	output lcd_rw,
	output lcd_e,
	output [3 : 0] lcd_d,
	
	//7-segment indicators
	output [3 : 0] num_indics,
	output [7 : 0] seven_seg_indics,
	
	//signal
	//output reg signal = 1'b1,
	
	//uart
	output uart_tx,
	output uart_rx
);
//
reg [28 : 0] button_counter = 29'h0;

wire [3 : 0] w_num_indics;
wire [7 : 0] w_seven_seg_indics;
//wire w_lcd_rs;
//wire w_lcd_rw;
//wire w_lcd_e;
//wire [3 : 0] w_lcd_d;
//
//assign num_indics = w_num_indics;
//assign seven_seg_indics = w_seven_seg_indics;
//assign lcd_rs = w_lcd_rs;
//assign lcd_rw = w_lcd_rw;
//assign lcd_e = w_lcd_e;
//assign lcd_d = w_lcd_d;

always @(negedge clk_50)
begin
	//if (buttons[0] || buttons[1] || buttons[2] || buttons[3])
	//begin
	//	button_counter <= button_counter + 1'b1;
	//	leds <= buttons;
	//end
	//else
	//	button_counter <= 29'h0;
	//num_indics <= num_indic;
	//seven_seg_indics <= seven_seg;
end


///////конект дожен быть через wire
lcd lcd(
.clk_50(clk_50),
.lcd_rs(lcd_rs),
.lcd_rw(lcd_rw),
.lcd_e(lcd_e),
.lcd_d(lcd_d)
);

seven_seg_indicators seven_seg_indicators(
.clk_50(clk_50),
.reset(reset),
.num_indicator(num_indics),
.indicator_seg(seven_seg_indics)
);

buttons buttons(
.clk(clk_50),
.num_button(buttons_num),
.num_led(leds)
);

uart_usb uart_usb(
.clockIN(clk_50),
.nTxResetIN(reset),
.txDataIN(),
.txLoadIN(),

.nRxResetIN(),
.rxIN(), 
.rxIdleOUT(),
.rxReadyOUT(),
.rxDataOUT()
);

endmodule