`timescale 1ns / 1ps
module mips_sim; 
// Inputs 
reg clk;//clk�ӽ�������top��ʱ��
reg reset;
wire run;
wire step;
wire[31:0]aluRes;
wire[31:0]instruction;
wire[31:0]next_PC;
wire [31:0]PC;//concurrent assignment to a non-net PC is not permitted 
wire [31:0]memreaddata;
wire [31:0] ALUSrcA;
wire[31:0] ALUSrcB;
wire[4:0]regWriteAddr;
wire[31:0]regWriteData;
wire[31:0] RtData;
wire clkin;


// Instantiate the Unit Under Test (UUT) 
MIPS uut ( 
    .clk(clk), 
    //.clk_for_ROM(clk),
    .run(run),
    .step(step),
    .reset(reset) ,
    .aluRes(aluRes),
    .instruction(instruction),
    .PC(PC),
    .clkin(clkin),
    .next_PC(next_PC),
    .memreaddata(memreaddata),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .regWriteAddr(regWriteAddr),
    .regWriteData(regWriteData),
    .RtData(RtData)
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
 initial $fwrite(dout_file,"aluRes(DataROM address)   instruction   PC   next_PC    DataROMreaddata   RtData(DataROMwritedata)    regWriteAddr    regWriteData\n");
 always @(posedge clkin)    
         $fwrite(dout_file,"%24d %h %h %h %d %h %h %h\n", aluRes[31:0],instruction[31:0],PC[31:0],next_PC[31:0],memreaddata[31:0],RtData[31:0],regWriteAddr[4:0],regWriteData[31:0]);  //data_oΪ��Ҫ������ź�����


endmodule