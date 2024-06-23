module datapath(clk, rst, Branch, PCupdate, AdrSrc, MemWrite, IRwrite, regWrite,
		ImmSrc, AluSrcA, AluSrcB, AluOp, ResultSrc, Opcode, func7, func3);
	
	input clk, rst;
	input Branch, PCupdate, AdrSrc, MemWrite, IRwrite, regWrite;
	input [1:0] AluSrcA, AluSrcB, AluOp, ResultSrc;
	output [6:0] Opcode, func7;
	output [2:0] func3, ImmSrc;

	wire PCwrite, BrValid, zero, neg;
	wire [1:0] Br_Sel;
	wire [2:0] Alufunc;
	wire [31:0] Result, PC, Adr, ReadData, A, B, OldPC, Instruction, MDRout;
	wire [31:0] RD1, RD2, ExtData, OPR_A, OPR_B, AluRes, OldAluRes;
	wire [4:0] A1, A2, A3;

	assign PCwrite = (Branch & BrValid) | PCupdate;
	assign Opcode = Instruction[6:0];
	assign func7 = Instruction[31:25];
	assign func3 = Instruction[14:12];
	assign A1 = Instruction[19:15];
	assign A2 = Instruction[24:20];
	assign A3 = Instruction[11:7];	

	Reg_En PC_Reg(clk, rst, PCwrite, Result, PC);
	Branch_cntr BranchControl(func3, Br_Sel);
	MUX4_1 Branch_Mux(Br_Sel, zero, ~zero, neg, ~neg, BrValid);
	
	MUX2 Adr_Mux(AdrSrc, PC, Result, Adr);
	InstDatamem IDM(Adr, B, MemWrite , clk , ReadData);
	
	Reg_En OldPC_Reg(clk, rst, IRwrite, PC, OldPC);
	Reg_En IR(clk, rst, IRwrite, ReadData, Instruction);
	Reg MDR(clk, rst, ReadData, MDRout);

	Regfile RF(regWrite , clk , A1 , A2, A3, Result, RD1 , RD2);
	ImmExt_unit IE_unit(Instruction, ImmSrc, ExtData);

	Reg AReg(clk, rst, RD1, A);	
	Reg BReg(clk, rst, RD2, B);

	MUX3 OPR_A_mux(AluSrcA, PC, OldPC, A, OPR_A);
	MUX3 OPR_B_mux(AluSrcB, B, ExtData, 32'd4, OPR_B);

	Alu ALU(OPR_A, OPR_B, Alufunc, neg, zero, AluRes);
	AluControl ALUC(AluOp, func3, func7, Alufunc);

	Reg Aluout(clk, rst, AluRes, OldAluRes);
	MUX4 Result_Mux(ResultSrc, OldAluRes, MDRout, AluRes, ExtData, Result);

endmodule





