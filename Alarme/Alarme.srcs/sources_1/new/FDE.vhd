----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2017 20:13:15
-- Design Name: 
-- Module Name: FDE - Behavioral
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

entity FDE is
    Port ( D : in STD_LOGIC;
           CE : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Q : out STD_LOGIC);
end FDE;

architecture Behavioral of FDE is

    signal M: STD_LOGIC_VECTOR(0 downto 0):=(OTHERS => '0');
    signal M_futur: STD_LOGIC_VECTOR(0 downto 0):=(OTHERS => '0');

begin

process(CLK)
begin
    if (CLK'event and CLK='1') then
        M(0) <= M_futur(0);
    end if;
end process;

M_futur(0) <= D when CE = '1' else M(0);

Q <= M(0);

end Behavioral;
