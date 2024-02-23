`timescale 1ns / 1ps
module Next_PC(
    input branch, 
    input nebranch,
    input zero, 
    input jmp, 
    input jr,
    input clkin,//���ʱ��Ҫ�÷���Ƶ��
    input reset,
    input [31:0] RsData,
    input [31:0] expand,
    input [31:0] instruction,
    input [31:0] PC,
    output reg[31:0] next_pc
); 
    wire PCSrc1, PCSrc2;
    wire [31:0] J_Addr,branch_Addr;
    reg  [31:0] add4;
    //�Ѳ�ͬ�����PC׼����
    assign branch_Addr = add4 + (expand << 2);
    //�����j/jalָ��Ǿͽ�add4��instuctionƴ�ӣ������jr���Ǿͽ�����rs�Ĵ�����ķ��ص�ַ������
    //����mars����δ�0x00400000��ʼ����˾�����ת��ַ��Ҫ��0x00400000
    assign J_Addr =jr? RsData:{add4[31:28], instruction[25:0], 2'b00}-32'h400000;
    //PC�Ķ�ѡ��
    assign PCSrc1 = ((branch==1&zero==1)|(nebranch==1&zero==0)) ? 1'b1:1'b0;
    assign PCSrc2 = (jmp | jr)? 1'b1:1'b0;
    always@(*)
        begin 
            add4=PC+4;
        end
    always@ (*)
        begin
            casex({PCSrc2, PCSrc1})
                        2'b00:next_pc<=add4;
                        2'b01:next_pc<=branch_Addr;
                        2'b1x:next_pc<=J_Addr;
                        default:next_pc<=add4;
            endcase   
        end
endmodule
