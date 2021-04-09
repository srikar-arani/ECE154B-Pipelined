module regfile_tb;
  reg [4:0] pr1,pr2,wr;
  reg clk,write,reset;
  reg [31:0] wd;
  wire [31:0] rd1,rd2;

  reg_file regfile_test (
    .pr1(pr2),
    .pr2(pr2),
    .wr(wr),
    .clk(clk),
    .write(write),
    .reset(reset),
    .wd(wd),
    .rd1(rd1),
    .rd2(rd2)
  );

  //[TODO:] reg_file testbench

endmodule
