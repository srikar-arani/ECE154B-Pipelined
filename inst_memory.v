module imem(input [5:0]  address,
            output [31:0] read_data);

  reg [31:0] RAM[63:0];

  initial
    begin
      $readmemh("memfile2.dat",RAM); // initialize memory with test program. Change this with memfile2.dat for the modified code
    end

  assign read_data = RAM[address]; // word aligned

endmodule