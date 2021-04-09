module ALU (input [31:0] In1, In2,
	    input [3:0] Func,
	    output reg [31:0] ALUout);

  wire [31:0] B;
  wire [31:0] S;
  wire cout;
  
  assign B = (Func[3]) ? ~In2 : In2;
  assign {cout, S} = Func[3] + In1 + B;
  always @ * begin
   case (Func[2:0]) 
    3'b000 : ALUout <= In1 & B; 	// Bitwise AND
    3'b001 : ALUout <= In1 | B; 	// Bitwise OR
    3'b010 : ALUout <= S; 		// ADD
    3'b011 : ALUout <= {31'd0, S[31]};  // SLT
    3'b100 : ALUout <= In1 ^ B; 	// XOR
    3'b101 : ALUout <= In1 ~^ B; 	// XNOR
   endcase
  end
   
 endmodule
