module ID(clk,reset,inst_id,
RegWrite_wb,RegWriteAddr_wb,RegWriteData_wb,
RegDst_id,MemtoReg_id,RegWrite_id,
MemWrite_id,MemRead_id,ALUCode_id,
ALUSrcB_id,Branch_id,
Imm_id,RsData_id,RtData_id,
RtAddr_id,RdAddr_id,RsAddr_id,
shamt_id
);
input clk;
input reset;
input[31:0] inst_id;//IF����ָ��
 
//WB��������
input RegWrite_wb;
input[4:0] RegWriteAddr_wb;
input[31:0] RegWriteData_wb;
 
//�˸��ź����
output RegWrite_id;
output RegDst_id;
output MemRead_id;
output MemWrite_id;
output ALUSrcB_id;
output Branch_id;
output [1:0]MemtoReg_id;
output[3:0] ALUCode_id;
 
//�������
output[31:0] Imm_id;//������չ
output[31:0] RsData_id;//�Ĵ��������1
output[31:0] RtData_id;//�Ĵ��������2
output[4:0] RtAddr_id;//rt
output[4:0] RdAddr_id;//rd
output[4:0] RsAddr_id;//rd
output[4:0] shamt_id;

assign RsAddr_id=inst_id[25:21];//rs
assign RtAddr_id=inst_id[20:16];//rt
assign RdAddr_id=inst_id[15:11];//rd
assign Imm_id={{16{inst_id[15]}},inst_id[15:0]};//������չ��32λ������
assign shamt_id=inst_id[10:6];
 
/*����ģ��*/  //Ҫ�ĵĽӿڵĺܶ࣬�����ʹ��ԭ�е�maincontrol��alucontrol
CtrlUnit CtrlUnit(
//����
.inst(inst_id),
//���
.RegWrite(RegWrite_id),.RegDst(RegDst_id),
.Branch(Branch_id),.MemRead(MemRead_id),.MemWrite(MemWrite_id),
.ALUCode(ALUCode_id),.ALUSrc_B(ALUSrcB_id),
.MemtoReg(MemtoReg_id)
);
 
/*�Ĵ�����ģ��*/
RegFile regfile(
    //���룬��WB�����ṩ
    .R_Addr_A(RsAddr_id),
    .R_Addr_B(RtAddr_id),
    .Clk(clk),//����ԭ�ĵ�д��!clkin��Ϊ�����ʱ����Ҫһ��ʱ���һ��ʱ��д.��Ϊ������Ҫһ��setupʱ�䣬���Ҫ�ں������д
    .Clr(reset),
    .W_Addr(RegWriteAddr_wb),
    .W_Data(RegWriteData_wb),
    .Write_Reg(RegWrite_wb),
    //���
    .R_Data_A(RsData_id),
    .R_Data_B(RtData_id),
    .jr()
    );
 

 
endmodule
