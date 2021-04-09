module controller(input   [5:0] op, func,
                  input         eq_ne,
                  output        memtoreg, memwrite,
                  output        memread, regwrite,
                  output        alusrcA, alusrcB,
		  output	se_ze, reg_dst,
                  output        start_mult, mult_sign,
                  output  [1:0] pc_source, out_select,
		  output  [3:0] alu_op,
		  output	output_branch);

//[TODO:] Insert Zero Wire
wire[1:0] aluop;

/********************************************************
This from Lab 4, it all needs to change
*********************************************************/
wire branch, bne;

//maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, bne, ori, aluop);
//aludec ad(func, aluop, alucontrol);

//assign pc_source = (branch & zero) || (bne & !zero);




endmodule
