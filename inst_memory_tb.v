module imem_tb;
  reg [31:0] address;
  wire [31:0] read_data;

  inst_memory imem_test (
    .address(address),
    .read_data(read_data)
  );

  //[TODO:] inst_memory testbench

endmodule
