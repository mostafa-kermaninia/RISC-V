

module Decoder(input JalrE,JumpE,BranchE,ZeroE,neg,input[2:0] func3,output[1:0] PCSrc);
	assign PCSrc=(JalrE) ? 2'b10:
		((JumpE)||
		(BranchE && func3==3'b000 && ZeroE)|| // beq
		(BranchE && func3==3'b001 && ~ZeroE)|| // bne
		(BranchE && func3==3'b100 && neg)|| //blt
		(BranchE && func3==3'b101 && ~neg))?2'b01: //bge
		2'b00;
endmodule

