`timescale 1ns / 1ps
module top_sim; 
// Inputs 
reg clk;                 //板子的时钟 100MHZ
wire run;                  //表示连续执行
wire step;                 //用板子按键模拟，表示调试            
reg reset;
wire [2:0] SW;              // 选择数码管显示内容,SW[2]选高/低16位,SW[1:0]选显示内容
wire [6:0] sm_duan;        // 段码
wire [3:0] sm_wei;         // 哪个数码管
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
//把这一段注释掉，仿真就没问题了。因为这里默认reset为1，且后面没有改变reset
parameter PERIOD = 1000; 
assign run=1;
always begin 
        #(PERIOD / 2) clk = 1'b1; 
        #(PERIOD / 2) clk = 1'b0; 
    end 
endmodule
