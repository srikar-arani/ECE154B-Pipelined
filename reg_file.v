module regfile(input clk,
	       input write,
	       input reset,
	       input [4:0] pr1, pr2, wr,
	       input [31:0] wd,
	       output [31:0] rd1, rd2);

  reg [31:0] rf[31:0];

  
  // Reset Values
  assign rd1 = 0;
  assign rd2 = 0;

  always @(posedge clk, posedge reset) begin
    // Only assign if reset is 0 
    if (write & !reset) rf[wr] <= wd;
  end

  assign rd1 = (pr1 != 0) ? rf[pr1] : 0;
  assign rd2 = (pr2 != 0) ? rf[pr2] : 0;

endmodule
