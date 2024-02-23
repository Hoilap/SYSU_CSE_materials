`timescale 1ns / 1ps
module MIPS(
    input clk,//clk接进来的是top的时钟
    //input clk_for_ROM,
    input reset,
    input run,
    input step,
    output wire[31:0]aluRes,
    output wire[31:0]instruction,
    output reg [31:0]PC, 	//PC表示rom中指令的位置,因为pc要在always语句内赋值，因此为reg型
    output wire [31:0] next_PC,//不能用reg,元器件例化输出必须用wire
    output wire[31:0] memreaddata,//数据存储器
    output clkin,
    output wire[4:0]regWriteAddr,
    output wire[31:0]regWriteData,
    output wire [31:0] ALUSrcA,
    output wire[31:0] ALUSrcB,
    output wire[31:0] RtData
);
//////分频放在MIPS里
Divider d(.clk(clk),.divided_clk(clkin),.reset(1'b0));



// main control信号线
wire reg_dst,jmp,branch, memread, memwrite, memtoreg,alu_src,ExtOp,jal,nebranch;
wire[3:0] aluop;
wire regwrite;
wire [1:0] ls_flag;
// ALU控制 信号线
wire[3:0] aluCtr;//根据aluop和指令后6位 选择alu运算类型
wire [1:0] asel;
wire jr;
// ALU 信号线
wire ZF,OF,CF,PF,SF; //alu运算为零标志 

// 其他数据
wire[31:0] RsData;
wire[31:0] expand; 
wire[4:0] shamt;
assign shamt=instruction[10:6];
wire CPUCLK;


// 例化指令存储器  PC只传了9位，因为om数据深度128是指rom能存放128个32位数据，每个数据占4个字节，因此需要128*4个地址（按地址编址）->一共9条地址线
//PC每一次加了4
//addra只有7位（因为深度是128，只有7根地址线）Ins_Rom的地址每一次只需要加1，因此我们将中间7位传进去
Ins_Rom IM ( .clka(clk), .addra(PC[8:2]), .douta(instruction) ,.ena(1'b1));//记得要传eable，不然无法读指令

// 实例化控制器模块
MainControl mainctr(
    .opCode(instruction[31:26]),
    .regDst(reg_dst),
    .aluSrc(alu_src),
    .memToReg(memtoreg),
    .regWrite(regwrite),
    .memRead(memread),
    .memWrite(memwrite),
    .branch(branch),
    .ExtOp(ExtOp),
    .aluop(aluop),
    .jmp(jmp),
    .jal(jal),
    .nebranch(nebranch),
    .ls_flag(ls_flag)
    );
    
    
//  实例化 ALU 控制模块
ALUControl aluctr(
    .ALUOp(aluop),
    .funct(instruction[5:0]),
    .ALUCtr(aluCtr),
    .Asel(asel),
    .jr(jr)
    );

// 实例化寄存器模块
RegFile regfile(
    .R_Addr_A(instruction[25:21]),
    .R_Addr_B(instruction[20:16]),
    .Clk(CPUCLK),//这里原文档写了!clkin因为仿真的时候需要一半时间读一半时间写.因为我们需要一个setup时间，因此要在后半周期写
    .Clr(reset),
    .W_Addr(regWriteAddr),
    .W_Data(regWriteData),
    .Write_Reg(regwrite),
    .R_Data_A(RsData),
    .R_Data_B(RtData),
    .jr(jr)
    );

//lui alu操作数选择 
MUX32_4_1 SrcA(
        .A(RsData),
        .B({27'b0, instruction[10:6]}),//移位指令
        .C(32'b10000),//lui指令
        .D(RsData),
        .Sel(asel),
        .O(ALUSrcA)
        );
assign ALUSrcB = alu_src ? expand : RtData; //ALU的第二个操作数来自寄存器堆输出或指令低16位的立即数

//实例化ALU模块
ALU alu(
    .clk(CPUCLK),
    .A(ALUSrcA), //写入alu的第一个操作数必是Rs
    .B(ALUSrcB),
    .AluOp(aluCtr),
    .ZF(ZF),
    .OF(OF),
    .CF(CF),
    .PF(PF),
    .SF(SF),
    .F(aluRes),
    .step(step));
//实例化符号扩展模块
SignExt signext(.inst(instruction[15:0]),.ExtOp(ExtOp), .data(expand));
//实例化数据存储器
//Data_RAM2 dm(.clk(clkin), 
//            .we(memwrite),
//            .addr(aluRes), //一共32位地址线，由于只有lw功能且位宽位32位所以要去掉低两位
//            .datain(RtData),
//            .dataout( memreaddata),
//            .re(memread));
Data_RAM dm(.clk(CPUCLK), 
            .we(memwrite),
            .reset(reset),
            .flag(ls_flag),//00-> byte 01->half word  1x->word
            .a(aluRes[7:0]), //一共8位地址线地址
            .wd(RtData),//写入数据
            .rd(memreaddata),
            .re(memread)
            );
 
//实例化Next_PC模块
Next_PC nextpc(
    .branch(branch), 
    .nebranch(nebranch),
    .zero(ZF),
    .jmp(jmp),
    .jr(jr),
    .clkin(CPUCLK),//这个时钟要用分完频的
    .reset(reset),
    .RsData(RsData),
    .expand(expand),
    .instruction(instruction),
    .PC(PC),
    .next_pc(next_PC)
); 
//写寄存器
MUX32_4_1 mux_regWriteAddr(
        .A(instruction[20:16]),
        .B(instruction[15:11]),
        .C(32'd31),
        .D(32'd31),
        .Sel({jal,reg_dst}),
        .O(regWriteAddr)
        );
//写寄存器的目标寄存器来自rt或rd或ra//这种格式就是选择器的格式
MUX32_4_1 mux_regWriteData(
        .A(aluRes),
        .B(memreaddata),
        .C(PC+4),
        .D(PC+4),
        .Sel({jal,memtoreg}),
        .O(regWriteData)
        );
//写入寄存器的数据来自ALU或数据存储器或PC+4



//PC自改变
//initial PC<=0;
//always @(posedge clkin or posedge reset) begin
//    if (reset) 
//        PC <= 0;    // 在复位时将PC重置为0
//    else if (run) 
//        PC <= next_PC;    // 如果run为1，则连续执行PC=PC+4
//    else if (step)
//        PC <= next_PC;    // 如果run为0且step为1，则执行一次PC=PC+4
//end


assign CPUCLK=(run==0)?step:clkin;
initial PC=0;
always@(posedge CPUCLK or posedge reset)
    begin
            if(reset) PC=32'h00000000;
            else if(PC==32'h00000088)  PC=32'h00000000;
            else  PC=next_PC;
     end


endmodule
