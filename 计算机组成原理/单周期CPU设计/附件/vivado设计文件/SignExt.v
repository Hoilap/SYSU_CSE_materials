`timescale 1ns / 1ps
module SignExt(
    input [15:0] inst, // 输入16位立即数
    input  ExtOp,      //是否进行符号位拓展
    output [31:0] data // 输出32位
);
// 根据符号补充符号位
//如果符号位为1，则补充16个1，即16'h ffff
//如果符号位为0，则补充16个0
assign data= inst[15:15]&ExtOp?{16'hffff,inst}:{16'h0000,inst}; 
endmodule
