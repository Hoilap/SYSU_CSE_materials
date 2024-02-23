module ID(clk,reset,inst_id,
RegWrite_wb,RegWriteAddr_wb,RegWriteData_wb,
RegDst_id,MemtoReg_id,RegWrite_id,
MemWrite_id,MemRead_id,ALUCode_id,
ALUSrcB_id,Branch_id,
Imm_id,RsData_id,RtData_id,
RtAddr_id,RdAddr_id,RsAddr_id,
shamt_id
);
input clk;
input reset;
input[31:0] inst_id;//IF给的指令
 
//WB级的输入
input RegWrite_wb;
input[4:0] RegWriteAddr_wb;
input[31:0] RegWriteData_wb;
 
//八个信号输出
output RegWrite_id;
output RegDst_id;
output MemRead_id;
output MemWrite_id;
output ALUSrcB_id;
output Branch_id;
output [1:0]MemtoReg_id;
output[3:0] ALUCode_id;
 
//其他输出
output[31:0] Imm_id;//符号拓展
output[31:0] RsData_id;//寄存器堆输出1
output[31:0] RtData_id;//寄存器堆输出2
output[4:0] RtAddr_id;//rt
output[4:0] RdAddr_id;//rd
output[4:0] RsAddr_id;//rd
output[4:0] shamt_id;

assign RsAddr_id=inst_id[25:21];//rs
assign RtAddr_id=inst_id[20:16];//rt
assign RdAddr_id=inst_id[15:11];//rd
assign Imm_id={{16{inst_id[15]}},inst_id[15:0]};//符号扩展成32位立即数
assign shamt_id=inst_id[10:6];
 
/*控制模块*/  //要改的接口的很多，遂放弃使用原有的maincontrol和alucontrol
CtrlUnit CtrlUnit(
//输入
.inst(inst_id),
//输出
.RegWrite(RegWrite_id),.RegDst(RegDst_id),
.Branch(Branch_id),.MemRead(MemRead_id),.MemWrite(MemWrite_id),
.ALUCode(ALUCode_id),.ALUSrc_B(ALUSrcB_id),
.MemtoReg(MemtoReg_id)
);
 
/*寄存器堆模块*/
RegFile regfile(
    //输入，由WB级来提供
    .R_Addr_A(RsAddr_id),
    .R_Addr_B(RtAddr_id),
    .Clk(clk),//这里原文档写了!clkin因为仿真的时候需要一半时间读一半时间写.因为我们需要一个setup时间，因此要在后半周期写
    .Clr(reset),
    .W_Addr(RegWriteAddr_wb),
    .W_Data(RegWriteData_wb),
    .Write_Reg(RegWrite_wb),
    //输出
    .R_Data_A(RsData_id),
    .R_Data_B(RtData_id),
    .jr()
    );
 

 
endmodule
