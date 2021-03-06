module reg_file(input clk,
	       input write,
	       input reset,
	       input [4:0] pr1, pr2, wr,
	       input [31:0] wd,
	       output [31:0] rd1, rd2);

  reg [31:0] rf[31:0];

  integer i;

  always @(posedge ~clk) begin
    if (reset) begin
      for (i = 0; i < 31; i=i+1) rf[i] = 0;
    end
    else if (write) rf[wr] <= wd;
  end

  assign rd1 = (pr1 != 0) ? rf[pr1] : 0;
  assign rd2 = (pr2 != 0) ? rf[pr2] : 0;

endmodule
