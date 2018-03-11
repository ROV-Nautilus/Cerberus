# Connection: CLK on W5
set_property PACKAGE_PIN W5 [get_ports {CLK}]	
set_property IOSTANDARD LVCMOS33 [get_ports {CLK}]

# Connection: B_ON de Cerbere sur BTNL => W19
set_property PACKAGE_PIN W19 [get_ports {B_ON}]	
set_property IOSTANDARD LVCMOS33 [get_ports {B_ON}]

# Connection: B_OFF de Cerbere sur BTNR => T17
set_property PACKAGE_PIN T17 [get_ports {B_OFF}]	
set_property IOSTANDARD LVCMOS33 [get_ports {B_OFF}]

# Connection: capteur1 de Cerbere sur JB3 => B15
set_property PACKAGE_PIN B15 [get_ports {capteur1}]	
set_property IOSTANDARD LVCMOS33 [get_ports {capteur1}]

# Connection: capteur2 de Cerbere sur SW1 => V16
set_property PACKAGE_PIN V16 [get_ports {capteur2}]	
set_property IOSTANDARD LVCMOS33 [get_ports {capteur2}]

# Connection: capteur3 de Cerbere sur SW2 => W16
set_property PACKAGE_PIN W16 [get_ports {capteur3}]	
set_property IOSTANDARD LVCMOS33 [get_ports {capteur3}]

# Connection: NPsignal de Cerbere sur JB1 => A14
set_property PACKAGE_PIN A14 [get_ports {NPsignal}]	
set_property IOSTANDARD LVCMOS33 [get_ports {NPsignal}]

# Connection: HP de Cerbere sur JB2 => A16
set_property PACKAGE_PIN A16 [get_ports {HP}]	
set_property IOSTANDARD LVCMOS33 [get_ports {HP}]