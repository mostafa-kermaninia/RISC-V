`define IF 4'd0
`define ID 4'd1
`define EX1 4'd2
`define EX2 4'd3
`define EX3 4'd4
`define EX4 4'd5
`define EX5 4'd6
`define EX6 4'd7
`define EX7 4'd8
`define EX8 4'd9
`define Mem1 4'd10
`define Mem2 4'd11
`define Mem3 4'd12
`define Mem4 4'd13
`define WB 4'd14

`define R_T 7'd51
`define I_T 7'd19
`define lw 7'd3
`define S_T 7'd35
`define J_T 7'd111
`define Jalr 7'd108
`define B_T 7'd99
`define U_T 7'd55

module Controller(clk, rst, opcode ,  func3 , func7 , AdrSrc, PCupdate,
	 ResultSrc, MemWrite , AluOp , AluSrcA, AluSrcB , ImmSrc , RegWrite, Branch, IRwrite);

	input clk, rst;
	input[6:0] opcode; 
	input[2:0] func3;
	input[6:0] func7;
	output reg AdrSrc, PCupdate, MemWrite;
	output reg [1:0] AluOp, ResultSrc;
	output reg [1:0] AluSrcA, AluSrcB;
	output reg[2:0] ImmSrc;
	output reg RegWrite, Branch, IRwrite;

	reg [3:0] ps, ns;
		

	always @(posedge clk, posedge rst)
		if (rst)
			ps <= `IF;
		else
			ps <= ns;
	
	always @(ps, opcode ,  func3 , func7)begin
		ns = `IF;
		case(ps)
		`IF: ns = `ID;
		`ID: ns = (opcode == `R_T) ? `EX4 :
			(opcode == `I_T) ? `EX3 :
			(opcode == `lw) ? `EX7 :
			(opcode == `S_T) ? `EX2 :
			(opcode == `J_T) ? `EX5 :
			(opcode == `Jalr) ? `EX6 :
			(opcode == `B_T) ? `EX1 :
			(opcode == `U_T) ? `Mem3 : `ID;
		`EX1: ns = `IF;
		`EX2: ns = `Mem1;
		`EX3: ns = `Mem4;
		`EX4: ns = `Mem4;
		`EX5: ns = `EX8;
		`EX6: ns = `EX8;
		`EX7: ns = `Mem2;
		`EX8: ns = `Mem4;
		`Mem1: ns = `IF;
		`Mem2: ns = `WB;
		`Mem3: ns = `IF;
		`Mem4: ns = `IF;
		`WB: ns = `IF;
		default: ns = `IF;
		endcase
	end


	always@(ps)begin
		{AdrSrc, PCupdate, ResultSrc, MemWrite} = 3'b000;
		AluOp = 2'b00;
		{AluSrcA, AluSrcB} = 2'b00;
		ImmSrc = 3'b000;
		{RegWrite, Branch, IRwrite} = 3'b000;
		case(ps)
		`IF: begin
			AdrSrc = 0;
			IRwrite = 1;
			AluSrcA = 00;
			AluSrcB = 10;
			AluOp = 00;
			ResultSrc = 10;
			PCupdate = 1;
		end
		`ID: begin
			AluSrcA = 01;
			AluSrcB = 01;
			AluOp = 00;
			ImmSrc = 010;
		end
		`EX1: begin
			AluSrcA = 10;
			AluSrcB = 00;
			AluOp = 01;
			ResultSrc = 0;
			Branch = 1;
		end
		`EX2: begin
			ImmSrc = 001;
			AluSrcA = 10;
			AluSrcB = 01;
			AluOp = 00;
		end
		`EX3: begin
			AluSrcA = 10;
			AluSrcB = 01;
			AluOp = 10;
			ImmSrc = 00;
		end
		`EX4: begin
			AluSrcA = 10;
			AluSrcB = 00;
			AluOp = 10;
		end
		`EX5: begin
			AluSrcA = 01;
			AluSrcB = 01;
			AluOp = 00;
			ImmSrc = 011;
		end
		`EX6: begin
			AluSrcA = 10;
			AluSrcB = 01;
			AluOp = 00;
			ImmSrc = 000;
		end
		`EX7: begin
			ImmSrc = 000;
			AluSrcA = 10;
			AluSrcB = 01;
			AluOp = 01;
		end
		`EX8: begin
			AluSrcA = 01;
			AluSrcB = 10;
			AluOp = 00;
			ResultSrc = 00;
			PCupdate = 1;
		end
		`Mem1: begin
			ResultSrc = 00;
			AdrSrc = 1;
			MemWrite = 1;
		end
		`Mem2: begin
			ResultSrc = 00;
			AdrSrc = 1;
		end
		`Mem3: begin
			ImmSrc = 100;
			ResultSrc = 11;
			RegWrite = 1;
		end
		`Mem4: begin
			ResultSrc = 00;
			RegWrite = 1;
		end
		`WB: begin
			ResultSrc = 01;
			RegWrite = 1;
		end
		default: begin
			{AdrSrc, ResultSrc, MemWrite} = 3'b000;
			AluOp = 2'b00;
			{AluSrcA, AluSrcB} = 2'b00;
			ImmSrc = 3'b000;
			{RegWrite, Branch, IRwrite} = 3'b000;
		end
		endcase	
	end

endmodule


















	
	


		