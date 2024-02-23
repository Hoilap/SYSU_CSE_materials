module EX(clk,add4_ex,
    ALUCode_ex,ALUSrcB_ex,
    RegDst_ex,
    Imm_ex,RsData_ex,RtData_ex,
    RtAddr_ex,RdAddr_ex,
    ForwardA,ForwardB,
    alu_res_mem,alu_res_wb,
    Branch_ex,
    //���
    Branch_addr_ex,
    alu_zero_ex,alu_res_ex,RegWriteAddr_ex,
    branch_confirm
    );
    
input clk;
input[31:0] add4_ex;
input[3:0] ALUCode_ex;
input ALUSrcB_ex;
input RegDst_ex;
input[31:0] Imm_ex;
input[31:0] RsData_ex;
input[31:0] RtData_ex;
input[4:0] RtAddr_ex;
input[4:0] RdAddr_ex;
input[1:0] ForwardA,ForwardB;
input[31:0] alu_res_mem,alu_res_wb;
input Branch_ex;

output[31:0] Branch_addr_ex;
output alu_zero_ex;
output[31:0] alu_res_ex;
output reg[4:0] RegWriteAddr_ex=5'b0;
output branch_confirm;

//��֧��ַ  //Ϊʲô������next_PC�д�����Ϊ����ڵ�һ�����ڵ�next_pc�����֧��ַ������������beqָ���
assign Branch_addr_ex = add4_ex + (Imm_ex << 2);

//ALUSrcB�Ķ�ѡ��
reg[31:0] alu_in;
always@(*)begin
    case(ALUSrcB_ex)
    1'b0:alu_in<=RtData_ex;//���ԼĴ����ѵڶ������
    1'b1:alu_in<=Imm_ex;//���Է�����չ
    endcase
end

reg[31:0] ALUA,ALUB;
always@(*)begin
    case(ForwardA)
    2'b00:ALUA<=RsData_ex;
    2'b10:ALUA<=alu_res_mem;
    2'b01:ALUA<=alu_res_wb;
    endcase
end
always@(*)begin
    case(ForwardB)
    2'b00:ALUB<=alu_in;
    2'b10:ALUB<=alu_res_mem;
    2'b01:ALUB<=alu_res_wb;
    endcase
end



//ALU
ALU ALU(.AluOp(ALUCode_ex),.A(ALUA),.B(ALUB),
        .F(alu_res_ex),.ZF(alu_zero_ex),.OF()//overflowʲôҲ����
        );
 
//д�Ĵ����ѵ�ַ�Ķ�ѡ��
always@(*)begin
case(RegDst_ex)
    1'b0:RegWriteAddr_ex<=RtAddr_ex;//rt
    1'b1:RegWriteAddr_ex<=RdAddr_ex;//rd
endcase
end

//Next_PCģ��,ȷ����ת�ź�
//Ϊʲô����IFģ�������ɣ���ΪZF��branch���ź�����ʱ�䲻һ�����ᵼ�´������ͳһ��MEM������
assign branch_confirm=Branch_ex&alu_zero_ex ? 1'b1:1'b0;
 
endmodule
