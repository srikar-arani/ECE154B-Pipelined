module inst_memory(input [31:0]  address,
            	   output [31:0] read_data);



  //[TODO:]This module needs to be updated. Not sure how to actually do this, so it would be good to take a look

  reg [31:0] RAM[63:0];

  initial
    begin
      $readmemh("memfile.dat",RAM); // initialize memory with test program. Change this with memfile2.dat for the modified code
    end

  assign read_data = RAM[address[7:2]]; // word aligned

endmodule