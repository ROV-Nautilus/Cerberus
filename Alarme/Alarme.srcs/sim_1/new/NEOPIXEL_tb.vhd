----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.03.2017 16:38:22
-- Design Name: 
-- Module Name: NEOPIXEL_tb - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NEOPIXEL_tb is
--  Port ( );
end NEOPIXEL_tb;

architecture Behavioral of NEOPIXEL_tb is

component NEOPIXEL
Port ( B_ON : in STD_LOGIC;
       LEDS : in STD_LOGIC_VECTOR (71 downto 0);
       NPsignal : out STD_LOGIC;
       CLK : in STD_LOGIC);
end component;

signal B_ON, NPsignal,CLK : STD_LOGIC;
signal LEDS : STD_LOGIC_VECTOR (71 downto 0);
constant CLK_period : time := 10 ns;

begin

UUT : NEOPIXEL
    port map (B_ON => B_ON, LEDS => LEDS, NPsignal => NPsignal, CLK => CLK);

CLK_process : process
begin
    CLK <= '0';
    wait for CLK_period;
    CLK <= '1';
    wait for CLK_period;    
end process;

stimulis : process
begin    
    B_ON <= '0';
    wait for 5 us;
    B_ON <= '1';
    wait for 400us;
end process;

stimulisa : process
begin
    LEDS <= CONV_STD_LOGIC_VECTOR(0,72);
    wait for 1 us;
    LEDS <= "111111110000000000000000000000001111111100000000000000000000000011111111";
    wait for 400us;
end process;

end Behavioral;
