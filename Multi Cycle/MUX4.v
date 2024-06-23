module MUX4 (sel, in1, in2, in3, in4, out);
    input [1:0] sel;
    input [31:0] in1, in2, in3, in4;
    output reg [31:0] out;
  always @(sel, in1, in2, in3, in4) begin
    out = 0;
    case (sel)
      0: out = in1;
      1: out = in2;
      2: out = in3;
      3: out = in4;
    endcase
  end
endmodule
