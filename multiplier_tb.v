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

  //[TODO:] multiplier testbench

endmodule
