`timescale 1ns / 1ps//�Ĵ�����ģ��
module RegFile(Clk,Clr,Write_Reg,R_Addr_A,R_Addr_B,W_Addr,W_Data,R_Data_A,R_Data_B,jr);
    parameter ADDR = 5;//�Ĵ�������/��ַλ��
    parameter NUMB = 1<<ADDR;//�Ĵ�������
    parameter SIZE = 32;//�Ĵ�������λ��
    input Clk;//д��ʱ���ź�
    input Clr;//�����ź�
    input Write_Reg;//д�����ź�
    input [ADDR-1:0]R_Addr_A;//A�˿ڶ��Ĵ�����ַ
    input [ADDR-1:0]R_Addr_B;//B�˿ڶ��Ĵ�����ַ
    input [ADDR-1:0]W_Addr;//д�Ĵ�����ַ//4λ����ʾ�ڼ��żĴ���������ʵ�ʵ�ַ
    input [SIZE-1:0]W_Data;//д������
    input jr;
    output wire [SIZE-1:0]R_Data_A;//A�˿ڶ�������
    output wire [SIZE-1:0]R_Data_B;//B�˿ڶ�������
    reg [SIZE-1:0]REG_Files[0:NUMB-1];//�Ĵ����ѱ���
    integer i;//���ڱ���NUMB���Ĵ���
    
    //����ṹð�գ�ǰ�������д���������ڶ�
    //�½���д��������Ҫʱ�ӿ��ơ�д��Ҫclk-q��ʱ�䣬ʱ��̣ܶ����нϳ���ʱ�����
    always@(negedge  Clk or posedge Clr)
        begin
            if(Clr)//����
                    for(i=0;i<NUMB;i=i+1) 
                        REG_Files[i]<=i;//��REG_Filesȫ����ֵΪi
            else//������,���д����, �ߵ�ƽ��д��Ĵ���
                    if(Write_Reg==1 ) //&& jr==0
                        REG_Files[W_Addr]<=W_Data; 
        end        
    //������û��ʹ�ܻ�ʱ���źſ���, ʹ����������ģ(����߼���·,������Ҫʱ�ӿ���)
    assign R_Data_A=REG_Files[R_Addr_A];//����ʱ�ӿ���
    assign R_Data_B=REG_Files[R_Addr_B];
//      always@(negedge Clk)
//        begin
//            R_Data_A=REG_Files[R_Addr_A];
//            R_Data_B=REG_Files[R_Addr_B];
//      end
    
    
    //��regfile���г�ʼ��
    initial 
        begin
            for(i=0;i<32;i=i+1) REG_Files[i]=i; //��������
    end
    
endmodule