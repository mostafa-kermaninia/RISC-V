`timescale 1ns/1ns
module ImmExt(input[2:0] ImmSrc, input[31:7] in  , output reg[31:0] out );
	always@(*)begin
		case(ImmSrc)
			3'b000: out = {{20{in[31]}} , in[31:20]}; // i
			3'b001: out = {{20{in[31]}} , in[31:25] , in[11:7]}; //s
			3'b010: out = {{20{in[31]}} , in[7] , in[30:25] , in[11:8] , 1'b0}; // b
			3'b011: out = {{12{in[31]}} , in[31],in[19:12] , in[20] , in[30:21] , 1'b0}; //j
			3'b100: out = {in[31:12] , {12{1'b0}} }; //u
			3'b101: out = {{20{1'b0}} , in[31:20]}; // sltiu
		endcase
	end
endmodule