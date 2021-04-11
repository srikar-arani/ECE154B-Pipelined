module Multiplier_tb;
  reg clk, start,is_signed;
  reg [31:0] a,b;
  wire [63:0] s;

  Multiplier multiplier_test(
    .a(a),
    .b(b),
    .Clk(clk),
    .start(start),
    .Is_signed(is_signed),
    .s(s)
    );
  
  initial begin
    assign a = 5;
    assign b = 5;
    assign is_signed = 0;
    clk = 1;
    #10;
      
    if (s == 25) begin
        $display("PASS");
        #5;
        $stop;
    end else begin
        $display("FAIL");
        #5;
        $stop;
    end
    
  end

endmodule
