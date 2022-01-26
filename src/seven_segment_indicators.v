module seven_seg_indicators
(
	input clk_50,
	input reset,
	output [3 : 0] num_indicator,
	output [7 : 0] indicator_seg
);

//counter
reg [25 : 0] counter = 26'h0;
reg [13 : 0] time_counter = 14'h0;
reg [17 : 0] seven_seg_counter = 18'h0;

reg [3 : 0] r_num_indicator = 4'b1110;
reg [7 : 0] r_indicator_seg = 8'h0;

assign num_indicator = r_num_indicator;
assign indicator_seg = r_indicator_seg;

always @(negedge clk_50)
begin
	if (!reset)
	begin
		counter <= 26'h0;
		time_counter <= 14'h0;
		r_indicator_seg <= NUMBERS(1'b0);
	end
	else
		begin
			counter <= counter + 1'h1;
			if (counter >= 26'd50000000)
			begin
				time_counter <= time_counter + 1'h1;
				counter <= 26'h0;
			end
			
			seven_seg_counter <= seven_seg_counter + 1'b1;
			
			if (seven_seg_counter == 18'd200000)
				begin
					case (r_num_indicator)
					4'b0111 :
						begin
							r_indicator_seg [7 : 0] <= NUMBERS(time_counter % 10);
							r_num_indicator <= 4'b1110;
						end
					4'b1110 : 
						begin
							r_indicator_seg [7 : 0] <= NUMBERS(time_counter / 10 % 10);
							r_num_indicator <= 4'b1101;
						end
					4'b1101 : 
						begin
							r_indicator_seg [7 : 0] <= NUMBERS(time_counter / 100 % 10);
							r_num_indicator <= 4'b1011;
						end
					4'b1011 : 
						begin
							r_indicator_seg [7 : 0] <= NUMBERS(time_counter / 1000);
							r_num_indicator <= 4'b0111;
						end
					endcase
					seven_seg_counter <= 18'h0;
				end
		end

end

function [7 : 0] NUMBERS;
input [3 : 0] num;
	begin
		case (num)
			4'd0 : NUMBERS = 8'b11000000;
			4'd1 : NUMBERS = 8'b11111001;
			4'd2 : NUMBERS = 8'b10100100;
			4'd3 : NUMBERS = 8'b10110000;
			4'd4 : NUMBERS = 8'b10011001;
			4'd5 : NUMBERS = 8'b10010010;
			4'd6 : NUMBERS = 8'b10000010;
			4'd7 : NUMBERS = 8'b11111000;
			4'd8 : NUMBERS = 8'b10000000;
			4'd9 : NUMBERS = 8'b10010000;
		endcase
	end
endfunction

endmodule