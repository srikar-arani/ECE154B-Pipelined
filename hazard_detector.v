module hazard_detector(input  [4:0] RsD, RtD, RsE, RtE,
		       input  [4:0] writeregE, writeregM, writeregW,
		       input        memtoregE, memtoregM,
		       input        regwriteE, regwriteM, regwriteW,
		       input        start_mult,
		       input  [1:0] pc_source,
		       output	    stallF, stallD,
		       output	    forwardAD, forwardBD,
		       output	    flushE,
		       output [1:0] forwardAE, forwardBE);

  reg [1:0] fae, fbe;
  wire lwstall, branchstall;
  wire branchD, jumpD;

  assign branchD = pc_source[0];
  assign jumpD = pc_source[1];

  always @(*) begin
    if ((RsE != 0) && (RsE == writeregM) && regwriteM) fae <= 2'b10;
    else if ((RsE != 0) && (RsE == writeregW) && regwriteW) fae <= 2'b01;
    else fae <= 2'b00;
  end

  always @(*) begin
    if ((RtE != 0) && (RtE == writeregM) && regwriteM) fbe <= 2'b10;
    else if ((RtE != 0) && (RtE == writeregW) && regwriteW) fbe <= 2'b01;
    else fbe <= 2'b00;
  end

  assign forwardAE = fae;
  assign forwardBE = fbe;

  assign lwstall = ((RsD == RtE) || (RtD == RtE)) && memtoregE;
  assign branchstall = (branchD && regwriteE && ((writeregE == RsD) || (writeregE == RtD))) || (branchD && memtoregM && ((writeregM == RsD) || (writeregM == RtD)));
  assign FlushE = (lwstall | branchstall | start_mult | jumpD);
  assign stallD = FlushE;
  assign stallF = stallD;

  assign forwardAD = (RsD != 0) && (RsD == writeregM) && regwriteM;
  assign forwardBD = (RtD != 0) && (RtD == writeregM) && regwriteM;

endmodule
