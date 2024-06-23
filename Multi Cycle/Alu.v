`define add 3'b000
`define sub 3'b001
`define And 3'b010
`define Or 3'b011
`define Xor 3'b100
`define slt 3'b101
`define sltu 3'b110

module Alu(A, B, opc, neg, zero, result);
	input [31:0] A, B;
	input [2:0] opc;
	output neg, zero;
	output reg [31:0] result;

	always@(A, B, opc)begin
		result = 32'd0;
		case(opc)
		`add: result = A + B;
		`sub: result = A - B;
		`And: result = A & B;
		`Or: result = A | B;	
		`Xor: result = A ^ B;
		`slt: result = (A[31] > B[31]) ? 1 :
				(A[31] < B[31]) ? 0 :
				(A[31] == 1) ? ((A > B) ? 1 : 0) :
				(A[31] == 0) ? ((A < B) ? 1 : 0) : 0 ;
		`sltu: result = (A < B) ? 1 : 0;
		default: result = 32'd0;
		endcase
	end

	assign zero = (result == 0) ? 1 : 0;
	assign neg = result[31];
endmodule








