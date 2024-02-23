module MEM(clk,
            MemRead_mem,MemWrite_mem,
            Branch_mem,alu_zero_mem,
            //add4_mem,Branch_addr_mem,
            alu_res_mem,RtData_mem,
            next_pc_branch_mem,Dout_mem
);
input clk;
//MemRead信号暂时不要了
input MemRead_mem;
input MemWrite_mem;
input Branch_mem;
input alu_zero_mem;
input[31:0]alu_res_mem;
input[31:0] RtData_mem;
//input[31:0] Branch_addr_mem;
//input[31:0]add4_mem;
output next_pc_branch_mem;
output[31:0] Dout_mem;
 
Data_RAM2 DataRAM(
    .clk(clk),//input clka
    .re(MemRead_mem),
    .we(MemWrite_mem),
    .addr(alu_res_mem),//input [31 : 0] addra
    .datain(RtData_mem),//input [31:0] dina
    .dataout(Dout_mem)//output [31:0] douta
);
 
//Next_PC模块,确定跳转信号
//为什么不在IF模块中生成，因为ZF，branch的信号来的时间不一样，会导致错误，因此统一在MEM中生成
assign next_pc_branch_mem=Branch_mem&alu_zero_mem ? 1'b1:1'b0;

endmodule


