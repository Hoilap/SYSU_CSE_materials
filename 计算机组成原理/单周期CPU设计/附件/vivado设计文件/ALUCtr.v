module ALUControl(
input [3:0] ALUOp, 
input [5:0] funct, 
//output reg regwrite,
output reg [3:0]  ALUCtr,
output reg [1:0]  Asel,
output reg jr
);

always @(ALUOp or funct) //  �����������߹�����仯ִ�в���
casex({ALUOp, funct}) // ƴ�Ӳ�����͹����������һ�����ж�
10'b0000xxxxxx: begin ALUCtr = 4'b0000; Asel=2'b00; jr=1'b0;end // lw��sw��addi 
10'b0001xxxxxx: begin ALUCtr = 4'b0010; Asel=2'b00; jr=1'b0;end // beq
10'b0010xxxxxx: begin ALUCtr = 4'b0101; Asel=2'b00; jr=1'b0;end // ori
10'b0011xxxxxx: begin ALUCtr = 4'b1010; Asel=2'b00; jr=1'b0;end // slti
10'b0110xxxxxx: begin ALUCtr = 4'b0010; Asel=2'b00; jr=1'b0;end // bne
10'b1011xxxxxx: begin ALUCtr = 4'b1000; Asel=2'b10; jr=1'b0;end // lui///////�¼�
10'b1100xxxxxx: begin ALUCtr = 4'b0110; Asel=2'b00; jr=1'b0;end // xori///////�¼�
10'b1010xxxxxx: begin ALUCtr = 4'b0100; Asel=2'b00; jr=1'b0;end // andi///////�¼�


10'b1111100000: begin ALUCtr = 4'b0000; Asel=2'b00; jr=1'b0;end // add 
10'b1111100010: begin ALUCtr = 4'b0010; Asel=2'b00; jr=1'b0;end // sub 
10'b1111xx0100: begin ALUCtr = 4'b0100; Asel=2'b00; jr=1'b0;end // and 
10'b1111100101: begin ALUCtr = 4'b0101; Asel=2'b00; jr=1'b0;end // or 
10'b1111000000: begin ALUCtr = 4'b1000; Asel=2'b01; jr=1'b0;end // sll
10'b1111101010: begin ALUCtr = 4'b1010; Asel=2'b00; jr=1'b0;end // slt
10'b1111100001: begin ALUCtr = 4'b0001; Asel=2'b00; jr=1'b0;end // addu///////�¼�
10'b1111000010: begin ALUCtr = 4'b1001; Asel=2'b01; jr=1'b0;end // srl///////�¼�
10'b1111001000: begin ALUCtr = 4'bxxxx; Asel=2'bxx; jr=1'b1;end // jr///////�¼�
10'b1111000011: begin ALUCtr = 4'b1100; Asel=2'b01; jr=1'b0;end // sra///////�¼�
10'b1111100110: begin ALUCtr = 4'b0110; Asel=2'b00; jr=1'b0;end // xor///////�¼�




default:ALUCtr = 4'b0000;
endcase 


endmodule