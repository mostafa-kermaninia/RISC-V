module MUX3 (sel, in1, in2, in3, out);
    input [1:0] sel;
    input [31:0] in1, in2, in3;
    output reg [31:0] out;


  always @(sel, in1, in2, in3) begin
    out = 0;
    case (sel)
      2'b00: out = in1;
      2'b01: out = in2;
      2'b10: out = in3;
    endcase
  end
endmodule
