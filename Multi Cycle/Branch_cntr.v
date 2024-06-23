`define beq 3'd0
`define bne 3'd1
`define blt 3'd4
`define bge 3'd5

module Branch_cntr(func3, sel);
	input [2:0] func3;
	output reg [1:0] sel;

	always@(func3)begin
		sel = 2'b0;
		case(func3)
		`beq: sel = 2'b00;
		`bne: sel = 2'b01;
		`blt: sel = 2'b10;
		`bge: sel = 2'b11;
		default: sel = 2'b00;
		endcase
	end
endmodule