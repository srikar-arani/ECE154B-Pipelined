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

  initial begin
    reset <= 1;
    #10;
    reset <= 0;
    #40;
    reset <= 1;
    #10;
    reset <= 0;
  end

  always begin
    clk <= 1;
    #5;
    clk <= 0;
    #5;
  end

  initial begin
    write <= 0;
    #50;
    write <= 1;
  end

  integer i;

  initial begin
    assign pr1 = 5'b00101;
    assign pr2 = 5'b11111;
    assign wr = 5'b00101;
    assign wd = 32'h10101010;
    for (i = 0; i < 8; i = i+1) begin
      //assign pr1 = pr1 + 5'b1;
      assign pr2 = pr2 - 5'b1;
      #10;
    end
  end

endmodule
