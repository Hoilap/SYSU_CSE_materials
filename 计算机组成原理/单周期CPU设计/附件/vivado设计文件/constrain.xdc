
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports step]
set_property IOSTANDARD LVCMOS33 [get_ports run]

#数据显示选择
set_property IOSTANDARD LVCMOS33 [get_ports {SW[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW[0]}]

#数码管
set_property IOSTANDARD LVCMOS33 [get_ports {sm_duan[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sm_duan[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sm_duan[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sm_duan[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sm_duan[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sm_duan[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sm_duan[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sm_wei[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sm_wei[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sm_wei[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sm_wei[0]}]


set_property PACKAGE_PIN W5 [get_ports clk]
set_property PACKAGE_PIN W19 [get_ports step] 
set_property PACKAGE_PIN T17 [get_ports reset] 
set_property PACKAGE_PIN R2 [get_ports run] 

#数据显示选择
set_property PACKAGE_PIN W16 [get_ports {SW[2]}]
set_property PACKAGE_PIN V16 [get_ports {SW[1]}]
set_property PACKAGE_PIN V17 [get_ports {SW[0]}]

#数码管
set_property PACKAGE_PIN U7 [get_ports {sm_duan[6]}]
set_property PACKAGE_PIN V5 [get_ports {sm_duan[5]}]
set_property PACKAGE_PIN U5 [get_ports {sm_duan[4]}]
set_property PACKAGE_PIN V8 [get_ports {sm_duan[3]}]
set_property PACKAGE_PIN U8 [get_ports {sm_duan[2]}]
set_property PACKAGE_PIN W6 [get_ports {sm_duan[1]}]
set_property PACKAGE_PIN W7 [get_ports {sm_duan[0]}]
set_property PACKAGE_PIN W4 [get_ports {sm_wei[3]}]
set_property PACKAGE_PIN V4 [get_ports {sm_wei[2]}]
set_property PACKAGE_PIN U2 [get_ports {sm_wei[0]}]
set_property PACKAGE_PIN U4 [get_ports {sm_wei[1]}]
