module multiplier(input  [31:0] a, b,
		  input Clk, start, Is_signed,
		  output [63:0] s);
	
	//lab says to assume no difference between signed and unsigned instructions
	
	//Multiplier Implementation
	always @(posedge Clk) begin
		if (start) begin
			//lab says to assume no difference between signed and unsigned instructions
			if (Is_signed) begin
				s <= a * b;
			end else begin
				s <= a * b;
			end
		end
	end

endmodule
