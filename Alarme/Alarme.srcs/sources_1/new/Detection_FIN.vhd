----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2017 21:05:15
-- Design Name: 
-- Module Name: Detection_FIN - Behavioral
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

entity Detection_FIN is
    generic (N: integer := 2500);
    Port ( Q : in STD_LOGIC_VECTOR (11 downto 0);
           EOC : out STD_LOGIC);
end Detection_FIN;

architecture Behavioral of Detection_FIN is

begin

EOC <= '1' when Q = CONV_STD_LOGIC_VECTOR(N-1,12) else '0';

end Behavioral;
