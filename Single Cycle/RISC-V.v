module RISC_V(clk ,rst);
    input clk,rst;

    wire RegWrite, MemWrite, ALUSrc2;
    wire[1:0] ResultSrc, PCSrc;
    wire[2:0] ALUControl, ImmSrc;
    wire [6:0] opcode;
    wire lt, bge, zero;
    wire[2:0] func3;
    wire[6:0] func7;

    Datapath dp(clk, rst, RegWrite, MemWrite, ResultSrc, PCSrc, ALUSrc2, ALUControl,ImmSrc, lt ,bge, zero, opcode, func3, func7);
    controller cntr(opcode, func3, func7, zero, bge, lt, PCSrc, ResultSrc, MemWrite, ALUControl, ALUSrc2, ImmSrc, RegWrite);
    


endmodule
