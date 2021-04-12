module datapath(input         clk, reset,
                input         memread, regwrite,
                input         alusrcA, alusrcB,
                input         se_ze, regdst,
		input	      start_mult, mult_sign,
		input	      memtoreg, output_branch,
		input  [1:0]  out_select,
                input  [3:0]  alu_op,
                output [31:0] pc,
                input  [31:0] instr,
                output [31:0] aluout, writedata,
                input  [31:0] readdata);

  wire [4:0] writereg;
  wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
  wire [31:0] signimm, signimmsh;
  wire [31:0] zeroimm;
  wire [31:0] presrcb;
  wire [31:0] srca, srcb;
  wire [31:0] result;

  // next PC logic
  flopr #(32) pcreg(clk, reset, pcnext, pc);
  adder pcadd1(pc, 32'b100, pcplus4);
  sl2 immsh(signimm, signimmsh);
  adder pcadd2(pcplus4, signimmsh, pcbranch);
  mux2 #(32) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
  mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28],
  instr[25:0], 2'b00}, jump, pcnext);

  // register file logic
  reg_file rf(clk, regwrite, reset, instr[25:21], instr[20:16],
  writereg, result, srca, writedata);
  mux2 #(5) wrmux(instr[20:16], instr[15:11],
  regdst, writereg);
  mux2 #(32) resmux(aluout, readdata, memtoreg, result);
  signext se(instr[15:0], signimm);
  zeroext ze(instr[15:0], zeroimm);

  // ALU logic
  mux2 #(32) srcbmuxmux(signimm, zeroimm, ori, presrcb);
  mux2 #(32) srcbmux(writedata, presrcb, alusrc, srcb);
	ALU alu(srca, srcb, alu_op, aluout);

endmodule
