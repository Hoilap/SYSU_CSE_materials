`timescale 1ns / 1ps
//增加lb,lh,sb,sh指令需要改动Dram设计
module Data_RAM2 (clk,dataout,datain,addr,we,re);
       parameter data_width=32;
       parameter addr_width=32;
       input [data_width-1:0] datain;
       input [addr_width-1:0] addr;//按字节编址
       input clk,we,re;
       output wire [data_width-1:0] dataout;
       reg [data_width-1:0] ram[0:addr_width-1];//按字编址
       integer i;       
       
       //assign dataout=ram[addr[6:2]]; 
       assign dataout=re?ram[addr[6:2]]:32'bxxxxx;
//       always @(negedge clk ) 
//               begin
//                   if(re) dataout<=ram[addr[6:2]]; 
//                   else dataout<=32'bx;
//              end
              
              
       always @(negedge clk ) 
       //always @(*) 
        begin
            //if(re) dataout<=ram[addr[6:2]]; 
            //如果这样写，lw指令的memreaddata无法写入regfile[9]，为什么:因为数据来的时候控制信号都是jal的了
            if(we) ram[addr[6:2]]<=datain;
       end
       initial begin
               for(i=0;i<32;i=i+1) ram[i]=i+32'h100;
               //$readmemh("memory.list", ram);
       end
endmodule
