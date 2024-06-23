module MultiCycle(clk, rst);
	input clk, rst;
	

	wire Branch, PCupdate, AdrSrc, MemWrite, IRwrite, RegWrite;
	wire [2:0] ImmSrc, func3;
	wire [1:0] AluSrcA, AluSrcB, AluOp, ResultSrc;
	wire [6:0] func7, Opcode;

	datapath dp(clk, rst, Branch, PCupdate, AdrSrc, MemWrite, IRwrite, RegWrite,
		ImmSrc, AluSrcA, AluSrcB, AluOp, ResultSrc, Opcode, func7, func3);
	
	Controller C(clk, rst, Opcode ,  func3 , func7 , AdrSrc, PCupdate,
	 ResultSrc, MemWrite , AluOp , AluSrcA, AluSrcB , ImmSrc , RegWrite, Branch, IRwrite);

endmodule