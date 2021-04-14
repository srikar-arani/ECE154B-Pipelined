module reg_file_tb();

	reg [4:0] PR1, PR2, WR;
	reg [31:0] WD;
	reg clk, write, reset;
	wire [31:0] RD1, RD2;

	reg_file dut(.pr1(PR1), .pr2(PR2), .wr(WR), .wd(WD), .clk(clk), .write(write), .reset(reset), .rd1(RD1), .rd2(RD2));
	
	always #5 clk <= ~clk;
	
	initial begin
		clk = 0; write = 0; reset = 0; PR1 = 0; PR2 = 0; 
		#1 $display("RD1: %h, RD2: %h", RD1, RD2); // reading $0 should be 0
		#1 PR1 = 8; PR2 = 9; reset = 1;
		#2 $display("RD1: %h, RD2: %h", RD1, RD2); // rf not reset yet, should be junk values
		#1 // posedge of clk so rf is reset
		#1 $display("RD1: %h, RD2: %h", RD1, RD2); // rf reset, should be 0
		#1 reset = 0; write = 1; WR = 8; WD = 32'haa998877;
		#8 // posedge should write 32'haa998877 to rf[8];
		#1 write = 0;
		#1 $display("RD1: %h, RD2: %h", RD1, RD2); // rf[8] = 32'haa998877, rf[9] = 0
		#1 write = 1; WR = 9; WD = 32'h12345678;
		#7 // posedge should write 32'h12345678 to rf[9];
		#1 write = 0;
		$display("RD1: %h, RD2: %h", RD1, RD2); // rf[8] = 32'haa998877, rf[9] = 32'h12345678
		#1 write = 1; WR = 8; WD = 32'hFFFF0000;
		#8 // posedge should write 32'hFFFF0000 to rf[8];
		#1 write = 0;
		$display("RD1: %h, RD2: %h", RD1, RD2); // rf[8] = 2'hFFFF0000, rf[9] = 32'h12345678


	end

endmodule
