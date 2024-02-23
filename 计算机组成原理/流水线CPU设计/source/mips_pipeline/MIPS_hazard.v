`timescale 1ns / 1ps
module MIPS_hazard(
    clk,//clk�ӽ�������top��ʱ��
    reset,
    run,
    step,
    alu_res_ex,
    Ins_if,
    PC_if,
    Dout_mem,//���ݴ洢��
    CPUCLK,
    stall,
    ALUCode_id
);
//ͨ���ź��ߣ���divider��
input clk;//clk�ӽ�������top��ʱ��
input reset;
input run;
input step;
wire divided_clk;
output wire CPUCLK;
//IF
//����
wire [31:0] branch_addr;
//���
wire [31:0] add4_if;//��next_PC�н�next_PC����add4/beq׼����
output wire [31:0] Ins_if;//��ROM�ж���ָ��
output wire [31:0] PC_if;	//PC��ʾrom��ָ���λ��,��ΪpcҪ��always����ڸ�ֵ�����Ϊreg��
//ID
//����
wire [31:0] add4_id;//��next_PC�н�next_PC����add4/beq׼����
wire [31:0] Ins_id;//��ROM�ж���ָ��
//���
wire RegWrite_id;
wire RegDst_id;
wire MemRead_id;
wire MemWrite_id;
wire ALUSrcB_id;
wire Branch_id;
wire[1:0] MemtoReg_id;
output wire[3:0] ALUCode_id;
wire[31:0] Imm_id;//������չ
wire[31:0] RsData_id;//�Ĵ��������1
wire[31:0] RtData_id;//�Ĵ��������2
wire[4:0] RtAddr_id;//rt
wire[4:0] RdAddr_id;//rd
wire[4:0] RsAddr_id;//rs
wire[4:0] shamt_id;
//EX
//����
wire [31:0] add4_ex;
wire[4:0] RtAddr_ex,RdAddr_ex,RsAddr_ex;
wire[4:0] shamt_ex;
wire [1:0]MemtoReg_ex;
wire RegWrite_ex,MemWrite_ex;
wire MemRead_ex,ALUSrcB_ex,RegDst_ex,Branch_ex;
wire[3:0] ALUCode_ex;
wire[31:0] Imm_ex,RsData_ex,RtData_ex,next_pc_ex;
//���
wire[31:0] Branch_addr_ex;
output wire[31:0] alu_res_ex;
wire alu_zero_ex;
wire[4:0] RegWriteAddr_ex;
//MEM
//����
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
//���
wire branch_confirm;
output wire[31:0] Dout_mem;
//WB
//����
wire[4:0] RdAddr_wb;
wire[31:0] Dout_wb;
wire[31:0] alu_res_wb;
wire [1:0]MemtoReg_wb;
wire[4:0] RegWriteAddr_wb;
wire RegWrite_wb;
//���
reg [31:0] RegWriteData_wb=32'b0;

//Foreard Unit
wire [1:0] ForwardA,ForwardB;
//hazard unit
output wire [1:0]stall;
wire [1:0] flush;


//��Ƶ����MIPS��
Divider d(.clk(clk),.divided_clk(divided_clk),.reset(1'b0));
//ʱ������
assign CPUCLK=(run==0)?step:divided_clk;
//IF=Ins_ROM+next_PC+PC�Ĵ���
//ע��ins_rom��Ҫ��ʱ�Ӵ��������IFģ��Ҫ������ʱ��
IF ins_fetch(.CPUCLK(CPUCLK),
             .rom_clk(clk),
             .reset(reset),
             .branch_confirm(branch_confirm),
             .branch_addr(Branch_addr_ex),
             .stall(stall[0]),
             .inst_from_rom(Ins_if),
             .PC(PC_if),//������ʾ
             .PC_add_4(add4_if)//���ڴ���IF/ID�Ĵ���
             );
           
//IF/ID�Ĵ���
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
                    
                    
//ID=regfile+������չ+���Ƶ�Ԫ
ID id(.clk(CPUCLK),.reset(reset),.inst_id(Ins_id),
      //���룬����wb
      .RegWrite_wb(RegWrite_wb),.RegWriteAddr_wb(RegWriteAddr_wb),
      .RegWriteData_wb(RegWriteData_wb),//�ͽ���������Ҫ����ѡ����WB����ΪRegWriteData_wb��
      //���
      //�����ź�
      .RegWrite_id(RegWrite_id),.RegDst_id(RegDst_id),.MemtoReg_id(MemtoReg_id),
      .MemWrite_id(MemWrite_id),.MemRead_id(MemRead_id),
      .ALUCode_id(ALUCode_id),.ALUSrcB_id(ALUSrcB_id),
      .Branch_id(Branch_id),
      //�����ź�
      .Imm_id(Imm_id),.RsData_id(RsData_id),.RtData_id(RtData_id),
      .RtAddr_id(RtAddr_id),.RdAddr_id(RdAddr_id),.RsAddr_id(RsAddr_id),
      .shamt_id(shamt_id));
      
//ID/EX�Ĵ���
ID_EX_Reg id_ex_reg (
	  .clk(CPUCLK), .reset(reset),.flush(flush[1]),/////////////////
	  //in
	       //�����ź�
	       .RegDst_in(RegDst_id),.ALUSrc2_in(ALUSrcB_id), .ALUFun_in(ALUCode_id),//EXE
	       .MemRead_in(MemRead_id), .MemWrite_in(MemWrite_id),.Branch_in(Branch_id) ,//MEM
	       .MemToReg_in(MemtoReg_id), .RegWrite_in(RegWrite_id),//WB
	       //�����ź�  add4+imm=��ָ֧����ת��ַ
	       .PC_add_4_in(add4_id),.DataBusA_in(RsData_id),.DataBusB_in(RtData_id),.imm_in(Imm_id),.Rt_in(RtAddr_id),.Rd_in(RdAddr_id), .Shamt_in(shamt_id),.Rs_in(RsAddr_id),
	  //out
          //�����ź�
           .RegDst_out(RegDst_ex),.ALUFun_out(ALUCode_ex),.ALUSrc2_out(ALUSrcB_ex),//EXE
           .MemRead_out(MemRead_ex), .MemWrite_out(MemWrite_ex),.Branch_out(Branch_ex), //MEM
           .MemToReg_out(MemtoReg_ex), .RegWrite_out(RegWrite_ex),//WB
           //�����ź�
           .PC_add_4_out(add4_ex),.DataBusA_out(RsData_ex),.DataBusB_out(RtData_ex),.imm_out(Imm_ex),.Rt_out(RtAddr_ex),.Rd_out(RdAddr_ex), .Shamt_out(shamt_ex),.Rs_out(RsAddr_ex));

//EX=ALUSrc2ѡ����+ALU+д�Ĵ����Ķѵ�ַ
EX ex(.clk(CPUCLK),.add4_ex(add4_ex),
        .ALUCode_ex(ALUCode_ex),.ALUSrcB_ex(ALUSrcB_ex),
        .RegDst_ex(RegDst_ex),
        .Imm_ex(Imm_ex),.RsData_ex(RsData_ex),.RtData_ex(RtData_ex),
        .RtAddr_ex(RtAddr_ex),.RdAddr_ex(RdAddr_ex),
        .ForwardA(ForwardA),.ForwardB(ForwardB),
        .alu_res_mem(alu_res_mem),.alu_res_wb(alu_res_wb),
        .Branch_ex(Branch_ex),
        //���
        .Branch_addr_ex(Branch_addr_ex),
        .alu_zero_ex(alu_zero_ex),.alu_res_ex(alu_res_ex),
        .RegWriteAddr_ex(RegWriteAddr_ex),
        .branch_confirm(branch_confirm)
        );
//EX/MEM�Ĵ���
EX_MEM_Reg ex_mem_reg(
	.clk(CPUCLK), .reset(reset),//.stall(stall),
	//in   DataBusB_in����rt�����ݣ���lw sw�ļĴ�����д�ĵ�ַ
	.PC_add_4_in(add4_ex),.Branch_addr_in(Branch_addr_ex),.alu_zero_in(alu_zero_ex),//�γ���PC�ı�Ҫ����
	.ALUOut_in(alu_res_ex), .DataBusB_in(RtData_ex),.Rd_in(RdAddr_ex),  //.Rt_in(), .Rd_in(), .RegDst_in()Ӧ�ò���Ҫ����Ϊ��EX�׶ξ����д�Ĵ�����ַ��
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
	
//MEM=���ݴ洢��+next_PC���źţ��Ƿ�Ϊbranch������add4_mem��Branch_addr_mem��ѡһ����
MEM mem(
    .clk(CPUCLK),
    //�����ź�����
    .MemRead_mem(MemRead_mem),.MemWrite_mem(MemWrite_mem),
    //����nextPC�Ľӿ�
    .Branch_mem(Branch_mem),.alu_zero_mem(alu_zero_mem),
    //.add4_mem(add4_mem),.Branch_addr_mem(Branch_addr_mem),
    //��������
    .alu_res_mem(alu_res_mem),.RtData_mem(RtData_mem),
    //���
    //.next_pc_branch_mem(branch_confirm),
    .Dout_mem(Dout_mem)//ע���ź�Ҫ�����ͣ���IF
);

//MEM/WB�Ĵ���
MEM_WB_Reg  mem_wb_reg(
   .clk(CPUCLK), .reset(reset),
   .ALUOut_in(alu_res_mem), .MemReadData_in(Dout_mem), .Rd_in(RdAddr_mem), .MemToReg_in(MemtoReg_mem), .RegWrite_in(RegWrite_mem),.RegWriteAddr_in(RegWriteAddr_mem), 
   .ALUOut_out(alu_res_wb),. MemReadData_out(Dout_wb), .Rd_out(RdAddr_wb),.MemToReg_out(MemtoReg_wb), .RegWrite_out(RegWrite_wb),.RegWriteAddr_out(RegWriteAddr_wb));
//MemtoReg_mem�Ƕ�ѡ���Ŀ����źţ�RegWriteAddr_mem�ǼĴ���д�ص�ַ��RegWrite_mem�ǼĴ���дʹ���ź�

//WB:ֻ��һ����ѡ����ֱ���ڶ���ʵ��.ѡ��д�ؼĴ���������
always@(*)begin
case(MemtoReg_wb)
    1'b0:RegWriteData_wb<=alu_res_wb;//����ALU
    1'b1:RegWriteData_wb<=Dout_wb;//����RAM
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
