`timescale 1ns / 1ps
module MIPS_hazard(
    clk,//clk接进来的是top的时钟
    reset,
    run,
    step,
    alu_res_ex,
    Ins_if,
    PC_if,
    Dout_mem,//数据存储器
    CPUCLK,
    stall,
    ALUCode_id
);
//通用信号线（给divider）
input clk;//clk接进来的是top的时钟
input reset;
input run;
input step;
wire divided_clk;
output wire CPUCLK;
//IF
//输入
wire [31:0] branch_addr;
//输出
wire [31:0] add4_if;//在next_PC中将next_PC根据add4/beq准备好
output wire [31:0] Ins_if;//从ROM中读的指令
output wire [31:0] PC_if;	//PC表示rom中指令的位置,因为pc要在always语句内赋值，因此为reg型
//ID
//输入
wire [31:0] add4_id;//在next_PC中将next_PC根据add4/beq准备好
wire [31:0] Ins_id;//从ROM中读的指令
//输出
wire RegWrite_id;
wire RegDst_id;
wire MemRead_id;
wire MemWrite_id;
wire ALUSrcB_id;
wire Branch_id;
wire[1:0] MemtoReg_id;
output wire[3:0] ALUCode_id;
wire[31:0] Imm_id;//符号拓展
wire[31:0] RsData_id;//寄存器堆输出1
wire[31:0] RtData_id;//寄存器堆输出2
wire[4:0] RtAddr_id;//rt
wire[4:0] RdAddr_id;//rd
wire[4:0] RsAddr_id;//rs
wire[4:0] shamt_id;
//EX
//输入
wire [31:0] add4_ex;
wire[4:0] RtAddr_ex,RdAddr_ex,RsAddr_ex;
wire[4:0] shamt_ex;
wire [1:0]MemtoReg_ex;
wire RegWrite_ex,MemWrite_ex;
wire MemRead_ex,ALUSrcB_ex,RegDst_ex,Branch_ex;
wire[3:0] ALUCode_ex;
wire[31:0] Imm_ex,RsData_ex,RtData_ex,next_pc_ex;
//输出
wire[31:0] Branch_addr_ex;
output wire[31:0] alu_res_ex;
wire alu_zero_ex;
wire[4:0] RegWriteAddr_ex;
//MEM
//输入
wire[4:0] RdAddr_mem;
wire RegWrite_mem;
wire MemRead_mem;
wire MemWrite_mem;
wire [1:0]MemtoReg_mem;
wire[31:0] alu_res_mem;
wire alu_zero_mem;
wire[31:0] RtData_mem;
wire[4:0] RegWriteAddr_mem;
wire [31:0]add4_mem;
wire[31:0] Branch_addr_mem;
wire Branch_mem;
//输出
wire branch_confirm;
output wire[31:0] Dout_mem;
//WB
//输入
wire[4:0] RdAddr_wb;
wire[31:0] Dout_wb;
wire[31:0] alu_res_wb;
wire [1:0]MemtoReg_wb;
wire[4:0] RegWriteAddr_wb;
wire RegWrite_wb;
//输出
reg [31:0] RegWriteData_wb=32'b0;

//Foreard Unit
wire [1:0] ForwardA,ForwardB;
//hazard unit
output wire [1:0]stall;
wire [1:0] flush;


//分频放在MIPS里
Divider d(.clk(clk),.divided_clk(divided_clk),.reset(1'b0));
//时钟驱动
assign CPUCLK=(run==0)?step:divided_clk;
//IF=Ins_ROM+next_PC+PC寄存器
//注意ins_rom需要快时钟触发，因此IF模块要传两个时钟
IF ins_fetch(.CPUCLK(CPUCLK),
             .rom_clk(clk),
             .reset(reset),
             .branch_confirm(branch_confirm),
             .branch_addr(Branch_addr_ex),
             .stall(stall[0]),
             .inst_from_rom(Ins_if),
             .PC(PC_if),//用于显示
             .PC_add_4(add4_if)//用于传入IF/ID寄存器
             );
           
//IF/ID寄存器
IF_ID_Reg if_id_reg(.clk(CPUCLK),
                    .reset(reset), 
                    .stall(stall[1]),
                    .flush(flush[0]),
                    .PC_add_4_in(add4_if), 
                    .Instruct_in(Ins_if),
                    .PC_add_4_out(add4_id), 
                    .Instruct_out(Ins_id));
                    
 //hazard unit
Hazard_unit hazard_unit(
       .clk(CPUCLK),
       .branch_confirm(branch_confirm),
       .id_ex_memread(MemRead_ex),
       .id_ex_rt(RtAddr_ex),
       .if_id_rs(Ins_id[25:21]),
       .if_id_rt(Ins_id[20:16]),
       .if_id_memwrite(MemWrite_id),
       .id_ex_rd(RdAddr_ex),
       .stall(stall),
       .flush(flush)
   );                              
                    
                    
//ID=regfile+数字拓展+控制单元
ID id(.clk(CPUCLK),.reset(reset),.inst_id(Ins_id),
      //输入，来自wb
      .RegWrite_wb(RegWrite_wb),.RegWriteAddr_wb(RegWriteAddr_wb),
      .RegWriteData_wb(RegWriteData_wb),//送进来的数据要经过选择，在WB命名为RegWriteData_wb！
      //输出
      //控制信号
      .RegWrite_id(RegWrite_id),.RegDst_id(RegDst_id),.MemtoReg_id(MemtoReg_id),
      .MemWrite_id(MemWrite_id),.MemRead_id(MemRead_id),
      .ALUCode_id(ALUCode_id),.ALUSrcB_id(ALUSrcB_id),
      .Branch_id(Branch_id),
      //数据信号
      .Imm_id(Imm_id),.RsData_id(RsData_id),.RtData_id(RtData_id),
      .RtAddr_id(RtAddr_id),.RdAddr_id(RdAddr_id),.RsAddr_id(RsAddr_id),
      .shamt_id(shamt_id));
      
//ID/EX寄存器
ID_EX_Reg id_ex_reg (
	  .clk(CPUCLK), .reset(reset),.flush(flush[1]),/////////////////
	  //in
	       //控制信号
	       .RegDst_in(RegDst_id),.ALUSrc2_in(ALUSrcB_id), .ALUFun_in(ALUCode_id),//EXE
	       .MemRead_in(MemRead_id), .MemWrite_in(MemWrite_id),.Branch_in(Branch_id) ,//MEM
	       .MemToReg_in(MemtoReg_id), .RegWrite_in(RegWrite_id),//WB
	       //数据信号  add4+imm=分支指令跳转地址
	       .PC_add_4_in(add4_id),.DataBusA_in(RsData_id),.DataBusB_in(RtData_id),.imm_in(Imm_id),.Rt_in(RtAddr_id),.Rd_in(RdAddr_id), .Shamt_in(shamt_id),.Rs_in(RsAddr_id),
	  //out
          //控制信号
           .RegDst_out(RegDst_ex),.ALUFun_out(ALUCode_ex),.ALUSrc2_out(ALUSrcB_ex),//EXE
           .MemRead_out(MemRead_ex), .MemWrite_out(MemWrite_ex),.Branch_out(Branch_ex), //MEM
           .MemToReg_out(MemtoReg_ex), .RegWrite_out(RegWrite_ex),//WB
           //数据信号
           .PC_add_4_out(add4_ex),.DataBusA_out(RsData_ex),.DataBusB_out(RtData_ex),.imm_out(Imm_ex),.Rt_out(RtAddr_ex),.Rd_out(RdAddr_ex), .Shamt_out(shamt_ex),.Rs_out(RsAddr_ex));

//EX=ALUSrc2选择器+ALU+写寄存器的堆地址
EX ex(.clk(CPUCLK),.add4_ex(add4_ex),
        .ALUCode_ex(ALUCode_ex),.ALUSrcB_ex(ALUSrcB_ex),
        .RegDst_ex(RegDst_ex),
        .Imm_ex(Imm_ex),.RsData_ex(RsData_ex),.RtData_ex(RtData_ex),
        .RtAddr_ex(RtAddr_ex),.RdAddr_ex(RdAddr_ex),
        .ForwardA(ForwardA),.ForwardB(ForwardB),
        .alu_res_mem(alu_res_mem),.alu_res_wb(alu_res_wb),
        .Branch_ex(Branch_ex),
        //输出
        .Branch_addr_ex(Branch_addr_ex),
        .alu_zero_ex(alu_zero_ex),.alu_res_ex(alu_res_ex),
        .RegWriteAddr_ex(RegWriteAddr_ex),
        .branch_confirm(branch_confirm)
        );
//EX/MEM寄存器
EX_MEM_Reg ex_mem_reg(
	.clk(CPUCLK), .reset(reset),//.stall(stall),
	//in   DataBusB_in就是rt的数据，是lw sw的寄存器读写的地址
	.PC_add_4_in(add4_ex),.Branch_addr_in(Branch_addr_ex),.alu_zero_in(alu_zero_ex),//形成新PC的必要数据
	.ALUOut_in(alu_res_ex), .DataBusB_in(RtData_ex),.Rd_in(RdAddr_ex),  //.Rt_in(), .Rd_in(), .RegDst_in()应该不需要，因为在EX阶段就求出写寄存器地址了
	.MemRead_in(MemRead_ex),.MemWrite_in(MemWrite_ex),.Branch_in(Branch_ex),//MEM
	.MemToReg_in(MemtoReg_ex),.RegWrite_in(RegWrite_ex), //WB
	.RegWriteAddr_in(RegWriteAddr_ex),
	//out
	.PC_add_4_out(add4_mem),.Branch_addr_out(Branch_addr_mem),.alu_zero_out(alu_zero_mem),
	.ALUOut_out(alu_res_mem),.DataBusB_out(RtData_mem), .Rd_out(RdAddr_mem), 
	.MemRead_out(MemRead_mem),.MemWrite_out(MemWrite_mem),.Branch_out(Branch_mem),//MEM
	.MemToReg_out(MemtoReg_mem),.RegWrite_out(RegWrite_mem),//WB
	.RegWriteAddr_out(RegWriteAddr_mem)
	);
	
//MEM=数据存储器+next_PC的信号（是否为branch）（从add4_mem和Branch_addr_mem中选一个）
MEM mem(
    .clk(CPUCLK),
    //控制信号输入
    .MemRead_mem(MemRead_mem),.MemWrite_mem(MemWrite_mem),
    //用于nextPC的接口
    .Branch_mem(Branch_mem),.alu_zero_mem(alu_zero_mem),
    //.add4_mem(add4_mem),.Branch_addr_mem(Branch_addr_mem),
    //数据输入
    .alu_res_mem(alu_res_mem),.RtData_mem(RtData_mem),
    //输出
    //.next_pc_branch_mem(branch_confirm),
    .Dout_mem(Dout_mem)//注意信号要往回送，给IF
);

//MEM/WB寄存器
MEM_WB_Reg  mem_wb_reg(
   .clk(CPUCLK), .reset(reset),
   .ALUOut_in(alu_res_mem), .MemReadData_in(Dout_mem), .Rd_in(RdAddr_mem), .MemToReg_in(MemtoReg_mem), .RegWrite_in(RegWrite_mem),.RegWriteAddr_in(RegWriteAddr_mem), 
   .ALUOut_out(alu_res_wb),. MemReadData_out(Dout_wb), .Rd_out(RdAddr_wb),.MemToReg_out(MemtoReg_wb), .RegWrite_out(RegWrite_wb),.RegWriteAddr_out(RegWriteAddr_wb));
//MemtoReg_mem是多选器的控制信号；RegWriteAddr_mem是寄存器写回地址；RegWrite_mem是寄存器写使能信号

//WB:只有一个多选器，直接在顶层实现.选择写回寄存器的内容
always@(*)begin
case(MemtoReg_wb)
    1'b0:RegWriteData_wb<=alu_res_wb;//来自ALU
    1'b1:RegWriteData_wb<=Dout_wb;//来自RAM
endcase
end

//Forward_Unit
Forward_Unit forward_unit (
  .clk(CPUCLK), .reset(reset),
  .EX_MEM_RegWrite(RegWrite_mem),
  .MEM_WB_RegWrite(RegWrite_wb),
  .ID_EX_RegRt(RtAddr_ex),
  .ID_EX_RegRs(RsAddr_ex),
  .EX_MEM_RegRd(RdAddr_mem),
  .MEM_WB_RegRd(RdAddr_wb),
  .ForwardA(ForwardA),
  .ForwardB(ForwardB)
);




endmodule
