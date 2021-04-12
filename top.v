module top(input clk, reset);

  wire [31:0] pc, instr, readdata;
  wire [31:0] writedata, dataadr;
  wire        memwrite;
  
  // processor and memories are instantiated here 
  mips mips(clk, reset, pc, instr, memwrite, dataadr, writedata, readdata);
  inst_memory imem(pc, instr);
  data_memory dmem(clk, memwrite, dataadr, writedata, readdata);

endmodule


module mips(input          clk, reset,
            output  [31:0] pc,
            input   [31:0] instr,
            output         memwrite,
            output  [31:0] aluout, writedata,
            input   [31:0] readdata);

  wire       memtoreg, branch, bne, pcsrc, eq_ne, alusrcA, alusrcB, se_ze, start_mult, mult_sign, regdst, regwrite, memread, output_branch;
  wire [1:0] out_select;
  wire [3:0] alu_op;

  assign eq_ne =  0;

  controller c(instr[31:26], instr[5:0], eq_ne,
               memwrite, memread, regwrite,
               alusrcA, alusrcB, se_ze, start_mult, mult_sign, memtoreg, pc_source, out_select,
               alu_op, output_branch);
  datapath dp(clk, reset, memread, regwrite,
              alusrcA, alusrcB,
              se_ze, regdst,
	      start_mult, mult_sign,
	      memtoreg, output_branch,
	      out_select,
              alu_op,
              pc,
              instr,
              aluout, writedata,
              readdata);

endmodule





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