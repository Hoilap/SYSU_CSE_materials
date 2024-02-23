`timescale 1ns / 1ps


module top(
    input clk,                   //���ӵ�ʱ�� 100MHZ
    input run,                  //��ʾ����ִ��
    input step,                 //�ð��Ӱ���ģ�⣬��ʾ����            
    input reset,
    input [2:0] SW,              // ѡ���������ʾ����,SW[2]ѡ��/��16λ,SW[1:0]ѡ��ʾ����
    output [6:0] sm_duan,        // ����
    output [3:0] sm_wei          // �ĸ������
    );
    //mips�ź���
    wire [31:0] aluRes;
    wire [31:0] instruction;
    wire [31:0] PC;
    wire [31:0] memreaddata;
    
    //display�ź���
    wire [15:0] disp_num;
    wire [31:0] display_content;
    
    wire STEPCLK;
    //����Ins_ROM֮�⣬������������Ҫ100Mhz��ʱ�ӣ���˶���һ��clkin����clk��Ƶ�Ľ��
    //    integer clk_cnt=0;
    //    reg clkin;//1.33��һ��ʱ�����ڣ��Դ�Ϊcpu��ʱ������    10^8/0.75*10^8=4/3=1.33
    //    always @(posedge clk)
    //        if(clk_cnt==32'd75_000_000) 
    //            begin
    //                clk_cnt <= 1'b0; 
    //                clkin <=~clkin;
    //            end 
    //        else clk_cnt <= clk_cnt + 1'b1;
    
    //ʵ����debounce
    KeyDebounce key_debounce(
            .CLK(clk),
            .KeyIn(step),
            .KeyOut(STEPCLK)//��PC����ʱ��
        );

    //ʵ����mips
    MIPS mips ( 
    .clk(clk), 
    //.clk_for_ROM(clk),
    .run(run),
    .step(STEPCLK),
    .reset(reset) ,
    .aluRes(aluRes),
    .instruction(instruction),
    .memreaddata(memreaddata),
    .PC(PC)
    ); 
    
    
    //ѡ��Ӧ����ʾ������
    //assign display_content= (SW[1:0]== 2'b00)? aluRes : (SW[1:0]== 2'b01)? instruction : PC; 
    //assign display_content= (SW[1:0]== 2'b00)? aluRes : (SW[1:0]== 2'b01)? instruction :(SW[1:0]== 2'b10)? PC; //����д��
    MUX32_4_1 display_mux_1(
                .A(aluRes),
                .B(instruction),
                .C(PC),
                .D(memreaddata),
                .Sel(SW[1:0]),
                .O(display_content)
                );
    
    //��һ�����أ���ѡ������ʾ��16λ���ǵ�16λ
    //assign disp_num = (SW[2] == 1)? display_content[31:16]:display_content[15:0];
    MUX32_2_1 display_mux_2(
            .A(display_content[31:16]),
            .B(display_content[15:0]),
            .Sel(SW[2]),
            .O(disp_num)
            );
    //ʵ�����������ʾģ��
    display Smg(.clk(clk),.sm_wei(sm_wei),.data(disp_num),.sm_duan(sm_duan)); 
    //�������ʾģ��Ҳ�ø�Ƶʱ�Ӵ�������Ϊ�ڲ��з�Ƶģ��

        
endmodule
