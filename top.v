//[TODO:] Not Sure 

module adder(input [31:0] a, b,
	     output [31:0] y);

  assign y = a + b;

endmodule

module sl2(input [31:0] a,
	   output [31:0] y);

  assign y = {a[29:0], 2'b00};

endmodule

module signext(input [15:0] a,
	       output [31:0] y);

  assign y = {{16{a[15]}}, a};

endmodule

module zeroext(input [15:0] a,
	       output [31:0] y);

  assign y = {{16{0}}, a};

endmodule

module flopr #(parameter WIDTH = 8)
	      (input clk, reset,
	       input [WIDTH-1:0] d,
	       output reg[WIDTH-1:0] q);

  always @(posedge clk, posedge reset)
    begin
      if (reset) q <= 0;
      else q <= d;
    end

endmodule

module mux2 #(parameter WIDTH = 8)
	     (input [WIDTH-1:0] d0, d1,
	      input s,
	      output [WIDTH-1:0] y);

  assign y = s ? d1 : d0;

endmodule