----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2017 17:48:27
-- Design Name: 
-- Module Name: CMPT_1toNmax - Behavioral
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
use ieee.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CMPT_1toNmax is
    Port ( CLK : in STD_LOGIC;
           CLR : in STD_LOGIC;
           EN : in STD_LOGIC;
           N : out STD_LOGIC_VECTOR (5 downto 0);
           nextBit : out STD_LOGIC);
end CMPT_1toNmax;

architecture Behavioral of CMPT_1toNmax is
        signal tmp: std_logic_vector(5 downto 0):=(OTHERS => '0');
begin
        process (CLK)begin
            if (CLK'event and CLK='1') then
                if (CLR='1') then
                    tmp <= (OTHERS => '0');
                elsif (EN='1' and tmp = conv_std_logic_vector(61,6)) then
                    tmp <= conv_std_logic_vector(1,6);
                elsif (EN='1') then
                    tmp <= tmp + 1;
                else
                    tmp <= tmp;
                end if;
            end if;
        end process;
        nextBit <= '1' when (tmp = conv_std_logic_vector(61,6) and EN = '1') else
        '0';
        N<=tmp;
        
end Behavioral; 