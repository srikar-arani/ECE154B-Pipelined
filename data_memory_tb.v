module data_memory_tb();
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

  initial begin
    write <= 0;
    #50;
    write <= 1;
  end

  always begin
    clk <= 1;
    #5;
    clk <= 0;
    #5;
  end

  reg [31:0] RAM[63:0];

  initial begin
    $readmemh("memfile.dat",RAM);
  end

  always begin
    address <= 31'h00000004;
    #10;
    address <= 31'h00000008;
    #10;
  end

endmodule
