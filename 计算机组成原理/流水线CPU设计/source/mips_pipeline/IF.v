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
//要传入next_pc的数据线
input branch_confirm;//Branch
input stall;
input[31:0] branch_addr;


output wire [31:0]  PC_add_4;//PC+4,用于计算beq指令跳转地址
output wire [31:0]  inst_from_rom;//从ROM中读的指令
//output wire [31:0] inst_stall;
output reg [31:0] PC = 32'b0;//没有stall的情况下的PC值
//output reg [31:0] PC_stall;

//PC寄存器
//initial PC=0;
always@(posedge CPUCLK or posedge reset)///为了branch改为下降沿触发
   begin
           if(reset) PC=32'h00000000;
           else if(PC==32'h00000088)  PC=32'h00000000;
           else if(branch_confirm==1'b1) PC=branch_addr;
           else if(stall==1) PC=PC;
           else PC=PC+4;
   end     

assign   PC_add_4=PC+32'd4;

//例化指令存储器  PC只传了9位，因为om数据深度128是指rom能存放128个32位数据，每个数据占4个字节，因此需要128*4个地址（按地址编址）->一共9条地址线
//PC每一次加了4//addra只有7位（因为深度是128，只有7根地址线）Ins_Rom的地址每一次只需要加1，因此我们将中间7位传进去

Ins_ROM IM ( .clka(rom_clk), .addra(PC[8:2]), .douta(inst_from_rom) 
//.ena(1'b1)
);//记得要传eable，

//增加气泡
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