module ID_EX_Reg(
	clk, reset,flush,
	PC_add_4_in, DataBusA_in,DataBusB_in,Rs_in, Rt_in,Rd_in, Shamt_in,	RegDst_in,MemRead_in, MemWrite_in, MemToReg_in, ALUFun_in, ALUSrc1_in, ALUSrc2_in, RegWrite_in,imm_in,Branch_in,
	PC_add_4_out,DataBusA_out,DataBusB_out, Rs_out, Rt_out, Rd_out, Shamt_out, RegDst_out,MemRead_out, MemWrite_out,	MemToReg_out, ALUFun_out,ALUSrc1_out,ALUSrc2_out,RegWrite_out,imm_out,Branch_out);
    input clk;//
    input reset;//
    input [31:0] PC_add_4_in;
    input [31:0] DataBusA_in;//
    input [31:0] DataBusB_in;//
    input [4:0] Rs_in,Rt_in,Rd_in,Shamt_in;//
    input RegDst_in;//
    input MemRead_in,MemWrite_in,ALUSrc1_in,ALUSrc2_in;//还没加移位指令，暂时用不上ALUSrc1
    input RegWrite_in;
    input [1:0] MemToReg_in;
    input [3:0] ALUFun_in;
    input [31:0]imm_in;
    input Branch_in;
    input flush;
    output reg [31:0] PC_add_4_out,DataBusA_out,DataBusB_out=32'b0;
    output reg [4:0] Rs_out,Rt_out, Rd_out,Shamt_out=5'b0;
    output reg RegDst_out=1'b0;
    output reg MemRead_out,MemWrite_out=1'b0;
    output reg [1:0] MemToReg_out=2'b0;
    output reg [3:0] ALUFun_out=4'b0;
    output reg ALUSrc1_out,ALUSrc2_out,RegWrite_out=1'b0;
    output reg [31:0] imm_out=32'b0;
    output reg Branch_out=1'b0;
    always @(posedge clk or negedge reset) begin
	if (reset) //在stall来临时将所有信号都清除（数据也可以清除，反正ID会再次接收指令译码）
	   begin
        PC_add_4_out <= 32'h0000_0000;DataBusA_out <= 32'h0000_0000;
        DataBusB_out <= 32'h0000_0000;
        Rs_out <= 5'h00;	Rt_out <= 5'h00;
        Rd_out <= 5'h00;	Shamt_out <= 5'h00;
        RegDst_out <= 2'h0;
        MemRead_out <= 1'h0;MemWrite_out <= 1'h0;
        MemToReg_out <= 1'h0;	ALUFun_out <= 6'h00;
        ALUSrc1_out <= 1'h0;	ALUSrc2_out <= 1'h0;
        RegWrite_out <= 2'h0;	
        Branch_out<= 1'h0;
        imm_out<=32'h0;
	   end
	else if(flush==1)
	       begin
	           PC_add_4_out <= PC_add_4_in;
	           DataBusA_out <= 0;
               DataBusB_out <= 0;
               Rs_out <= Rs_in;    Rt_out <= Rt_in;
               Rd_out <= Rd_in;    Shamt_out <= 0;
               RegDst_out <= 2'h0;  
               MemRead_out <= 1'h0;MemWrite_out <= 1'h0;
               MemToReg_out <= 1'h0;    ALUFun_out <= 6'h00;
               ALUSrc1_out <= 1'h0;    ALUSrc2_out <= 1'h0;
               RegWrite_out <= 2'h0;    
               Branch_out<= 1'h0;
               imm_out<=32'h0;
           end
        else
            begin
                PC_add_4_out <= PC_add_4_in;
                DataBusA_out <= DataBusA_in;
                DataBusB_out <= DataBusB_in;
                Rs_out <= Rs_in;
                Rt_out <= Rt_in;
                Rd_out <= Rd_in;
                Shamt_out <= Shamt_in;
                RegDst_out <= RegDst_in;
                MemRead_out <= MemRead_in;
                MemWrite_out <= MemWrite_in;
                MemToReg_out <= MemToReg_in;
                ALUFun_out <= ALUFun_in;
                ALUSrc1_out <= ALUSrc1_in;
                ALUSrc2_out <= ALUSrc2_in;
                RegWrite_out <= RegWrite_in;
                Branch_out<= Branch_in;
                imm_out<=imm_in;
            end
        end
    endmodule

