`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module KeyDebounce(
    input CLK, // ���ʱ�ӽ�100mhz
    input KeyIn,    // ���밴��step
    output KeyOut   // 
);

    reg Delay1, Delay2, Delay3;// ����������ʱ�ź�
    reg [15:0] DivideCounter; // ��ʱ�ӷ�Ƶ
    initial begin //       
    DivideCounter = 0;
    end
    always @(posedge CLK)
    begin 
       DivideCounter <= DivideCounter + 1;  //
    end 
        always@(posedge DivideCounter[15])  //�ȼ���2^15��ʱ��������0��1
    begin
        Delay1 <= KeyIn;    //Delay1 ��⵽һ�ΰ���
        Delay2 <= Delay1;   //Delay2 ��⵽���ΰ���
        Delay3 <= Delay2;   //Delay3 ��⵽���ΰ���
    end    
    
    assign KeyOut = Delay1 & Delay2 & Delay3;    //��⵽���ΰ�����Ϊ��һ�ΰ���

endmodule
