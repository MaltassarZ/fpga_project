module lcd
(
	input clk_50,
	//output wire lcd_rs = 1'b0,
	//output wire lcd_rw = 1'b1,
	//output wire lcd_e = 1'b1,
	//output wire [3 : 0] lcd_d = 4'h0
	
	//-->//флаг считывания - 1 или записи данных - 0
	//-->input reg is_reading_not_writing,
	//-->//очистка дисплея - 1
	//-->input reg clear_display,
	//-->//установить дисплей в начало - 1
	//-->input reg first_pos_cursor,
	//-->//выводить символы слева-направо (инкремент позиции) - 1 или  справо-налево (декремент позиции) - 0
	//-->input reg direction,
	//-->//сдвигать экран - 1, не сдвигат - 0
	//-->input reg screen_shift,
	//-->//Выключить экран дисплея, сегменты погашены, содержимое внутренней памяти сохраняется - 0
	//-->//Включить экран дисплея, нормальный режим работы - 0
	//-->input reg z,
	//-->//включить отображение курсора - 1, выключить - 0
	//-->input reg dispaying_cursor,
	//-->//включить мигание курсора - 1, выключить - 0
	//-->input reg blinking_cursor,
	//-->//Выбрать экран (вместе с курсором) для сдвига - 1, Выбрать курсор для сдвига - 0
	//-->input reg zz,
	//-->//сдвиг вправо - 1, сдвиг влево - 0
	//-->input reg right_shift,
	//-->//8-битный интерфейс ввода/вывода данных - 1, 4-битный интерфейс ввода/вывода данных - 0
	//-->input reg eight_bit_interface,
	//-->//2-строки вывода символов - 1, 1 строка вывода символа - 0
	//-->input reg two_lines,
	//-->//Размер шрифта 5×11 пикселей - 1, 5×8 пикселей - 0
	//-->input reg front_size_5_11_or_5_8,
	//-->//Контроллер дисплея занят выполнением внутренних операций - 1
	//-->//Контроллер дисплея готов к обработке новой команды - 0
	//-->input reg zzzzzzz,
	
	output lcd_rs,
	output lcd_rw,
	output lcd_e,
	output [3 : 0] lcd_d
);

reg 				init_flag 		= 1'b0;
reg	[19 : 0] init_counter 	= 20'h0;
reg				symbol_counter = 1'b0;
reg 	[11 : 0] delay_counter 	= 12'h0;

reg r_lcd_rs = 1'b1;
reg r_lcd_rw = 1'b0;
reg r_lcd_e = 1'b1;
reg [3 : 0] r_lcd_d = 4'h4;

assign lcd_rs = init_flag ? w_lcd_rs : r_lcd_rs;
assign lcd_rw = init_flag ? w_lcd_rw : r_lcd_rw;
assign lcd_e = init_flag ? w_lcd_e : r_lcd_e;
assign lcd_d = init_flag ? w_lcd_d : r_lcd_d;

always @(negedge clk_50)
//инициализация
begin
	//r_lcd_e <= 1'b1;
	//r_lcd_e <= ~r_lcd_e;
	
	r_lcd_rw <= 1'b1;
	r_lcd_rs <= 1'b0;
	
	if (init_counter < 20'd1015082)
		begin
			init_counter <= init_counter + 1'b1;
		end
	else
	begin
		init_flag <= 1'b0;
			if (symbol_counter == 1'b0) 
				begin
					symbol_counter <= 1'b1;
					//r_lcd_d <= ~(LCD_SYMBOL(4'h7) >> 4);
					r_lcd_d [3 : 0] <= ~(LCD_SYMBOL(4'h7) >> 4);
				end
			else
				if (symbol_counter == 1'b1)
					begin
						delay_counter <= delay_counter + 1'b1;
						if (delay_counter == 12'd2150)
							begin
								symbol_counter <= 1'b0;
								delay_counter <= 12'h0;
								r_lcd_d [3 : 0] <= ~(LCD_SYMBOL(4'h7));
							end
					end
	end
end

//lcd symbols
function [7 : 0] LCD_SYMBOL;
input [4 : 0] num_symbol;
begin
	case (num_symbol)
		4'h0 : LCD_SYMBOL = 8'b00110000;
		4'h1 : LCD_SYMBOL = 8'b00110001;
		4'h2 : LCD_SYMBOL = 8'b00110010;
		4'h3 : LCD_SYMBOL = 8'b00110011;
		4'h4 : LCD_SYMBOL = 8'b00110100;
		4'h5 : LCD_SYMBOL = 8'b00110101;
		4'h6 : LCD_SYMBOL = 8'b00110110;
		4'h7 : LCD_SYMBOL = 8'b00110111;
		4'h8 : LCD_SYMBOL = 8'b00111000;
		4'h9 : LCD_SYMBOL = 8'b00111001;
		4'ha : LCD_SYMBOL = 8'b01000001;
		4'hb : LCD_SYMBOL = 8'b01000010;
		4'hc : LCD_SYMBOL = 8'b01000011;
		4'hd : LCD_SYMBOL = 8'b01000100;
		4'he : LCD_SYMBOL = 8'b01000101;
		4'hf : LCD_SYMBOL = 8'b01000110;
	endcase
end
endfunction

lcd_init lcd_init (
.init_flag(init_flag),
.clk_50(clk_50),
.lcd_rs(w_lcd_rs),
.lcd_rw(w_lcd_rw),
.lcd_e(w_lcd_e),
.lcd_d(w_lcd_d)
);

endmodule