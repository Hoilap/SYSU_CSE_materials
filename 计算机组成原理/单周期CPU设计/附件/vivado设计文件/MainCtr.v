module MainControl(
input [5:0] opCode, output reg regDst, output reg aluSrc, output reg memToReg, output reg regWrite, 
output reg memRead, output reg memWrite, 
output reg branch,  output reg nebranch,
output reg ExtOp, //符号扩展方式，1 为 sign-extend，0 为 zero-extend
output reg[3:0] aluop, // 经过 ALU 控制译码决定 ALU 功能
output reg jmp,
output reg jal,
output reg [1:0] ls_flag
);

always@(opCode) begin
// 操作码改变时改变控制信号
case(opCode) 6'b000010: begin
regDst = 0;  aluSrc = 0; memToReg = 0;ls_flag=2'bx;
regWrite = 0; memRead = 0; memWrite = 0; branch = 0;nebranch=0; aluop = 4'b0000; jmp = 1; ExtOp = 1;  jal=0;
end // 'J 型' 指令操作码: 000010，无需 ALU

6'b000011: begin
regDst = 0;  aluSrc = 0; memToReg = 0;ls_flag=2'bx;
regWrite = 1; //sb错误卡了很久
memRead = 0; memWrite = 1; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 1; ExtOp = 1;  jal=1;
end //在实验书的基础上新增指令// JAL

6'b000000: begin
regDst = 1;  aluSrc = 0; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b1111; jmp = 0; ExtOp = 1;   jal=0;
end // 'R 型' 指令操作码: 000000(包括jr)

//'I'型指令操作码
6'b100011: begin
regDst = 0;  aluSrc = 1; memToReg = 1; ls_flag = 2'b11;
regWrite = 1; memRead = 1; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 1;  jal=0;
end // 'lw' 指令操作码: 100011
6'b100000: begin
regDst = 0;  aluSrc = 1; memToReg = 1;ls_flag = 2'b01;
regWrite = 1; memRead = 1; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 1;  jal=0;
end // 'lb' 指令操作码: b100000
6'b100001: begin
regDst = 0;  aluSrc = 1; memToReg = 1;ls_flag = 2'b00;
regWrite = 1; memRead = 1; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 1;  jal=0;
end // 'lh' 指令操作码: b100001

6'b101011: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'b11;
regWrite = 0; memRead = 0; memWrite = 1; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 1;  jal=0;
end // 'sw' 指令操作码: 101011
6'b101000: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'b01;
regWrite = 0; memRead = 0; memWrite = 1; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 1;  jal=0;
end // 'sb' 指令操作码: 101000
6'b101001: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'b00;
regWrite = 0; memRead = 0; memWrite = 1; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 1;  jal=0;
end // 'sh' 指令操作码: 101001


6'b000100: begin
regDst = 0;  aluSrc = 0; memToReg = 0;ls_flag=2'bx;
regWrite = 0; memRead = 0; memWrite = 0; branch = 1; nebranch=0;aluop = 4'b0001; jmp = 0; ExtOp = 1;  jal=0;
end // 'beq' 指令操作码: 000100

6'b000101: begin
regDst = 0;  aluSrc = 0; memToReg = 0;ls_flag=2'bx;
regWrite = 0; memRead = 0; memWrite = 0; branch = 0; nebranch=1;aluop = 4'b0110; jmp = 0; ExtOp = 1;  jal=0;
end // 'bne' 指令操作码: 000101

6'b001000: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0;
branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0;  jal=0;
ExtOp = 1;
end // 'addi' 指令操作码: 001000

6'b001100: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b1010; jmp = 0; ExtOp = 0;//位运算不进行符号位拓展
jal=0;
end // 'andi' 指令操作码: 001100

6'b001101: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b0010; jmp = 0; ExtOp = 0;
jal=0;
end // 'ori' 指令操作码: 001101

6'b001110: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b1100; jmp = 0; ExtOp = 0;
  jal=0;
end // 'xori' 指令操作码: 001110
 
6'b001100: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b1010; jmp = 0; ExtOp = 0;
  jal=0;
end // 'andi' 指令操作码: 001100 
 
6'b001010: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b0011; jmp = 0; ExtOp = 1;
jal=0;
end // 'slti' 指令操作码: 001010

6'b001111: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b1011; jmp = 0; ExtOp = 1;
jal=0;
end // 'lui' 指令操作码: 001111



6'b001000: begin
regDst = 0;  aluSrc = 1; memToReg = 0;
regWrite = 1; memRead = 0; memWrite = 0;ls_flag=2'bx;
branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0;
ExtOp = 0;
jal=0;
end //在实验书的基础上新增指令// 'addiu' 指令操作码: 001000

//在实验书的基础上新增指令


default: begin
regDst = 0;  aluSrc = 0; memToReg = 0;ls_flag=2'bx;
regWrite = 0; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 0;jal=0;
end // 默认设置
endcase end
endmodule
