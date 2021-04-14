module alu_tb;
  reg [31:0] In1,In2;
  reg [3:0] Func;
  wire [31:0] ALUout;

  ALU alu_test (
    .In1(In1),
    .In2(In2),
    .Func(Func),
    .ALUout(ALUout)
  );

  integer i;

  initial
    begin
      assign In1 = 0;
      assign In2 = 0;
      assign Func = 0;
      #20 assign In1 = 32'h02;
      assign In2 = 32'h03;
      #20;

      for (i = 0; i < 15; i = i + 1)
	begin
	  assign Func = Func + 8'h01;
	  #20;
	end
    end


endmodule
