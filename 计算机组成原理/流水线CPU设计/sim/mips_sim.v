`timescale 1ns / 1ps
module mips_hazard_sim; 
// Inputs 
reg clk;//clk�ӽ�������top��ʱ��
reg reset;
wire run;
wire step;
wire[31:0]alu_res_ex;
wire[31:0]Ins_if;
wire [31:0]PC_if;//����ʹ��reg������concurrent assignment to a non-net PC is not permitted 
wire [31:0]Dout_mem;
wire CPUCLK;


// Instantiate the Unit Under Test (UUT) 
MIPS_hazard uut ( 
    .clk(clk), 
    //.clk_for_ROM(clk),
    .run(run),
    .step(step),
    .reset(reset) ,
    .alu_res_ex(alu_res_ex),
    .Ins_if(Ins_if),
    .PC_if(PC_if),
    .Dout_mem(Dout_mem),
    .CPUCLK(CPUCLK)
    ); 

//initial 
//    begin 
//        // Initialize Inputs 
//        clk = 0; 
//        reset = 1; 
//        // Wait 100 ns for global reset to finish 
//        #10; 
//        reset = 0; 
//    end 

parameter PERIOD = 1000; 
assign run=1;
always begin 
        #(PERIOD / 2) clk = 1'b1; 
        #(PERIOD / 2) clk = 1'b0; 
    end 

 
integer dout_file;
initial begin
     dout_file= $fopen("C:/Users/DengKaina/Desktop/data.txt","w");  //ע��·��/
     if(dout_file == 0)begin 
                 $display ("can not open the file!");    //�����ļ�ʧ�ܣ���ʾcan not open the file!
                 $stop;
        end
 end
 initial $fwrite(dout_file,"alu_res_ex   Ins_if     PC_if    Dout_mem  \n");
 always @(posedge CPUCLK)    
         $fwrite(dout_file,"%h %h %h %h\n",alu_res_ex,Ins_if,PC_if,Dout_mem);  //data_oΪ��Ҫ������ź�����


endmodule