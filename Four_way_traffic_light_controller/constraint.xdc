

// CLOCK (100 MHz)

set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk -period 10.00 -waveform {0 5} [get_ports clk]


// RESET BUTTON (CPU_RESET)

set_property PACKAGE_PIN U9 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]


// TRAFFIC LIGHT LEDs (12 LEDs)
// Using LED0 - LED11

set_property PACKAGE_PIN T8  [get_ports NORTH_GREEN_LED]
set_property PACKAGE_PIN V9  [get_ports NORTH_YELLOW_LED]
set_property PACKAGE_PIN R8  [get_ports NORTH_RED_LED]

set_property PACKAGE_PIN T6  [get_ports EAST_GREEN_LED]
set_property PACKAGE_PIN T5  [get_ports EAST_YELLOW_LED]
set_property PACKAGE_PIN T4  [get_ports EAST_RED_LED]

set_property PACKAGE_PIN U7  [get_ports SOUTH_GREEN_LED]
set_property PACKAGE_PIN U6  [get_ports SOUTH_YELLOW_LED]
set_property PACKAGE_PIN V4  [get_ports SOUTH_RED_LED]

set_property PACKAGE_PIN U3  [get_ports WEST_GREEN_LED]
set_property PACKAGE_PIN V1  [get_ports WEST_YELLOW_LED]
set_property PACKAGE_PIN R1  [get_ports WEST_RED_LED]

set_property IOSTANDARD LVCMOS33 [get_ports {
    NORTH_GREEN_LED NORTH_YELLOW_LED NORTH_RED_LED
    EAST_GREEN_LED  EAST_YELLOW_LED  EAST_RED_LED
    SOUTH_GREEN_LED SOUTH_YELLOW_LED SOUTH_RED_LED
    WEST_GREEN_LED  WEST_YELLOW_LED  WEST_RED_LED
}]

// 7-SEGMENT DISPLAY (Common Anode)


// Segment lines (CA-CG + DP)
set_property PACKAGE_PIN L3 [get_ports {seg[0]}]   ;
set_property PACKAGE_PIN N1 [get_ports {seg[1]}]   ;
set_property PACKAGE_PIN L5 [get_ports {seg[2]}]   ;
set_property PACKAGE_PIN L4 [get_ports {seg[3]}]   ;
set_property PACKAGE_PIN K3 [get_ports {seg[4]}]   ;
set_property PACKAGE_PIN M2 [get_ports {seg[5]}]   ;
set_property PACKAGE_PIN L6 [get_ports {seg[6]}]   ;
set_property PACKAGE_PIN M4 [get_ports {seg[7]}]   ;

set_property IOSTANDARD LVCMOS33 [get_ports {seg[*]}]

// Digit enables AN0-AN7
set_property PACKAGE_PIN N6 [get_ports {an[0]}]
set_property PACKAGE_PIN M6 [get_ports {an[1]}]
set_property PACKAGE_PIN M3 [get_ports {an[2]}]
set_property PACKAGE_PIN N5 [get_ports {an[3]}]
set_property PACKAGE_PIN N2 [get_ports {an[4]}]
set_property PACKAGE_PIN N4 [get_ports {an[5]}]
set_property PACKAGE_PIN L1 [get_ports {an[6]}]
set_property PACKAGE_PIN M1 [get_ports {an[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {an[*]}]
