`timescale 1ns/1ns
module TB();
	reg rst = 1, clk = 0;
	MultiCycle UUT(clk, rst);
	always #50 clk = ~clk;
	initial begin
	#30 rst = 0;
	#120000 $stop;
	end
endmodule 