`define add 2'b00
`define sub 2'b01
`define ch_f 2'b10

module AluControl(AluOp, func3, func7, AluC);
	
	input [1:0] AluOp;
	input [2:0] func3;
	input [6:0] func7;
	output reg [2:0] AluC;
	
	wire [9:0] mode;
	assign mode = {func7, func3};
	always@(AluOp, func3, func7)begin
		AluC = 3'b000;
		case(AluOp)
		`add: AluC = 3'b000;
		`sub: AluC = 3'b001;
		`ch_f: AluC = (mode == 0) ? 3'b000 :
				(mode == 256) ? 3'b001 :
				(mode == 7) ? 3'b010 :
				(mode == 6) ? 3'b011 :
				(mode == 2) ? 3'b101 :
				(mode == 3) ? 3'b110 :
				(func3 == 0) ? 3'b000 :
				(func3 == 4) ? 3'b100 :
				(func3 == 6) ? 3'b011 :
				(func3 == 2) ? 3'b101 :
				(func3 == 3) ? 3'b110 : 3'b000;
		endcase
	end
endmodule












