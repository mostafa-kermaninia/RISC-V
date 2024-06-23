module DataMem(input clk , we,input[31:0] A,WD,output reg[31:0] ReadData);
	reg [7:0] mem [0:$pow(2, 16)-1];
	initial $readmemh("data.mem", mem);
	wire [31:0] adr;
	assign adr = {A[31:2], 2'b00};
	always @(A or adr) begin
           ReadData = {mem[adr + 3], mem[adr + 2], mem[adr + 1], mem[adr]};
    	end

	always@(posedge clk)begin 
		if(we)
			{mem[adr + 3], mem[adr + 2], mem[adr + 1], mem[adr]} <= WD;
		else
			mem[adr]<=mem[adr];
	end
endmodule



