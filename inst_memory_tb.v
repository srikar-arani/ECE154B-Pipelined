module inst_memory_tb();
	reg [31:0] address;
	wire [31:0] read_data;
	
	inst_memory imem_test (
    .address(address),
    .read_data(read_data)
  );

  integer i;

	initial begin
		assign address = 8'h00000000;
		#10;
		if (read_data == 8'h20020005) begin
			$display("PASS");
			#5;
			$stop;
		end else begin
			$display("FAIL");
			#5;
			$stop;
		end
	end

endmodule
