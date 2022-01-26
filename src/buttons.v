module buttons
(
	input clk,
	input [3 : 0] num_button,
	output reg [3 : 0] num_led
);

always @(negedge clk)
begin
	if (num_button[0] || num_button[1] || num_button[2] || num_button[3])
	begin
		num_led <= num_button;
	end
end

endmodule