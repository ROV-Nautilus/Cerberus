----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.01.2017 08:23:42
-- Design Name: 
-- Module Name: Cnt0toN_EN - Behavioral
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

entity attente is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           Sortie : out STD_LOGIC);
end attente;

architecture Behavioral of attente is

signal M: STD_LOGIC_VECTOR(22 downto 0):=(OTHERS => '0');
signal M_futur: STD_LOGIC_VECTOR(22 downto 0):=(OTHERS => '0');
signal CLR: STD_LOGIC;
begin

    -- Bascule D : mise à jour de votre état présent à partir de votre état futur
process(CLK)
begin
    if (CLK'event and CLK='1') then
        M <= M_futur;
    end if;
end process;

    CLR <= NOT(EN);
    -- Calcul de votre état futur; Bloc combinatoire d'entrée 
    M_futur <= CONV_STD_LOGIC_VECTOR(0,23) when CLR='1' or (EN='1' and M = CONV_STD_LOGIC_VECTOR(10000000,23)) else
         M +'1' when EN='1' else
         M;

    -- Calcul de votre sortie; Bloc combinatoire de sortie
    Sortie <= '1' when M=CONV_STD_LOGIC_VECTOR(10000000,23) and EN='1' else '0';
    
end Behavioral;
