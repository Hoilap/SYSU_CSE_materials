module IF(CPUCLK,reset,rom_clk,
branch_confirm,
stall,branch_addr,
PC_add_4,
inst_from_rom,
PC
);
input CPUCLK;
input rom_clk;
input reset;
//Ҫ����next_pc��������
input branch_confirm;//Branch
input stall;
input[31:0] branch_addr;


output wire [31:0]  PC_add_4;//PC+4,���ڼ���beqָ����ת��ַ
output wire [31:0]  inst_from_rom;//��ROM�ж���ָ��
//output wire [31:0] inst_stall;
output reg [31:0] PC = 32'b0;//û��stall������µ�PCֵ
//output reg [31:0] PC_stall;

//PC�Ĵ���
//initial PC=0;
always@(posedge CPUCLK or posedge reset)///Ϊ��branch��Ϊ�½��ش���
   begin
           if(reset) PC=32'h00000000;
           else if(PC==32'h00000088)  PC=32'h00000000;
           else if(branch_confirm==1'b1) PC=branch_addr;
           else if(stall==1) PC=PC;
           else PC=PC+4;
   end     

assign   PC_add_4=PC+32'd4;

//����ָ��洢��  PCֻ����9λ����Ϊom�������128��ָrom�ܴ��128��32λ���ݣ�ÿ������ռ4���ֽڣ������Ҫ128*4����ַ������ַ��ַ��->һ��9����ַ��
//PCÿһ�μ���4//addraֻ��7λ����Ϊ�����128��ֻ��7����ַ�ߣ�Ins_Rom�ĵ�ַÿһ��ֻ��Ҫ��1��������ǽ��м�7λ����ȥ

Ins_ROM IM ( .clka(rom_clk), .addra(PC[8:2]), .douta(inst_from_rom) 
//.ena(1'b1)
);//�ǵ�Ҫ��eable��

//��������
//wire [31:0] bubble;
//assign bubble = 32'b0; // assign bubble to zero
//MUX32_2_1 inst_mux(
//           .A(inst_from_rom),
//           .B(bubble),
//           .Sel(stall),
//           .O(inst_stall)
//           );
//MUX32_2_1 pc_mux(
//           .A(PC),
//           .B(PC-4),
//           .Sel(stall),
//           .O(PC_stall)
//           );

endmodule