module Forward_Unit (
  input wire clk,              // ʱ���ź�
  input wire reset,            // ��λ�ź�
  input wire  EX_MEM_RegWrite,
  input wire  MEM_WB_RegWrite,
  input wire [4:0] ID_EX_RegRt,
  input wire [4:0] ID_EX_RegRs,
  input wire [4:0] EX_MEM_RegRd,
  input wire [4:0] MEM_WB_RegRd,
  output reg [1:0] ForwardA,
  output reg [1:0] ForwardB
);


  //always @(posedge clk or posedge reset) begin
  always @(*) begin
    if (reset) begin
      ForwardA <= 2'b00;
      ForwardB <= 2'b00;
    end else begin
    
      // �����źţ�����ת����ʽ
      // ForwardA, strategy here same as the textbook 
      if(EX_MEM_RegWrite && EX_MEM_RegRd != 5'h00 && EX_MEM_RegRd == ID_EX_RegRs )
      // || (ID_EX_memwrite && EX_MEM_RegRd != 5'h00 && EX_MEM_RegRd == ID_EX_RegR ))
            begin ForwardA = 2'b10;end
            //����load-useð��(MEM_WB_memread==1)��ҪMEM_WB_RegRt ��  ID_EX_RegRs�Ƚ�
            //����swָ�Ӧ��EXE/MEM.rd��ID//EX.rt�Ƚ�,Ҳ���ԣ���·�ǰ���һ��ָ�������������alu֮ǰ
      else if(MEM_WB_RegWrite && MEM_WB_RegRd != 5'h00 && MEM_WB_RegRd == ID_EX_RegRs) 
            begin  ForwardA = 2'b01; end
      else   ForwardA = 2'b00;

      if(EX_MEM_RegWrite && EX_MEM_RegRd != 5'h00 && EX_MEM_RegRd == ID_EX_RegRt) 
            begin ForwardB = 2'b10;end
      else if(MEM_WB_RegWrite && MEM_WB_RegRd != 5'h00 && MEM_WB_RegRd == ID_EX_RegRt) 
            begin  ForwardB = 2'b01; end
      else   ForwardB = 2'b00;
      
      




    end
  end

endmodule