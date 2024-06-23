module InstDatamem(A, WD, WE , clk , RD);
	input [31:0] A, WD;
	input WE , clk;
	output reg[31:0] RD;

    reg [7:0] InstData_Mem [0:$pow(2, 16)-1];

    reg [31:0] adr;
    
    assign adr = {A[31:2], 2'b00}; 

    initial $readmemh("InstData.mem", InstData_Mem);

    always @(posedge clk) begin
        if (WE)
            {InstData_Mem[adr + 3], InstData_Mem[adr + 2], InstData_Mem[adr + 1], InstData_Mem[adr]} <= WD;
    end

    always @(A or adr) begin
           RD = {InstData_Mem[adr + 3], InstData_Mem[adr + 2], InstData_Mem[adr + 1], InstData_Mem[adr]};
    end
endmodule
