`timescale 1ns / 1ps
//��������
module ALU(clk,AluOp,A,B,F,ZF,CF,OF,SF,PF,step);
    parameter SIZE = 32;//����λ��
        input [3:0] AluOp;//�������
        input [SIZE-1:0] A;//��������
        input [SIZE-1:0] B;//��������
        input clk;
        input step;
        output [SIZE-1:0] F;//������
        output       ZF, //0��־λ, ������Ϊ0(ȫ��)����1, ������0
                     CF, //����λ��־λ, ȡ���λ��λC,�ӷ�ʱC=1��CF=1��ʾ�н�λ,����ʱC=0��CF=1��ʾ�н�λ
                     OF, //�����־λ�����з��������������壬�����OF=1������Ϊ0                     
                     SF, //���ű�־λ����F�����λ��ͬ
                     PF; //��ż��־λ��F��������1����PF=1������Ϊ0    
        //�߼�����û�н�λҲû������жϣ����CF==C==��ʼֵ==0
       reg [SIZE-1:0] F;//������Ĭ��Ϊ����
       reg C,ZF,CF,OF,SF,PF;//CΪ���λ��λ

       always@(*)//alwaysģ���е��κ�һ�������źŻ��ƽ�����仯ʱ��������·���ģ�齫��ִ��
                begin
                    C=0;
                    case(AluOp)
                        4'b0100:begin F=A&B; end        //��λ��
                        4'b0101:begin F=A|B; end        //��λ��
                        4'b0110:begin F=A^B; end        //��λ���
                        4'b0111:begin F=~(A|B); end     //��λ���
                        4'b1001:begin F=B>>>A; end       //��B����Aλsrl �߼�����>>>
                        4'b1000:begin F=B<<<A; end       //��B����Aλsll
                        4'b0000:begin {C,F}=A+B; end    //�ӷ�,�ӷ��������C��F����
                        4'b0010:begin {C,F}=A-B; end    //����
                        4'b1010:begin F=A<B; end        //A<B��F=1������F=0 slt           
                        4'b0001:begin {C,F}=A+B; end    //addu
                        4'b1100:begin F=B>>A;end //sra
                        default:begin F=B+A;end
                    endcase
                    ZF = F==0;//FȫΪ0����ZF=1
                    CF = C; //��λ��λ��־
                    SF = F[SIZE-1];//���ű�־,ȡF�����λ
                    PF = ~^F;//��ż��־��F��������1����F=1��ż����1����F=0
                    if(AluOp== 4'b0001) OF=0;
                    else OF = (A[SIZE-1]^B[SIZE-1]^F[SIZE-1]^C)&~AluOp[2];// result is a
                  end
            //end
endmodule
