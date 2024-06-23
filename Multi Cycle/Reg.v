module Reg (clk, rst, reg_in, reg_out);
    input clk, rst;
    input [31:0] reg_in;
    output reg [31:0] reg_out;

  always @(posedge clk, posedge rst) begin
    if (rst) reg_out <= 0;
    else reg_out <= reg_in;
  end

endmodule

