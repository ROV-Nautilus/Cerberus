----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2017 20:54:53
-- Design Name: 
-- Module Name: TEMPO_50us - Behavioral
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

entity TEMPO_50us is
    Port ( launch : in STD_LOGIC;
           CLK : in STD_LOGIC;
           pulse50us : out STD_LOGIC);
end TEMPO_50us;

architecture Behavioral of TEMPO_50us is

signal CLR1 : STD_LOGIC;
signal EN1 : STD_LOGIC;
signal Q1 : STD_LOGIC_VECTOR(11 downto 0);
signal EOC1 : STD_LOGIC;

begin

Commande_Compteur : entity work.Commande_Compteur port map(launch => launch, EOC => EOC1, CLK => CLK, CLR => CLR1, EN => EN1);

Compteur : entity work.Compteur generic map(N => 2500) port map(CLK => CLK, EN => EN1, CLR => CLR1, Q => Q1);

Detection_FIN : entity work.Detection_FIN generic map(N => 2500) port map(Q => Q1, EOC => EOC1);

pulse50us <= '1' when EN1 = '1' else '0';

end Behavioral;
