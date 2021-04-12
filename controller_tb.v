module controller_tb;
  
  reg [5:0] op, func;
  reg eq_ne;
  wire memwrite, memread;
  wire regwrite;
  wire alusrcA, alusrcB;
  wire se_ze, regdst;
  wire start_mult, mult_sign;
  wire memtoreg;
  wire [1:0] pc_source, out_select;
  wire [3:0] alu_op;
  wire output_branch;

  controller controller_test (
    .op(op),
    .func(func),
    .eq_ne(eq_ne),
    .memwrite(memwrite),
    .memread(memread),
    .regwrite(regwrite),
    .alusrcA(alusrcA),
    .alusrcB(alusrcB),
    .se_ze(se_ze),
    .regdst(regdst),
    .start_mult(start_mult),
    .mult_sign(mult_sign),
    .memtoreg(memtoreg),
    .pc_source(pc_source),
    .out_select(out_select),
    .alu_op(alu_op),
    .output_branch(output_branch)
  );

  initial
    begin
      assign op = 6'b000000;
      assign func = 6'h20;
      assign eq_ne = 0;
      #20;
      assign func = 6'h21;
      #20;
      assign func = 6'h22;
      #20;
      assign func = 6'h23;
      #20;
      assign func = 6'h24;
      #20;
      assign func = 6'h25;
      #20;
      assign func = 6'h26;
      #20;
      assign func = 6'h1f;
      #20;
      assign func = 6'h2a;
      #20;
      assign func = 6'h2b;
      #20;
      assign func = 6'h18;
      #20;
      assign func = 6'h19;
      #20;
      assign func = 6'h10;
      #20;
      assign func = 6'h12;
      #20;
      assign op = 6'h8;
      #20;
      assign op = 6'h9;
      #20;
      assign op = 6'hc;
      #20;
      assign op = 6'hd;
      #20;
      assign op = 6'he;
      #20;
      assign op = 6'ha;
      #20;
      assign op = 6'hb;
      #20;
      assign op = 6'h23;
      #20;
      assign op = 6'h2b;
      #20;
      assign op = 6'hf;
      #20;
      assign op = 6'h2;
      #20;
      assign op = 6'h5;
      #20;
      assign op = 6'h4;
      #20;
    end

endmodule
