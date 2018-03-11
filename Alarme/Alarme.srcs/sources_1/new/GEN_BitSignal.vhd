----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2017 18:18:59
-- Design Name: 
-- Module Name: GEN_BitSignal - Behavioral
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

entity GEN_BitSignal is
    Port ( N : in STD_LOGIC_VECTOR (5 downto 0);
           valBit : in STD_LOGIC;
           heldLow : in STD_LOGIC;
           NPsignal : out STD_LOGIC);
end GEN_BitSignal;

architecture Behavioral of GEN_BitSignal is
    signal tempSignal: std_logic;
begin
    tempSignal<= '1' when (N > 0 and N < conv_std_logic_vector(41,6) and valBit = '1') or
                          (N > 0 and N < conv_std_logic_vector(21,6) and valBit = '0')
                     else
                 '0';
    NPsignal <= '0' when heldLow= '1' else tempSignal;

end Behavioral;
