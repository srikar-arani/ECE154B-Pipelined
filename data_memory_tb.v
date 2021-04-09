module dmem_tb;
  reg [31:0] address,write_data;
  reg clk,write;
  wire [31:0] read_data;

  data_memory dmem_test (
    .address(address),
    .write_data(write_data),
    .clk(clk),
    .write(write),
    .read_data(read_data)
  );

  //[TODO:] data_memory testbench

endmodule
