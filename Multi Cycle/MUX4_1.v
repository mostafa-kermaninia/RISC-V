module MUX4_1 (sel, in1, in2, in3, in4, out);
    input [1:0] sel;
    input in1, in2, in3, in4;
    output reg out;
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
