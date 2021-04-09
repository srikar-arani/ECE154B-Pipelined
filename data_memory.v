module data_memory(input clk, write,
            input [31:0] address, write_data,
            output [31:0] read_data);

  reg [31:0] RAM[63:0];

  assign read_data=RAM[address[31:2]];

  always @(posedge clk) begin
    if (write) RAM[address[31:2]] <= write_data;
  end

endmodule
