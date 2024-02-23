`timescale 1ns / 1ps//寄存器堆模块
module RegFile(Clk,Clr,Write_Reg,R_Addr_A,R_Addr_B,W_Addr,W_Data,R_Data_A,R_Data_B,jr);
    parameter ADDR = 5;//寄存器编码/地址位宽
    parameter NUMB = 1<<ADDR;//寄存器个数
    parameter SIZE = 32;//寄存器数据位宽
    input Clk;//写入时钟信号
    input Clr;//清零信号
    input Write_Reg;//写控制信号
    input [ADDR-1:0]R_Addr_A;//A端口读寄存器地址
    input [ADDR-1:0]R_Addr_B;//B端口读寄存器地址
    input [ADDR-1:0]W_Addr;//写寄存器地址//4位，表示第几号寄存器，不是实际地址
    input [SIZE-1:0]W_Data;//写入数据
    input jr;
    output wire [SIZE-1:0]R_Data_A;//A端口读出数据
    output wire [SIZE-1:0]R_Data_B;//B端口读出数据
    reg [SIZE-1:0]REG_Files[0:NUMB-1];//寄存器堆本体
    integer i;//用于遍历NUMB个寄存器
    
    //避免结构冒险，前半个周期写，后半个周期读
    //下降沿写，读不需要时钟控制。写需要clk-q的时间，时间很短，留有较长的时间给读
    always@(negedge  Clk or posedge Clr)
        begin
            if(Clr)//清零
                    for(i=0;i<NUMB;i=i+1) 
                        REG_Files[i]<=i;//对REG_Files全部赋值为i
            else//不清零,检测写控制, 高电平则写入寄存器
                    if(Write_Reg==1 ) //&& jr==0
                        REG_Files[W_Addr]<=W_Data; 
        end        
    //读操作没有使能或时钟信号控制, 使用数据流建模(组合逻辑电路,读不需要时钟控制)
    assign R_Data_A=REG_Files[R_Addr_A];//不受时钟控制
    assign R_Data_B=REG_Files[R_Addr_B];
//      always@(negedge Clk)
//        begin
//            R_Data_A=REG_Files[R_Addr_A];
//            R_Data_B=REG_Files[R_Addr_B];
//      end
    
    
    //对regfile进行初始化
    initial 
        begin
            for(i=0;i<32;i=i+1) REG_Files[i]=i; //测试数据
    end
    
endmodule