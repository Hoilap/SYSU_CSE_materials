
module Divider (
  input wire clk,
  input wire reset,
  output wire divided_clk
);

  parameter DIV_FACTOR = 32'd100_000_000; // ��Ƶϵ����д����ʱ��100_000_000
  reg [31:0] count=32'b0;
  reg div_clk=1'b0;
  //��ʹ��Verilog���п���ʱ���е�reg�ͱ�����Ҫ����ֵ��initial�����ۺ�
initial //��һ����ʵ��clkһֱ�ֲ���Ƶ������Ϊ�����ļ�û��reset��Ȼ��div_clk��countû�г�ʼ����ԭ��
    begin
        div_clk=0;
        count=32'd0;
    end
always @(posedge clk or posedge reset) begin
    if (reset)begin
      count <= 32'd0;
      div_clk <=32'd1;
      end
    else if (count == DIV_FACTOR - 1)
      begin
        count <= 32'd0;
        div_clk <= ~div_clk;//������λ�͸�λ������ͬ�����ȼ�Register div_clk_reg in module Divider is has both Set and reset with same priority. 
      end
    else
      count <= count + 1;
  end

  assign divided_clk = div_clk;

endmodule
