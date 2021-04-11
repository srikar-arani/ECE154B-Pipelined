module multiplier(input  [31:0] a, b,
		  input Clk, start, Is_signed,
		  output reg [63:0] s);

    //value to hold result of multiplication
    wire [63:0] M;

    assign M = a * b;
	
    //multiplier Implementation
    always @ (posedge Clk) begin
        case(Is_signed)
            //lab says to assume no difference between signed and unsigned instructions
            1'b0 : s <= M;
            1'b1 : s <= M;
        endcase
    end

endmodule
