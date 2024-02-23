module EX_MEM_Reg(
	clk ,reset, stall,
	PC_add_4_in, Branch_addr_in,alu_zero_in,
	ALUOut_in, DataBusB_in, Rd_in, 
	 MemRead_in, MemWrite_in, MemToReg_in, RegWrite_in, RegWriteAddr_in,Branch_in, 
	PC_add_4_out, Branch_addr_out,alu_zero_out,
	ALUOut_out, DataBusB_out, Rd_out, 
	MemRead_out, MemWrite_out, MemToReg_out, RegWrite_out,RegWriteAddr_out,Branch_out);
	
input clk,reset,stall;
input [31:0] PC_add_4_in,DataBusB_in,ALUOut_in, Branch_addr_in;
input [4:0] Rd_in,RegWriteAddr_in;
input [1:0] MemToReg_in;
input MemRead_in,MemWrite_in,RegWrite_in,alu_zero_in,Branch_in;
output reg [31:0] PC_add_4_out,DataBusB_out,ALUOut_out,Branch_addr_out=32'b0;
output reg [4:0] Rd_out,RegWriteAddr_out=5'b0;
output reg [1:0] MemToReg_out=2'b0;
output reg MemRead_out,MemWrite_out,RegWrite_out,alu_zero_out,Branch_out=1'b0;
always @(posedge clk or negedge reset) begin////改了下降沿//又改回了上升沿
	if (reset) begin
		PC_add_4_out <= 32'h0000_0000;
		DataBusB_out <= 32'h0000_0000;
		ALUOut_out <= 32'h0000_0000;
        Rd_out <= 5'h00;
        MemRead_out <= 1'b0;
        MemWrite_out <= 1'b0;	MemToReg_out <= 2'h0;
        RegWrite_out <= 1'b0;
        Branch_addr_out<=32'b0;  alu_zero_out<=1'b0;
        Branch_out<= 1'b0;
        RegWriteAddr_out<=5'b0;
	end 
//	else if(stall==1)
//               begin
//                   PC_add_4_out <= PC_add_4_in;
//                   DataBusB_out <= 0;
//                   ALUOut_out <= ALUOut_in;
//                   Rd_out <= Rd_in;
//                   MemRead_out <= 1'h0;
//                   MemWrite_out <= 1'h0;
//                   MemToReg_out <= 1'h0;
//                   Branch_addr_out<=Branch_addr_in; 
//                   alu_zero_out<=alu_zero_in;
//                   RegWrite_out <= 2'h0;    
//                   Branch_out<= 1'h0;
//                   RegWriteAddr_out<=RegWriteAddr_in;
//               end	
	else begin
        PC_add_4_out <= PC_add_4_in;
        DataBusB_out <= DataBusB_in;
        ALUOut_out <= ALUOut_in;
        Rd_out <= Rd_in;
        MemRead_out <= MemRead_in;
        MemWrite_out <= MemWrite_in;
        MemToReg_out <= MemToReg_in;
        RegWrite_out <= RegWrite_in;
        Branch_addr_out<=Branch_addr_in;  
        alu_zero_out<=alu_zero_in;
        Branch_out<= Branch_in;
        RegWriteAddr_out<=RegWriteAddr_in;
	end   end
endmodule
