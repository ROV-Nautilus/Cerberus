----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2016 11:07:07
-- Design Name: 
-- Module Name: TICK_1ms - Behavioral
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

entity CLK_50Hz is
    Port ( CLK : in STD_LOGIC;
           Tick : out STD_LOGIC;
           EN : in STD_LOGIC);
end CLK_50Hz;

architecture Behavioral of CLK_50Hz is
    signal Q : STD_LOGIC_VECTOR(16 downto 0);
    constant Ndiv: integer := 1;
begin
process (CLK)
    begin
    if (CLK'event and CLK='1') then
        if (Q < conv_std_logic_vector(Ndiv,17)) then
            Q <= Q+1;
        else
            Q <= conv_std_logic_vector(0,17);
        end if;
    end if;
end process;
Tick <= '1' when Q = conv_std_logic_vector(0,17) and EN = '1' else '0';

end Behavioral;
