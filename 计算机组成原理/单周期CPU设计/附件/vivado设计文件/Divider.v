
module Divider (
  input wire clk,
  input wire reset,
  output wire divided_clk
);

  parameter DIV_FACTOR = 32'd100_000; // ��Ƶϵ����д����ʱ��100_000_000
  reg [31:0] count;
  reg div_clk;
initial //��һ����ʵ��clkһֱ�ֲ���Ƶ������Ϊ�����ļ�û��reset��Ȼ��div_clk��countû�г�ʼ����ԭ��
    begin
        div_clk<=0;
        count<=0;
    end
always @(posedge clk or posedge reset) begin
    if (reset)
      count <= 0;
    else if (count == DIV_FACTOR - 1)
      begin
        count <= 0;
        div_clk <= ~div_clk;
      end
    else
      count <= count + 1;
  end

  assign divided_clk = div_clk;

endmodule
