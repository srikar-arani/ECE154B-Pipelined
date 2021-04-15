module multiplier(input [31:0] a, b,
           input clk,
           input start, is_signed,
           output  [63:0] s);

  wire [31:0] AA;
  assign AA = (a[31]) ? (~a+a[31]) : a ;
  wire [31:0] BB;
  assign BB = (b[31]) ? (~b+b[31]) : b;

  reg [63:0] product;

  always @(posedge clk) begin
    if(start) begin
      if(is_signed) begin
        if ((a[31]&~b[31]) || (~a[31]&b[31])) begin
          product <= -1*(AA*BB);
        end else begin
          product <= AA*BB;
        end
      end else begin
        product <= a*b;
      end

    end
  end

  assign s = product;

endmodule
