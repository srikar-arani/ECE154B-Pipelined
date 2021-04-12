module inst_memory(input [31:0]  address,
            	   output [31:0] read_data);

  reg [31:0] RAM[63:0];

  initial
    begin
      $readmemh("memfile.dat",RAM); // initialize memory with test program
    end

  assign read_data = RAM[address[31:2]]; // word aligned

endmodule
