module multiplier_tb;
  reg clk,start,is_signed;
  reg [31:0] a,b;
  wire [63:0] s;

  multiplier multiplier_test (
    .a(a),
    .b(b),
    .clk(clk),
    .start(start),
    .is_signed(is_signed),
    .s(s)
    );

  initial begin
    start <= 0;
    #10;
    start <= 1;
  end

  always begin
    clk <= 1;
    #5;
    clk <= 0;
    #5;
  end

  initial begin
    a <= 5;
    b <= 5;
  end

  always begin
    is_signed <= 0;
    #10;
    is_signed <= 1;
    #10;
  end

endmodule
