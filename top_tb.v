module top_tb();
	reg clk;
	reg reset;

	top dut(.clk(clk), .reset(reset));

	initial begin
		reset <= 1; #22; reset <= 0;
	end
	
	always begin
		clk <= 1; #5; clk <= 0; #5;
	end
	
	
endmodule

