module IF_ID_Reg(
	clk, reset,PC_add_4_in, Instruct_in,PC_add_4_out,Instruct_out,stall,flush);
//input	
input clk;
input reset;
input [31:0] PC_add_4_in;
input [31:0] Instruct_in;
input  stall;
input  flush;
//output
output reg [31:0] PC_add_4_out=32'b0;
output reg [31:0] Instruct_out=32'b0;

reg [31:0]  Instruct_out_pre=32'b0;
reg [31:0]  PC_add_4_pre=32'b0;
//wire [31:0] bubble;
//assign bubble=32'b0;
always @(posedge clk or negedge reset) begin///////////��Ϊ�½��أ���stall��
	if (reset || flush) 
        begin
        Instruct_out <= 32'h0000_0000;
        PC_add_4_out <= 32'h0000_0000;
        Instruct_out_pre<=32'h0000_0000;
        PC_add_4_pre <=32'h0000_0000;
        end
        
	else if(stall==1)//stallʱ�Ĵ������ݱ��ֲ��䣬ʹ��ID�ڽ�������������Ȼ�������ָ��
        begin
               Instruct_out<= Instruct_out_pre;
               PC_add_4_out <= PC_add_4_pre;
         end
     else
         begin
                Instruct_out<= Instruct_in;
                Instruct_out_pre<=Instruct_in;
                PC_add_4_out <= PC_add_4_in;
                PC_add_4_pre <=PC_add_4_in;
         end
       
end

endmodule
