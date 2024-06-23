module Reg_En (clk, rst, ld, reg_in, reg_out);
  input clk, rst, ld;
  input [31:0] reg_in;
  output reg [31:0] reg_out;

  always @(posedge clk, posedge rst) begin
    if (rst) reg_out <= 0;
    else if (ld) reg_out <= reg_in;
  end

endmodule

