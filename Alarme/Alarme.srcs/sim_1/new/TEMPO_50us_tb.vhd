----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2017 21:41:38
-- Design Name: 
-- Module Name: TEMPO_50us_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TEMPO_50us_tb is
--  Port ( );
end TEMPO_50us_tb;

architecture Behavioral of TEMPO_50us_tb is

component TEMPO_50us
Port ( launch : in STD_LOGIC;
           CLK : in STD_LOGIC;
           pulse50us : out STD_LOGIC);
end component;

signal launch, pulse50us, CLK : STD_LOGIC;
constant CLK_period : time := 10 ns;

begin

UUT : TEMPO_50us
    port map (CLK => CLK, launch => launch, pulse50us => pulse50us);

CLK_process : process
begin
    CLK <= '0';
    wait for CLK_period;
    CLK <= '1';
    wait for CLK_period;    
end process;

stimulis : process
begin
    launch <= '0';
    wait for 10 us;
    launch <= '1';
    wait for 10 ns;
    launch <= '0';
    wait for 30us;
end process;

end Behavioral;
