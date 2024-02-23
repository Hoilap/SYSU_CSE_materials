`timescale 1ns / 1ps
//可以运行
module ALU(clk,AluOp,A,B,F,ZF,CF,OF,SF,PF,step);
    parameter SIZE = 32;//运算位数
        input [3:0] AluOp;//运算操作
        input [SIZE-1:0] A;//左运算数
        input [SIZE-1:0] B;//右运算数
        input clk;
        input step;
        output [SIZE-1:0] F;//运算结果
        output       ZF, //0标志位, 运算结果为0(全零)则置1, 否则置0
                     CF, //进借位标志位, 取最高位进位C,加法时C=1则CF=1表示有进位,减法时C=0则CF=1表示有借位
                     OF, //溢出标志位，对有符号数运算有意义，溢出则OF=1，否则为0                     
                     SF, //符号标志位，与F的最高位相同
                     PF; //奇偶标志位，F有奇数个1，则PF=1，否则为0    
        //逻辑运算没有进位也没有溢出判断，因此CF==C==初始值==0
       reg [SIZE-1:0] F;//其他的默认为线型
       reg C,ZF,CF,OF,SF,PF;//C为最高位进位

       always@(*)//always模块中的任何一个输入信号或电平发生变化时，该语句下方的模块将被执行
                begin
                    C=0;
                    case(AluOp)
                        4'b0100:begin F=A&B; end        //按位与
                        4'b0101:begin F=A|B; end        //按位或
                        4'b0110:begin F=A^B; end        //按位异或
                        4'b0111:begin F=~(A|B); end     //按位或非
                        4'b1001:begin F=B>>>A; end       //将B右移A位srl 逻辑右移>>>
                        4'b1000:begin F=B<<<A; end       //将B左移A位sll
                        4'b0000:begin {C,F}=A+B; end    //加法,加法的输出有C和F两个
                        4'b0010:begin {C,F}=A-B; end    //减法
                        4'b1010:begin F=A<B; end        //A<B则F=1，否则F=0 slt           
                        4'b0001:begin {C,F}=A+B; end    //addu
                        4'b1100:begin F=B>>A;end //sra
                        default:begin F=B+A;end
                    endcase
                    ZF = F==0;//F全为0，则ZF=1
                    CF = C; //进位借位标志
                    SF = F[SIZE-1];//符号标志,取F的最高位
                    PF = ~^F;//奇偶标志，F有奇数个1，则F=1；偶数个1，则F=0
                    if(AluOp== 4'b0001) OF=0;
                    else OF = (A[SIZE-1]^B[SIZE-1]^F[SIZE-1]^C)&~AluOp[2];// result is a
                  end
            //end
endmodule
