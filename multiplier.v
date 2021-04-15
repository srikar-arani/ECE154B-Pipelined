module multiplier(input  [31:0] a,b,
		  input clk,start,is_signed,
		  output [63:0] s);

  //value to hold result of multiplication
  reg [63:0] M;

  //multiplier Implementation
  always @ (posedge clk) begin
    case((is_signed & start))
      //lab says to assume no difference between signed and unsigned instructions
      1'b0: M <= M;
      1'b1: M <= a * b;
    endcase
  end

  assign s = M;

endmodule
