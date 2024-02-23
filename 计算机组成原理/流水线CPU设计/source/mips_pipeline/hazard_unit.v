// hazard_unit module
// input: id_ex_memread, id_ex_rt, if_id_rs, if_id_rt
// output: stall
module Hazard_unit(
    input clk,
    input id_ex_memread, // the memread signal from ID/EX pipeline register//表示是LW指令
    input branch_confirm,
    input [4:0] id_ex_rt, // the rt field from ID/EX pipeline register
    input [4:0] if_id_rs, // the rs field from IF/ID pipeline register
    input [4:0] if_id_rt, // the rt field from IF/ID pipeline register
    
    input if_id_memwrite,
    input [4:0] id_ex_rd,
    //input [4:0] id_ex_rs,
    //input [4:0] id_ex_rt,
    output  reg [1:0]stall,// the stall signal to control the pipeline,01表示阻塞一个周期 IF，11表示阻塞2个周期IF+ID
    output  reg [1:0]flush //
);
    
    // check if there is a load-use hazard
    // a load-use hazard occurs when the current instruction (in IF/ID) uses the result of a load instruction (in ID/EX) as a source operand
    // in this case, we need to stall the pipeline for one cycle, and insert a bubble in the ID stage
    
    
    //assign stall=(id_ex_memread && (id_ex_rt == if_id_rs || id_ex_rt == if_id_rt)) ? 1'b1 : 1'b0;
    //initial stall= 1'b0;
    reg [1:0]stall_req=2'b0;
    reg [1:0]stall_count=2'b0;
    always @(negedge clk) begin  //alures不显示
    //always @(clk) begin  //  always @(*) begin //[DRC LUTLP-1]
    //always @(negedge clk or posedge clk) begin  //[Synth 8-91] ambiguous clock in event control ["D:/Work Place Vivado/project_10.2_pipeline/project_10.2_pipeline.srcs/sources_1/imports/project_10_pipeline_CPU/project_10_pipeline_CPU.srcs/sources_1/new/hazard_unit.v":29]
    //always @(posedge clk) begin  //alures不显示，仿真结果不正确
        if(stall_count<stall_req) begin
                stall_count<=stall_count+1;
                flush <=2'b10;
        end
        else if(stall_count==stall_req && stall_req!=0 )begin
                stall <= 2'b00; // deassert the stall signal
                stall_req<=2'b0;
                stall_count<=2'b0;
                flush <=2'b00;
            end
        else if (id_ex_memread && (id_ex_rt == if_id_rs || id_ex_rt == if_id_rt)) begin
            stall<=2'b11; // assert the stall signal
            stall_req<=2'b10;
            stall_count<=2'b1;
            flush <=2'b10;
        end
        else if (if_id_memwrite && (id_ex_rd == if_id_rs || id_ex_rd == if_id_rt))
            begin
                stall<=2'b11; // assert the stall signal
                stall_req<=2'b10;
                stall_count<=2'b1;
                flush <=2'b10;
            end 
        else if(branch_confirm==1)
            begin
                stall<=2'b00; // assert the stall signal
                stall_req<=2'b0;
                stall_count<=2'b00;
                flush <=2'b11;
            end
        else begin
            stall<=2'b0; // deassert the stall signal
            stall_req<=2'b0;
            stall_count<=2'b0;
            flush<=2'b0;
        end
    end

endmodule
