module regfile(input Clk,
	       input Write,
	       input Reset,
	       input [4:0] PR1, PR2, WR,
	       input [31:0] WD,
	       output [31:0] RD1, RD2);

	reg [31:0] rf[31:0];

  
  // Reset Values
	assign RD1 = 0;
	assign RD2 = 0;

	always @(posedge Clk, posedge Reset) begin
    // Only assign if Reset is 0 
		if (Write & !Reset) rf[WR] <= WD;
	end
	
	assign RD1 = (PR1 != 0) ? rf[PR1] : 0;
	assign RD2 = (PR2 != 0) ? rf[PR2] : 0;

endmodule
