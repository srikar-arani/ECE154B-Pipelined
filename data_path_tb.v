
//[TODO:] This is the final testbench not sure what to do here. Again ports are wonky


module data_path_tb();

	reg clk_sim, reset_sim;
	reg memreadD_sim, regwriteD_sim, memwriteD_sim;
	reg alusrcAD_sim, alusrcBD_sim;
	reg se_zeD_sim, regdstD_sim;
	reg start_multD_sim, mult_signD_sim;
	reg memtoregD_sim, output_branchD_sim;
	reg [1:0] out_selectD_sim;
	reg [3:0] alu_opD_sim;
	reg [1:0] pc_sourceD_sim;
	wire [31:0] pcF_sim;
	reg [31:0] instr_sim;
	wire [31:0] aluoutM_sim, writedataM_sim;
	reg [31:0] readdata_sim;
	wire eq_ne_sim;

	data_path test(
		.clk(clk_sim),
		.reset(reset_sim),
		.memreadD(memreadD_sim),
		.regwriteD(regwriteD_sim),
		.memwriteD(memwriteD_sim),
		.alusrcAD(alusrcAD_sim),
		.alusrcBD(alusrcBD_sim),
		.se_zeD(se_zeD_sim),
		.regdstD(regdstD_sim),
		.start_multD(start_multD_sim),
		.mult_signD(mult_signD_sim),
		.memtoregD(memtoregD_sim),
		.output_branchD(output_branchD_sim),
		.out_selectD(out_selectD_sim),
		.alu_opD(alu_opD_sim),
		.pc_sourceD(pc_sourceD_sim),
		.pcF(pcF_sim),
		.instr(instr_sim),
		.aluoutM(aluoutM_sim),
		.writedataM(writedataM_sim),
		.readdata(readdata_sim),
		.eq_ne(eq_ne_sim)
	);
	
	
	initial begin
		$display("it's a wrap");
	end
	
endmodule
