module Forward_Unit (
  input wire clk,              // 时钟信号
  input wire reset,            // 复位信号
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
    
      // 控制信号：数据转发方式
      // ForwardA, strategy here same as the textbook 
      if(EX_MEM_RegWrite && EX_MEM_RegRd != 5'h00 && EX_MEM_RegRd == ID_EX_RegRs )
      // || (ID_EX_memwrite && EX_MEM_RegRd != 5'h00 && EX_MEM_RegRd == ID_EX_RegR ))
            begin ForwardA = 2'b10;end
            //对于load-use冒险(MEM_WB_memread==1)，要MEM_WB_RegRt 和  ID_EX_RegRs比较
            //对于sw指令，应该EXE/MEM.rd与ID//EX.rt比较,也不对，旁路是吧上一条指令的运算结果拉到alu之前
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