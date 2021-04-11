module controller(input   [5:0] op, func,
                  input         eq_ne,
                  output        memwrite, memread,
                  output        regwrite,
                  output        alusrcA, alusrcB,
		  output	se_ze, regdst,
                  output        start_mult, mult_sign,
		  output 	memtoreg,
                  output  [1:0] pc_source, out_select,
		  output  [3:0] alu_op,
		  output	output_branch);

  //[TODO:] Insert Zero Wire

  wire branch;

  maindec md(op, memwrite, memread, regwrite, alusrcA, alusrcB, se_ze, regdst, start_mult, mult_sign, memtoreg, out_select, alu_op);

  

  //assign pc_source = (branch & zero) || (bne & !zero);




endmodule

module maindec(input  [5:0] op,
               output 	    memwrite, memread,
	       output 	    regwrite,
	       output 	    alusrcA, alusrcB,
	       output 	    se_ze, regdst,
               output	    start_mult, mult_sign,
	       output	    memtoreg,
               output [1:0] out_select,
	       output [3:0] alu_op);

  reg [15:0] controls;

  assign {memwrite, memread, regwrite, alusrcA, alusrcB, se_ze, regdst, start_mult, mult_sign, memtoreg, out_select, alu_op} = controls;

  always @ * begin
    case (op)
      6'b000000: controls <= 16'b0010001000xxxxxx; // RTYPE
      6'b100011: controls <= 16'b101001000xx0010; // LW
      6'b101011: controls <= 16'b001010000xx0010; // SW
      6'b000100: controls <= 16'b000100000xx1010; // BEQ
      6'b001000: controls <= 16'b101000000xx0010; // ADDI
      6'b000010: controls <= 16'b000000100xx0010; // J
      6'b001101: controls <= 16'b101000001xx0001; // ORI
      6'b000101: controls <= 16'b000100010xx1010; // BNE
      default: controls <= 16'bxxxxxxxxxxxxxxxx; // illegal op
    endcase
  end

endmodule