`timescale 1ns / 1ps
module Data_RAM (input clk, we,re,
             input reset,
             input [1:0] flag,//00-> byte 01->half word  1x->word
		     input [7:0] a, //地址
		     input [31:0] wd,//写入数据
			 output [31:0] rd);//读出数据
			 

reg [7:0] RAM[255:0]; //8位数据宽度(不是之前写的32位)，深度256位。因此读一个字需要4个地址
//也就是说这个ram只能存64个字

//read
//lb rt, offset(rs)   R[rt] ← SignExt(Mem(R[rs1] + offset, byte))
//lh rt, offset(rs)   R[rt] ← SignExt(Mem(R[rs1] + offset, half))

    assign rd=re? flag[1]? { {RAM[a+3]},{RAM[a+2]},{RAM[a+1]},{RAM[a+0]}} :  
                            ( flag[0]?{ {16{RAM[a+1][7]}} ,{RAM[a+1]},{RAM[a]} }:
                                        { {24{RAM[a][7]}} ,RAM[a]})
                    :{32'hxxxxxxxx};
//assign rd=flag[1]? { {RAM[a+3]},{RAM[a+2]},{RAM[a+1]},{RAM[a+0]}} :  ( flag[0]?{ {16{RAM[a+1][7]}} ,{RAM[a+1]},{RAM[a]} }:{ {24{RAM[a][7]}} ,RAM[a]} );

//write flag作为字节或字半字操作的标志
integer i;
always @ (posedge clk,posedge reset)
begin
    if(reset)
        begin
            for(i=0;i<256;i=i+1) RAM[i]<=i;//和实验书相比赋值符号改为非阻塞型
        end	
    else if (we) begin
        if(flag==2'b00)
            begin
                RAM[a]<=wd[7:0];
            end
        else if(flag==2'b01 )
            begin
                { {RAM[a+1]},{RAM[a]} }<=wd[15:0];
            end
        else if(flag==2'b11)
            begin
                { {RAM[a+3]},{RAM[a+2]},{RAM[a+1]},{RAM[a+0]}}<=wd;
            end           
    end  
end
initial
        begin
               for(i=0;i<256;i=i+1) RAM[i]=i;
       end
endmodule
