
module Divider (
  input wire clk,
  input wire reset,
  output wire divided_clk
);

  parameter DIV_FACTOR = 32'd100_000; // 分频系数，写板子时用100_000_000
  reg [31:0] count;
  reg div_clk;
initial //第一次做实验clk一直分不了频，是因为仿真文件没有reset，然后div_clk和count没有初始化的原因
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
