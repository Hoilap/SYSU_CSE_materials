module MainControl(
input [5:0] opCode, output reg regDst, output reg aluSrc, output reg memToReg, output reg regWrite, 
output reg memRead, output reg memWrite, 
output reg branch,  output reg nebranch,
output reg ExtOp, //������չ��ʽ��1 Ϊ sign-extend��0 Ϊ zero-extend
output reg[3:0] aluop, // ���� ALU ����������� ALU ����
output reg jmp,
output reg jal,
output reg [1:0] ls_flag
);

always@(opCode) begin
// ������ı�ʱ�ı�����ź�
case(opCode) 6'b000010: begin
regDst = 0;  aluSrc = 0; memToReg = 0;ls_flag=2'bx;
regWrite = 0; memRead = 0; memWrite = 0; branch = 0;nebranch=0; aluop = 4'b0000; jmp = 1; ExtOp = 1;  jal=0;
end // 'J ��' ָ�������: 000010������ ALU

6'b000011: begin
regDst = 0;  aluSrc = 0; memToReg = 0;ls_flag=2'bx;
regWrite = 1; //sb�����˺ܾ�
memRead = 0; memWrite = 1; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 1; ExtOp = 1;  jal=1;
end //��ʵ����Ļ���������ָ��// JAL

6'b000000: begin
regDst = 1;  aluSrc = 0; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b1111; jmp = 0; ExtOp = 1;   jal=0;
end // 'R ��' ָ�������: 000000(����jr)

//'I'��ָ�������
6'b100011: begin
regDst = 0;  aluSrc = 1; memToReg = 1; ls_flag = 2'b11;
regWrite = 1; memRead = 1; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 1;  jal=0;
end // 'lw' ָ�������: 100011
6'b100000: begin
regDst = 0;  aluSrc = 1; memToReg = 1;ls_flag = 2'b01;
regWrite = 1; memRead = 1; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 1;  jal=0;
end // 'lb' ָ�������: b100000
6'b100001: begin
regDst = 0;  aluSrc = 1; memToReg = 1;ls_flag = 2'b00;
regWrite = 1; memRead = 1; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 1;  jal=0;
end // 'lh' ָ�������: b100001

6'b101011: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'b11;
regWrite = 0; memRead = 0; memWrite = 1; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 1;  jal=0;
end // 'sw' ָ�������: 101011
6'b101000: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'b01;
regWrite = 0; memRead = 0; memWrite = 1; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 1;  jal=0;
end // 'sb' ָ�������: 101000
6'b101001: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'b00;
regWrite = 0; memRead = 0; memWrite = 1; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 1;  jal=0;
end // 'sh' ָ�������: 101001


6'b000100: begin
regDst = 0;  aluSrc = 0; memToReg = 0;ls_flag=2'bx;
regWrite = 0; memRead = 0; memWrite = 0; branch = 1; nebranch=0;aluop = 4'b0001; jmp = 0; ExtOp = 1;  jal=0;
end // 'beq' ָ�������: 000100

6'b000101: begin
regDst = 0;  aluSrc = 0; memToReg = 0;ls_flag=2'bx;
regWrite = 0; memRead = 0; memWrite = 0; branch = 0; nebranch=1;aluop = 4'b0110; jmp = 0; ExtOp = 1;  jal=0;
end // 'bne' ָ�������: 000101

6'b001000: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0;
branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0;  jal=0;
ExtOp = 1;
end // 'addi' ָ�������: 001000

6'b001100: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b1010; jmp = 0; ExtOp = 0;//λ���㲻���з���λ��չ
jal=0;
end // 'andi' ָ�������: 001100

6'b001101: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b0010; jmp = 0; ExtOp = 0;
jal=0;
end // 'ori' ָ�������: 001101

6'b001110: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b1100; jmp = 0; ExtOp = 0;
  jal=0;
end // 'xori' ָ�������: 001110
 
6'b001100: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b1010; jmp = 0; ExtOp = 0;
  jal=0;
end // 'andi' ָ�������: 001100 
 
6'b001010: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b0011; jmp = 0; ExtOp = 1;
jal=0;
end // 'slti' ָ�������: 001010

6'b001111: begin
regDst = 0;  aluSrc = 1; memToReg = 0;ls_flag=2'bx;
regWrite = 1; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b1011; jmp = 0; ExtOp = 1;
jal=0;
end // 'lui' ָ�������: 001111



6'b001000: begin
regDst = 0;  aluSrc = 1; memToReg = 0;
regWrite = 1; memRead = 0; memWrite = 0;ls_flag=2'bx;
branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0;
ExtOp = 0;
jal=0;
end //��ʵ����Ļ���������ָ��// 'addiu' ָ�������: 001000

//��ʵ����Ļ���������ָ��


default: begin
regDst = 0;  aluSrc = 0; memToReg = 0;ls_flag=2'bx;
regWrite = 0; memRead = 0; memWrite = 0; branch = 0; nebranch=0;aluop = 4'b0000; jmp = 0; ExtOp = 0;jal=0;
end // Ĭ������
endcase end
endmodule
