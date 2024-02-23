`timescale 1ns / 1ps
module SignExt(
    input [15:0] inst, // ����16λ������
    input  ExtOp,      //�Ƿ���з���λ��չ
    output [31:0] data // ���32λ
);
// ���ݷ��Ų������λ
//�������λΪ1���򲹳�16��1����16'h ffff
//�������λΪ0���򲹳�16��0
assign data= inst[15:15]&ExtOp?{16'hffff,inst}:{16'h0000,inst}; 
endmodule
