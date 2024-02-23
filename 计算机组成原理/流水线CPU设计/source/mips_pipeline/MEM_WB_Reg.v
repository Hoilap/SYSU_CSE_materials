module MEM_WB_Reg(clk, reset, 
   ALUOut_in, MemReadData_in, Rd_in, RegDst_in, MemToReg_in, RegWrite_in,RegWriteAddr_in,
   ALUOut_out, MemReadData_out, Rd_out, RegDst_out, MemToReg_out, RegWrite_out, RegWriteAddr_out);

input clk,reset,RegWrite_in;
input [31:0] ALUOut_in,MemReadData_in;
input [4:0] Rd_in,RegWriteAddr_in;
input [1:0] RegDst_in,MemToReg_in;
output reg [31:0] ALUOut_out,MemReadData_out;
output reg [4:0]  Rd_out,RegWriteAddr_out;
output reg [1:0] RegDst_out,MemToReg_out;
output reg RegWrite_out;
always @(posedge clk or negedge reset) begin
	if (reset) begin
        ALUOut_out <= 32'h0000_0000;
        MemReadData_out <= 32'h0000_0000;
        Rd_out <= 5'h00;
        RegDst_out <= 2'h0;	MemToReg_out <= 2'h0;
        RegWrite_out <= 1'h0;	
        RegWriteAddr_out<= 4'h0000_0000;
	end
	
else begin
    ALUOut_out <= ALUOut_in;
    MemReadData_out <= MemReadData_in;
    Rd_out <= Rd_in;
    RegDst_out <= RegDst_in;
    MemToReg_out <= MemToReg_in;
    RegWrite_out <= RegWrite_in;
    RegWriteAddr_out<= RegWriteAddr_in;
        end
    end
    endmodule
