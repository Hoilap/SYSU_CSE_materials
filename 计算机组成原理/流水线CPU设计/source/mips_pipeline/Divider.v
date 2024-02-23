
module Divider (
  input wire clk,
  input wire reset,
  output wire divided_clk
);

  parameter DIV_FACTOR = 32'd100_000_000; // 分频系数，写板子时用100_000_000
  reg [31:0] count=32'b0;
  reg div_clk=1'b0;
  //在使用Verilog进行开发时，有的reg型变量需要赋初值。initial不可综合
initial //第一次做实验clk一直分不了频，是因为仿真文件没有reset，然后div_clk和count没有初始化的原因
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
        div_clk <= ~div_clk;//变量置位和复位都有相同的优先级Register div_clk_reg in module Divider is has both Set and reset with same priority. 
      end
    else
      count <= count + 1;
  end

  assign divided_clk = div_clk;

endmodule
