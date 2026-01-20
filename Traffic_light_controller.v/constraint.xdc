
//CLOCK (100 MHz)

set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk -period 10.00 -waveform {0 5} [get_ports clk]


// RESET BUTTON (CPU_RESET)

set_property PACKAGE_PIN U9 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]


//TRAFFIC LIGHT LEDs

/ GREEN LED (LED0)
set_property PACKAGE_PIN T8 [get_ports g_led]
set_property IOSTANDARD LVCMOS33 [get_ports g_led]

/YELLOW LED (LED1)
set_property PACKAGE_PIN V9 [get_ports y_led]
set_property IOSTANDARD LVCMOS33 [get_ports y_led]

/ RED LED (LED2)
set_property PACKAGE_PIN R8 [get_ports r_led]
set_property IOSTANDARD LVCMOS33 [get_ports r_led]


// 7-SEGMENT DISPLAY (COMMON ANODE, ACTIVE LOW)
// seg[0]=a, seg[1]=b, seg[2]=c, seg[3]=d,
// seg[4]=e, seg[5]=f, seg[6]=g, seg[7]=dp

set_property PACKAGE_PIN L3 [get_ports {seg[0]}]   ;
set_property PACKAGE_PIN N1 [get_ports {seg[1]}]   ;
set_property PACKAGE_PIN L5 [get_ports {seg[2]}]   ;
set_property PACKAGE_PIN L4 [get_ports {seg[3]}]   ;
set_property PACKAGE_PIN K3 [get_ports {seg[4]}]   ;
set_property PACKAGE_PIN M2 [get_ports {seg[5]}]   ;
set_property PACKAGE_PIN L6 [get_ports {seg[6]}]   ;
set_property PACKAGE_PIN M4 [get_ports {seg[7]}]   ;

set_property IOSTANDARD LVCMOS33 [get_ports seg[*]]


// 7-SEGMENT ANODES (ACTIVE LOW)

set_property PACKAGE_PIN N6 [get_ports {an[0]}]    ;
set_property PACKAGE_PIN M6 [get_ports {an[1]}]    ;
set_property PACKAGE_PIN M3 [get_ports {an[2]}]    ;
set_property PACKAGE_PIN N5 [get_ports {an[3]}]    ;
set_property PACKAGE_PIN N2 [get_ports {an[4]}]    ;
set_property PACKAGE_PIN N4 [get_ports {an[5]}]    ;
set_property PACKAGE_PIN L1 [get_ports {an[6]}]    ;
set_property PACKAGE_PIN M1 [get_ports {an[7]}]    ;

set_property IOSTANDARD LVCMOS33 [get_ports an[*]]
