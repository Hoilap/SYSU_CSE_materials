`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module KeyDebounce(
    input CLK, // 这个时钟接100mhz
    input KeyIn,    // 输入按键step
    output KeyOut   // 
);

    reg Delay1, Delay2, Delay3;// 设置三个延时信号
    reg [15:0] DivideCounter; // 对时钟分频
    initial begin //       
    DivideCounter = 0;
    end
    always @(posedge CLK)
    begin 
       DivideCounter <= DivideCounter + 1;  //
    end 
        always@(posedge DivideCounter[15])  //等价于2^15个时钟脉冲后从0到1
    begin
        Delay1 <= KeyIn;    //Delay1 检测到一次按键
        Delay2 <= Delay1;   //Delay2 检测到两次按键
        Delay3 <= Delay2;   //Delay3 检测到三次按键
    end    
    
    assign KeyOut = Delay1 & Delay2 & Delay3;    //检测到三次按键认为是一次按键

endmodule
