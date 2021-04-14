module inst_memory_tb();
  reg [31:0] address;
  wire [31:0] read_data;

  inst_memory imem_test (
    .address(address),
    .read_data(read_data)
  );

  //[TODO:] inst_memory testbench

  integer i;

  initial
    begin
      assign address = 8'h00000000;
      #20;
      assign address = 8'h00000004;
      #20;
      assign address = 8'h00000008;
      #20;
      assign address = 8'h0000000C;
      #20;
      assign address = 8'h00000010;
      #20;
      assign address = 8'h00000014;
      #20;
      assign address = 8'h00000018;
      #20;
      assign address = 8'h0000001C;
      #20;
      assign address = 8'h00000020;
      #20;
    end

endmodule
