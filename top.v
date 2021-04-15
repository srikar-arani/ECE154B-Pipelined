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

  wire       memtoreg, branch, bne, eq_ne, alusrcA, alusrcB, se_ze, start_mult, mult_sign, regdst, regwrite, memread, output_branch;
  wire [1:0] out_select, pc_source;
  wire [3:0] alu_op;

  assign eq_ne =  0;

  controller c(instr[31:26], instr[5:0], eq_ne,
               memwrite, memread, regwrite,
               alusrcA, alusrcB, se_ze, regdst, start_mult, mult_sign, memtoreg, pc_source, out_select,
               alu_op, output_branch);
  datapath dp(clk, reset, memread, regwrite, memwrite,
              alusrcA, alusrcB,
              se_ze, regdst,
	      start_mult, mult_sign,
	      memtoreg, output_branch,
	      out_select,
              alu_op,
	      pc_source,
              pc,
              instr,
              aluout, writedata,
              readdata,
              eq_ne
              );

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

  assign y = {{16{1'b0}}, a};

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

//FLIP FLOP REGISTER (ENABLE)
module flopre #(parameter WIDTH = 8)
	      (input clk, reset, enable,
	       input [WIDTH-1:0] d,
	       output reg[WIDTH-1:0] q);

  always @(posedge clk or posedge reset) begin
    if (reset) q <= 1'b0;
    else if (enable) q <= d;
  end

endmodule

//FLIP FLOP REGISTER (ENABLE) (NO RESET)
module flope #(parameter WIDTH = 8)
	      (input clk, enable,
	       input [WIDTH-1:0] d,
	       output reg[WIDTH-1:0] q);

  always @(posedge clk) begin
    if (enable) q <= d;
  end

endmodule

//FLIP FLOP REGISTER (2-INPUT)
module flopr2 #(parameter WIDTH = 8)
	      (input clk, reset,
	       input [WIDTH-1:0] d0, d1,
	       output reg[WIDTH-1:0] q0, q1);

  always @(posedge clk, posedge reset) begin
    if (reset) begin
      q0 <= 0;
      q1 <= 0;
    end
    else begin
      q0 <= d0;
      q1 <= d1;
    end
  end

endmodule

//FETCH - DECODE REGISTER
module flopfd #(parameter WIDTH = 8)
	      (input clk, reset, enable,
	       input [WIDTH-1:0] d0, d1,
	       output reg[WIDTH-1:0] q0, q1);

  always @(posedge clk, posedge reset) begin
    if (reset) begin
      q0 <= 0;
      q1 <= 0;
    end
    else if (~enable) begin
      q0 <= d0;
      q1 <= d1;
    end
  end

endmodule

//DECODE - EXECUTE REGISTER
module flopde #(parameter WIDTH = 8)
	      (input clk, reset, memwriteD, regwriteD, alusrcBD, regdstD, start_multD, mult_signD, memtoregD,
	       input [1:0] out_selectD,
	       input [3:0] alu_opD,
	       input [WIDTH-1:0] d0, d1, d2,
	       input [4:0] d3, d4, d5,
	       output reg[WIDTH-1:0] q0, q1, q2,
	       output reg[4:0] q3, q4, q5,
	       output memwriteE, regwriteE, alusrcBE, regdstE, start_multE, mult_signE, memtoregE,
	       output [1:0] out_selectE,
	       output [3:0] alu_opE);

  always @(posedge clk, posedge reset) begin
   
    if (reset) begin
      q0 <= 0;
      q1 <= 0;
      q2 <= 0;
      q3 <= 0;
      q4 <= 0;
      q5 <= 0;
    end
    else begin
      q0 <= d0;
      q1 <= d1;
      q2 <= d2;
      q3 <= d3;
      q4 <= d4;
      q5 <= d5;
    end
  end

  assign memwriteE = memwriteD;
  assign regwriteE = regwriteD;
  assign alusrcBE = alusrcBD;
  assign regdstE = regdstD;
  assign start_multE = start_multD;
  assign mult_signE = mult_signD;
  assign memtoregE = memtoregD;
  assign out_selectE = out_selectD;
  assign alu_opE = alu_opD;

endmodule

//EXECUTE - MEMORY REGISTER
module flopem #(parameter WIDTH = 8)
	      (input clk, memwriteE, regwriteE, memtoregE,
	       input [WIDTH-1:0] d0, d1,
	       input [4:0] d2,
	       output reg[WIDTH-1:0] q0, q1,
	       output reg[4:0] q2,
	       output memwriteM, regwriteM, memtoregM);

  always @(posedge clk) begin
    q0 <= d0;
    q1 <= d1;
    q2 <= d2;
  end

  assign memwriteM = memwriteE;
  assign regwriteM = regwriteE;
  assign memtoregM = memtoregE;

endmodule

//MEMORY - WRITEBACK REGISTER
module flopmw #(parameter WIDTH = 8)
	      (input clk, regwriteM, memtoregM,
	       input [WIDTH-1:0] d0, d1,
	       input [4:0] d2,
	       output reg[WIDTH-1:0] q0, q1,
	       output reg[4:0] q2,
	       output regwriteW, memtoregW);

  always @(posedge clk) begin
    q0 <= d0;
    q1 <= d1;
    q2 <= d2;
  end

  assign regwriteW = regwriteM;
  assign memtoregW = memtoregM;

endmodule

//2:1 MULTIPLEXER
module mux2 #(parameter WIDTH = 8)
	     (input [WIDTH-1:0] d0, d1,
	      input s,
	      output [WIDTH-1:0] y);

  assign y = s ? d1 : d0;

endmodule

//3:1 MUX
module mux3 #(parameter WIDTH = 8)
	     (input [WIDTH-1:0] d0, d1, d2,
	      input [1:0] s,
	      output reg [WIDTH-1:0] y);

  always @(s or d0 or d1 or d2) begin
    if (s == 00) assign y = d0;
    else if (s == 01) assign y = d1;
    else if (s == 10) assign y = d2;
  end

endmodule

//4:1 MUX
module mux4 #(parameter WIDTH = 8)
	     (input [WIDTH-1:0] d0, d1, d2, d3,
	      input [1:0] s,
	      output reg [WIDTH-1:0] y);

  always @(s or d0 or d1 or d2 or d3) begin
    if (s == 00) assign y = d0;
    else if (s == 01) assign y = d1;
    else if (s == 10) assign y = d2;
    else assign y = d3;
  end

endmodule
