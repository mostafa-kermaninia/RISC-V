`timescale 1ns/1ns
module ALU (input [31:0]  SrcA, SrcB, input[2:0]control, output reg [31:0] res, output zero);

    assign zero = ~|res;
    assign sign = res[31];

    always @(SrcA,SrcB, control) begin
        case (control)
            3'b000:  res = SrcA & SrcB;
            3'b001:  res = SrcA | SrcB;
            3'b010:  res = SrcA + SrcB;
            3'b110:  res = SrcA - SrcB;
	        3'b011:  res = SrcA ^ SrcB;
            3'b111:  res = SrcA < SrcB ? 'd1 : 'd0; // unsigned
            3'b100:  res = SrcA < SrcB ? 'd1 : 'd0; // signed
            default: res = 32'b00000000000000000000000000000000;
        endcase
    end
endmodule


