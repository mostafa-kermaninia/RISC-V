module MUX2 (sel, in1, in2, out);
    input sel;
    input [31:0] in1, in2;
    output reg [31:0] out;

  always @(sel, in1, in2) begin
    out = 0;
    case (sel)
      1'b0: out = in1;
      1'b1: out = in2;
    endcase
  end
endmodule
