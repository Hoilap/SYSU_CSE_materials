`timescale 1ns / 1ps
module top_sim; 
// Inputs 
reg clk;                 //���ӵ�ʱ�� 100MHZ
wire run;                  //��ʾ����ִ��
wire step;                 //�ð��Ӱ���ģ�⣬��ʾ����            
reg reset;
wire [2:0] SW;              // ѡ���������ʾ����,SW[2]ѡ��/��16λ,SW[1:0]ѡ��ʾ����
wire [6:0] sm_duan;        // ����
wire [3:0] sm_wei;         // �ĸ������
wire [3:0] ALUCode_id;
wire stall;


// Instantiate the Unit Under Test (UUT) 
top_hazard uut ( 
    .clk(clk), 
    .run(run), 
    .step(step), 
    .reset(reset) ,
    .SW(SW),
    .sm_duan(sm_duan),
    .sm_wei(sm_wei),
    .ALUCode_id(ALUCode_id),
    .stall(stall)
); 
assign SW[2]=1'b1;
assign SW[1]=1'b0;
assign SW[0]=1'b0;
//initial 
//    begin 
//        // Initialize Inputs 
//        clk = 0; 
//        reset = 1; 
//    end 
//����һ��ע�͵��������û�����ˡ���Ϊ����Ĭ��resetΪ1���Һ���û�иı�reset
parameter PERIOD = 1000; 
assign run=1;
always begin 
        #(PERIOD / 2) clk = 1'b1; 
        #(PERIOD / 2) clk = 1'b0; 
    end 
endmodule
