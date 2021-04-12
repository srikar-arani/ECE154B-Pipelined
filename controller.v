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

  wire branch;

  maindec md(op, func, memwrite, memread, regwrite, alusrcA, alusrcB, se_ze, regdst, start_mult, mult_sign, memtoreg, out_select, alu_op); // Generate Control Signals

  assign branch = ((op == 6'b000100) || (op == 6'b000101)) ? 1:0; // if BEQ or BNE, branch = 1, else branch = 0

  reg [2:0]temp; // Hold Register value

  always @(branch or eq_ne) begin
    if (op == 6'b000010) temp = 2'b10;	    // Jump
    else if (branch && eq_ne) temp = 2'b01; // PCBranch
    else temp = 2'b00;			    // PC + 4
  end

  assign pc_source = temp;

  // [TODO:] Maybe add output_branch signal

endmodule

module maindec(input  [5:0] op, func,
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

  // [TODO:] Maybe add output_branch signal

  always @ * begin
    case (op)
      6'b001000: controls <= 16'b0010100000000010; // ADDI
      6'b001001: controls <= 16'b0010100000000010; // ADDIU
      6'b001100: controls <= 16'b0010110000000000; // ANDI
      6'b001101: controls <= 16'b0010110000000001; // ORI
      6'b001110: controls <= 16'b0010110000000100; // XORI
      6'b001010: controls <= 16'b0010100000001011; // SLTI
      6'b001011: controls <= 16'b0010100000001011; // SLTIU
      6'b100011: controls <= 16'b0010100001000010; // LW
      6'b101011: controls <= 16'b1000100000000010; // SW
      6'b001111: controls <= 16'b0010000000010000; // LUI
      6'b000010: controls <= 16'b0000000000000000; // J
      6'b000101: controls <= 16'b0000000000001010; // BNE
      6'b000100: controls <= 16'b0000000000001010; // BEQ
      6'b000000: case(func)                        // RTYPE
	6'b100000: controls <= 16'b0010001000000010; // ADD
	6'b100001: controls <= 16'b0010001000000010; // ADDU
	6'b100010: controls <= 16'b0010001000001010; // SUB
	6'b100011: controls <= 16'b0010001000001010; // SUBU
	6'b100100: controls <= 16'b0010001000000000; // AND
	6'b100101: controls <= 16'b0010001000000001; // OR
	6'b100110: controls <= 16'b0010001000000100; // XOR
	6'b011111: controls <= 16'b0010001000000101; // XNOR Use available opcode 011111
	6'b101010: controls <= 16'b0010001000001011; // SLT
	6'b101001: controls <= 16'b0010001000001011; // SLTU
	6'b011000: controls <= 16'b0000000110000000; // MULT
	6'b011001: controls <= 16'b0000000100000000; // MULTU
	6'b010000: controls <= 16'b0010001000100000; // MFHI
	6'b010010: controls <= 16'b0010001000110000; // MFLO
      endcase
      default: controls <= 16'bxxxxxxxxxxxxxxxx;     // illegal op
    endcase
  end

endmodule