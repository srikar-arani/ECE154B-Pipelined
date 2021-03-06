module datapath(input         clk, reset,
                input         memreadD, regwriteD,
                input         alusrcAD, alusrcBD,
                input         se_zeD, regdstD,
		input	      start_multD, mult_signD,
		input	      memtoregD, output_branchD,
		input  [1:0]  out_selectD,
                input  [3:0]  alu_opD,
                output [31:0] pcF,
                input  [31:0] instr,
                output [31:0] aluoutM, writedataM,
                input  [31:0] readdata,
		output eq_ne);

  wire [4:0] writeregE, writeregM, RsE, RtE, RdE, writeregW;
  wire [31:0] pcnext, pcnextbr, pcplus4F, pcplus4D, pcbranchD, instrD, pc_sourceD;
  wire [31:0] signimmD, signimmshD, signimmE;
  wire [31:0] zeroimmD, se_zeoutD, se_zeoutE, se_zeshE;
  wire [31:0] rd1, rd2, rd1E, rd2E, srcaE, writedataE, srcbE, multhi, multlo, multhighE, multlowE;
  wire [31:0] resultW, aluoutE, out_selectresultE, aluoutW, readdataW;
  wire memwriteE, regwriteE, alusrcBE, regdstE, start_multE, mult_signE, memtoregE;
  wire [1:0] out_selectE;
  wire [3:0] alu_opE;
  wire [63:0] multE;
  wire [31:0] equalAD, equalBD;


 hazard_detector hazards(RsD, RtD, RsE, RtE,
                          writeregE, writeregM, writeregW,
                          memtoregE, memtoregM,
                          RegWriteE, RegWriteM, RegWriteW,
                          start_mult,
                          PC_source,
                          clk,
                          // counter,
                          stallF, stallD,
                          forwardAD, forwardBD,
                          flushE,
                          forwardAE, forwardBE,
                          start
                          // counter_icr
                          );


  // branch forwarding
  mux2 #(32) branchA(rd1E, aluoutM, forwardAD,equalAD);
  mux2 #(32) branchB(rd2E, aluoutM, forwardBD,equalBD);
  assign eq_ne = (equalAD == equalBD) ? 1 : 0;


  // next PC logic
  flope #(32) pcreg(clk, ~stallF, pcnext, pcF);
  adder pcadd1(pcF, 32'b100, pcplus4F);
  sl2 immsh(signimmD, signimmshD);
  // double check if the pcplus4 on line below is D or F
  adder pcadd2(pcplus4F, signimmshD, pcbranchD);
  mux2 #(32) pcbrmux(pcplus4F, pcbranchD, pc_sourceD, pcnext);
  flopfd #(32) fetch_decode(clk, pc_sourceD, ~stallD, instr, pcplus4F, instrD, pcplus4D);

  // register file logic
  reg_file rf(clk, regwriteW, reset, instrD[25:21], instr[20:16], writeregW, resultW, rd1, rd2);
  signext se(instr[15:0], signimmD);
  zeroext ze(instr[15:0], zeroimmD);
  mux2 #(32) se_zemux(signimmD, zeroimmD, se_zeD, se_zeoutD);
  flopde #(32) decode_execute(clk, flushE, memwriteD, regwriteD, alusrcBD, regdstD, start_multD, mult_signD, memtoregD,
	       out_selectD,
	       alu_opD,
	       rd1, rd2, se_zeoutD,
	       instr[25:21], instr[20:16], instr[15:11],
	       rd1E, rd2E, se_zeoutE,
	       RsE, RtE, RdE,
	       memwriteE, regwriteE, alusrcBE, regdstE, start_multE, mult_signE, memtoregE,
	       out_selectE,
	       alu_opE);

  mux2 #(32) dstmux(RtE, RdE, regdstE, writeregE);
  
  // ALU logic
  mux3 #(32) forwardmuxA(rd1E, resultW, aluoutM,forwardAE,srcaE);
  mux3 #(32) forwardmuxB(rd2E, resultW, aluoutM,forwardBE,writedataE);
  mux2 #(32) srcbmux(writedataE, se_zeoutE, alusrcBE, srcbE);
  //double check that the alu_opE is actually E and not D
  ALU alu(srcaE, srcbE, alu_opE, aluoutE);

  multiplier multi(rd1E, rd2E, clk, start_multE, mult_signE, multE);
  assign multhi = multE[63:32];
  assign multlo = multE[31:0];
  flopr #(32) multhigh (clk, 1'b0, multhi,multhighE);
  flopr #(32) multlow (clk, 1'b0, multlo,multlowE);
  //double check that the outselectE used below is actually E and not D
  mux4 #(32) out_selectmux(aluoutE, se_zeshE, multhighE, multlowE, out_selectE, out_selectresultE);
  //Execute to Memory
  flopem #(32) execute_memory(clk, memwriteE, regwriteE, memtoregE,
	       out_selectresultE, writedataE,
	       writeregE,
	       aluoutM, writedataM,
	       writeregM,
	       memwriteM, regwriteM, memtoregM);
  //Memory to Writeback
  flopmw #(32) memory_writeback(clk, regwriteM, memtoregM,
	       readdata, aluoutM,
	       writeregM,
	       readdataW, aluoutW,
	       writeregW,
	       regwriteW, memtoregW);
  mux2 #(32) memtoregmux(aluoutW, readdataW, memtoregW, resultW);

endmodule
