//`timescale 1ns / 1ps


module top_hazard(
    input clk,                   //板子的时钟 100MHZ
    input run,                  //表示连续执行
    input step,                 //用板子按键模拟，表示调试            
    input reset,
    input [2:0] SW,              // 选择数码管显示内容,SW[2]选高/低16位,SW[1:0]选显示内容
    output [6:0] sm_duan,        // 段码
    output [3:0] sm_wei,          // 哪个数码管
    output stall,
    output [3:0] ALUCode_id,
    output light_flag
    );
    //mips信号线
    wire [31:0] aluRes;
    wire [31:0] instruction;
    wire [31:0] PC;
    wire [31:0] memreaddata;
    
    //display信号线
    wire [15:0] disp_num;
    wire [31:0] display_content;
    
    wire step_debounce;
    wire reset_debounce;
    //除了Ins_ROM之外，其他部件不需要100Mhz的时钟，因此定义一个clkin，是clk分频的结果
//        integer clk_cnt=0;
//        reg clkin;//1.33秒一个时钟周期，以此为cpu的时钟周期    10^8/0.75*10^8=4/3=1.33
//        always @(posedge clk)
//            if(clk_cnt==32'd75_000_000) 
//                begin
//                    clk_cnt <= 1'b0; 
//                    clkin <=~clkin;
//                end 
//            else clk_cnt <= clk_cnt + 1'b1;
    
    //实例化debounce
    KeyDebounce key_debounce(
            .CLK(clk),
            .KeyIn(step),
            .KeyOut(step_debounce)//接PC更新时钟
        );
    KeyDebounce key_debounce2(
            .CLK(clk),
            .KeyIn(reset),
            .KeyOut(reset_debounce)//接PC更新时钟
    );

    //实例化mips
    MIPS_hazard mips ( 
    .clk(clk), 
    .run(run),
    .step(step_debounce),
    .reset(reset_debounce) ,
    .alu_res_ex(aluRes),
    .Ins_if(instruction),
    .Dout_mem(memreaddata),
    .PC_if(PC),
    .stall(stall),
    .ALUCode_id(ALUCode_id)
    ); 

    //assign light_flag=instruction[0]|instruction[1]|instruction[2]|instruction[3]|instruction[4]|instruction[5]|instruction[6]|instruction[7];
    
    //选择应该显示的内容
    //assign display_content= (SW[1:0]== 2'b00)? aluRes : (SW[1:0]== 2'b01)? instruction : PC; 
    //assign display_content= (SW[1:0]== 2'b00)? aluRes : (SW[1:0]== 2'b01)? instruction :(SW[1:0]== 2'b10)? PC; //错误写法
    MUX32_4_1 display_mux_1(
                .A(aluRes),
                .B(instruction),
                .C(PC),
                .D(memreaddata),
                .Sel(SW[1:0]),
                .O(display_content)
                );
    
    //用一个开关，来选择是显示高16位还是低16位
    //assign disp_num = (SW[2] == 1)? display_content[31:16]:display_content[15:0];
    MUX32_2_1 display_mux_2(
            .A(display_content[31:16]),
            .B(display_content[15:0]),
            .Sel(SW[2]),
            .O(disp_num)
            );
    //实例化数码管显示模块
    display Smg(.clk(clk),.sm_wei(sm_wei),.data(disp_num),.sm_duan(sm_duan)); 
    //数码管显示模块也用高频时钟触发，因为内部有分频模块

        
endmodule
