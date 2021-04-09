//[TODO:] Not Sure what else is needed


/*************************************
These are the basic elements of the
circuit. They are to be added to the
datapath
*************************************/

//ADDER
module adder(input [31:0] a, b,
	     output [31:0] y);

  assign y = a + b;

endmodule

//LEFT SHIFT BY 2 (Multiply by 4)
module sl2(input [31:0] a,
	   output [31:0] y);

  assign y = {a[29:0], 2'b00};

endmodule

//SIGN EXTENDER
module signext(input [15:0] a,
	       output [31:0] y);

  assign y = {{16{a[15]}}, a};

endmodule

//ZERO EXTENDER
module zeroext(input [15:0] a,
	       output [31:0] y);

  assign y = {{16{0}}, a};

endmodule

//RESETABLE FLIP FLOP
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

//2:1 MULTIPLEXER
module mux2 #(parameter WIDTH = 8)
	     (input [WIDTH-1:0] d0, d1,
	      input s,
	      output [WIDTH-1:0] y);

  assign y = s ? d1 : d0;

endmodule