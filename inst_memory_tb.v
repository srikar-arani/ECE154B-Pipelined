module inst_memory_tb();
	reg [31:0] address;
	wire [31:0] read_data;
	
	inst_memory imem_test(
		.address(address),
		.read_data(read_data)
	);

	integer i;

	initial begin
		assign address = 8'h00400000;
		#10;
		for (i = 1; i < 10; i = i + 1) begin
			$display("test#%1d is equal to %h", i, read_data);
			assign address = address + 8'h00000004;
			#10;
		end
	end
endmodule
