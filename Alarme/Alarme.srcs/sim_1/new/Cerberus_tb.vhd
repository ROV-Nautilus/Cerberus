----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2017 20:58:36
-- Design Name: 
-- Module Name: Cerberus_tb - Behavioral
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

entity Cerberus_tb is
--  Port ( );
end Cerberus_tb;

architecture Behavioral of Cerberus_tb is

component Cerberus
Port ( B_ON : in STD_LOGIC;
           B_OFF : in STD_LOGIC;
           CLK : in STD_LOGIC;
           capteur1 : in STD_LOGIC;
           capteur2 : in STD_LOGIC;
           capteur3 : in STD_LOGIC;
           NPsignal : out STD_LOGIC;
           HP : out STD_LOGIC);
end component;

signal B_ON, B_OFF, CLK, capteur1, capteur2, capteur3, NPsignal, HP : STD_LOGIC;
constant CLK_period : time := 10 ns;

begin

UUT : Cerberus
    port map (B_ON => B_ON, B_OFF => B_OFF, NPsignal => NPsignal, CLK => CLK, capteur1 => capteur1, capteur2 => capteur2, capteur3 => capteur3, HP => HP);

CLK_process : process
begin
    CLK <= '0';
    wait for CLK_period/2;
    CLK <= '1';
    wait for CLK_period/2
    ;    
end process;


stimulis : process
begin    
    B_ON <= '0';
    wait for 5 us;
    B_ON <= '1';
    wait for 5 us;
    B_ON <= '0';
    wait for 800us;
end process;

stimulisa : process
begin    
    B_OFF <= '0';
    wait for 200us;
    wait for 150us;
    B_OFF <= '1';
    wait for 5 us;
    B_OFF <= '0';
    wait for 400us;
end process;

stimulisb : process
begin    
    capteur1 <= '0';
    capteur2 <= '0';
    capteur3 <= '0';
    wait for 400us;
end process;



end Behavioral;
