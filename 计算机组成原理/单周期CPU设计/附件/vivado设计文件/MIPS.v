`timescale 1ns / 1ps
module MIPS(
    input clk,//clk�ӽ�������top��ʱ��
    //input clk_for_ROM,
    input reset,
    input run,
    input step,
    output wire[31:0]aluRes,
    output wire[31:0]instruction,
    output reg [31:0]PC, 	//PC��ʾrom��ָ���λ��,��ΪpcҪ��always����ڸ�ֵ�����Ϊreg��
    output wire [31:0] next_PC,//������reg,Ԫ�����������������wire
    output wire[31:0] memreaddata,//���ݴ洢��
    output clkin,
    output wire[4:0]regWriteAddr,
    output wire[31:0]regWriteData,
    output wire [31:0] ALUSrcA,
    output wire[31:0] ALUSrcB,
    output wire[31:0] RtData
);
//////��Ƶ����MIPS��
Divider d(.clk(clk),.divided_clk(clkin),.reset(1'b0));



// main control�ź���
wire reg_dst,jmp,branch, memread, memwrite, memtoreg,alu_src,ExtOp,jal,nebranch;
wire[3:0] aluop;
wire regwrite;
wire [1:0] ls_flag;
// ALU���� �ź���
wire[3:0] aluCtr;//����aluop��ָ���6λ ѡ��alu��������
wire [1:0] asel;
wire jr;
// ALU �ź���
wire ZF,OF,CF,PF,SF; //alu����Ϊ���־ 

// ��������
wire[31:0] RsData;
wire[31:0] expand; 
wire[4:0] shamt;
assign shamt=instruction[10:6];
wire CPUCLK;


// ����ָ��洢��  PCֻ����9λ����Ϊom�������128��ָrom�ܴ��128��32λ���ݣ�ÿ������ռ4���ֽڣ������Ҫ128*4����ַ������ַ��ַ��->һ��9����ַ��
//PCÿһ�μ���4
//addraֻ��7λ����Ϊ�����128��ֻ��7����ַ�ߣ�Ins_Rom�ĵ�ַÿһ��ֻ��Ҫ��1��������ǽ��м�7λ����ȥ
Ins_Rom IM ( .clka(clk), .addra(PC[8:2]), .douta(instruction) ,.ena(1'b1));//�ǵ�Ҫ��eable����Ȼ�޷���ָ��

// ʵ����������ģ��
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
    
    
//  ʵ���� ALU ����ģ��
ALUControl aluctr(
    .ALUOp(aluop),
    .funct(instruction[5:0]),
    .ALUCtr(aluCtr),
    .Asel(asel),
    .jr(jr)
    );

// ʵ�����Ĵ���ģ��
RegFile regfile(
    .R_Addr_A(instruction[25:21]),
    .R_Addr_B(instruction[20:16]),
    .Clk(CPUCLK),//����ԭ�ĵ�д��!clkin��Ϊ�����ʱ����Ҫһ��ʱ���һ��ʱ��д.��Ϊ������Ҫһ��setupʱ�䣬���Ҫ�ں������д
    .Clr(reset),
    .W_Addr(regWriteAddr),
    .W_Data(regWriteData),
    .Write_Reg(regwrite),
    .R_Data_A(RsData),
    .R_Data_B(RtData),
    .jr(jr)
    );

//lui alu������ѡ�� 
MUX32_4_1 SrcA(
        .A(RsData),
        .B({27'b0, instruction[10:6]}),//��λָ��
        .C(32'b10000),//luiָ��
        .D(RsData),
        .Sel(asel),
        .O(ALUSrcA)
        );
assign ALUSrcB = alu_src ? expand : RtData; //ALU�ĵڶ������������ԼĴ����������ָ���16λ��������

//ʵ����ALUģ��
ALU alu(
    .clk(CPUCLK),
    .A(ALUSrcA), //д��alu�ĵ�һ������������Rs
    .B(ALUSrcB),
    .AluOp(aluCtr),
    .ZF(ZF),
    .OF(OF),
    .CF(CF),
    .PF(PF),
    .SF(SF),
    .F(aluRes),
    .step(step));
//ʵ����������չģ��
SignExt signext(.inst(instruction[15:0]),.ExtOp(ExtOp), .data(expand));
//ʵ�������ݴ洢��
//Data_RAM2 dm(.clk(clkin), 
//            .we(memwrite),
//            .addr(aluRes), //һ��32λ��ַ�ߣ�����ֻ��lw������λ��λ32λ����Ҫȥ������λ
//            .datain(RtData),
//            .dataout( memreaddata),
//            .re(memread));
Data_RAM dm(.clk(CPUCLK), 
            .we(memwrite),
            .reset(reset),
            .flag(ls_flag),//00-> byte 01->half word  1x->word
            .a(aluRes[7:0]), //һ��8λ��ַ�ߵ�ַ
            .wd(RtData),//д������
            .rd(memreaddata),
            .re(memread)
            );
 
//ʵ����Next_PCģ��
Next_PC nextpc(
    .branch(branch), 
    .nebranch(nebranch),
    .zero(ZF),
    .jmp(jmp),
    .jr(jr),
    .clkin(CPUCLK),//���ʱ��Ҫ�÷���Ƶ��
    .reset(reset),
    .RsData(RsData),
    .expand(expand),
    .instruction(instruction),
    .PC(PC),
    .next_pc(next_PC)
); 
//д�Ĵ���
MUX32_4_1 mux_regWriteAddr(
        .A(instruction[20:16]),
        .B(instruction[15:11]),
        .C(32'd31),
        .D(32'd31),
        .Sel({jal,reg_dst}),
        .O(regWriteAddr)
        );
//д�Ĵ�����Ŀ��Ĵ�������rt��rd��ra//���ָ�ʽ����ѡ�����ĸ�ʽ
MUX32_4_1 mux_regWriteData(
        .A(aluRes),
        .B(memreaddata),
        .C(PC+4),
        .D(PC+4),
        .Sel({jal,memtoreg}),
        .O(regWriteData)
        );
//д��Ĵ�������������ALU�����ݴ洢����PC+4



//PC�Ըı�
//initial PC<=0;
//always @(posedge clkin or posedge reset) begin
//    if (reset) 
//        PC <= 0;    // �ڸ�λʱ��PC����Ϊ0
//    else if (run) 
//        PC <= next_PC;    // ���runΪ1��������ִ��PC=PC+4
//    else if (step)
//        PC <= next_PC;    // ���runΪ0��stepΪ1����ִ��һ��PC=PC+4
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
