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

  maindec md(op, func, memwrite, memread, regwrite, alusrcA, alusrcB, se_ze, regdst, start_mult, mult_sign, memtoreg, out_select, alu_op, output_branch); // Generate Control Signals

  assign branch = ((op == 6'b000100) || (op == 6'b000101)) ? 1:0; // if BEQ or BNE, branch = 1, else branch = 0

  reg [2:0]temp; // Hold Register value

  always @(branch or eq_ne) begin
    if (op == 6'b000010) temp = 2'b10;	    // Jump
    else if (branch && eq_ne) temp = 2'b01; // PCBranch
    else temp = 2'b00;			    // PC + 4
  end

  assign pc_source = temp;

endmodule

module maindec(input  [5:0] op, func,
               output 	    memwrite, memread,
	       output 	    regwrite,
	       output 	    alusrcA, alusrcB,
	       output 	    se_ze, regdst,
               output	    start_mult, mult_sign,
	       output	    memtoreg,
               output [1:0] out_select,
	       output [3:0] alu_op,
	       output output_branch);

  reg [16:0] controls;

  assign {memwrite, memread, regwrite, alusrcA, alusrcB, se_ze, regdst, start_mult, mult_sign, memtoreg, out_select, alu_op, output_branch} = controls;

  always @ * begin
    case (op)
      6'b001000: controls <= 17'b00101000000000100; // ADDI
      6'b001001: controls <= 17'b00101000000000100; // ADDIU
      6'b001100: controls <= 17'b00101100000000000; // ANDI
      6'b001101: controls <= 17'b00101100000000010; // ORI
      6'b001110: controls <= 17'b00101100000001000; // XORI
      6'b001010: controls <= 17'b00101000000010110; // SLTI
      6'b001011: controls <= 17'b00101000000010110; // SLTIU
      6'b100011: controls <= 17'b00101000010000100; // LW
      6'b101011: controls <= 17'b10001000000000100; // SW
      6'b001111: controls <= 17'b00100000000100000; // LUI
      6'b000010: controls <= 17'b00000000000000000; // J
      6'b000101: controls <= 17'b00000000000010101; // BNE
      6'b000100: controls <= 17'b00000000000010101; // BEQ
      6'b000000: case(func)                        // RTYPE
	6'b100000: controls <= 17'b00100010000000100; // ADD
	6'b100001: controls <= 17'b00100010000000100; // ADDU
	6'b100010: controls <= 17'b00100010000010100; // SUB
	6'b100011: controls <= 17'b00100010000010100; // SUBU
	6'b100100: controls <= 17'b00100010000000000; // AND
	6'b100101: controls <= 17'b00100010000000010; // OR
	6'b100110: controls <= 17'b00100010000001000; // XOR
	6'b011111: controls <= 17'b00100010000001010; // XNOR Use available opcode 011111
	6'b101010: controls <= 17'b00100010000010110; // SLT
	6'b101001: controls <= 17'b00100010000010110; // SLTU
	6'b011000: controls <= 17'b00000001100000000; // MULT
	6'b011001: controls <= 17'b00000001000000000; // MULTU
	6'b010000: controls <= 17'b00100010001000000; // MFHI
	6'b010010: controls <= 17'b00100010001100000; // MFLO
      endcase
      default: controls <= 17'bxxxxxxxxxxxxxxxxx;     // illegal op
    endcase
  end

endmodule