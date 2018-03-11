----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2017 18:37:25
-- Design Name: 
-- Module Name: GEN_BitSignal_tb - Behavioral
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

entity CMPT_1toNmax_tb1 is
    --  Port ( );
end CMPT_1toNmax_tb1;

architecture Behavioral of CMPT_1toNmax_tb1 is

component CMPT_1toNmax
Port ( CLK : in STD_LOGIC;
           CLR : in STD_LOGIC;
           EN : in STD_LOGIC;
           N : out STD_LOGIC_VECTOR (5 downto 0);
           nextBit : out STD_LOGIC);
end component;

signal valBit,heldLow,NPsignal : STD_LOGIC;
signal CLK, EN, CLR, nextBit : STD_LOGIC;
signal N : STD_LOGIC_VECTOR(5 downto 0);
constant CLK_period : time := 10 ns;

begin

UUT : CMPT_1toNmax
    port map (CLK => CLK, EN => EN, CLR => CLR, N => N, nextBit=>nextBit);
    
UUT1 : GEN_BitSignal
    port map (N => N, valBit=>valBit, heldLow=>heldLow, NPsignal=>NPsignal);

CLK_process : process
begin
    CLK <= '0';
    wait for CLK_period/2;
    CLK <= '1';
    wait for CLK_period/2;    
end process;

stimulis : process
begin
    EN <= '1';
    CLR <= '0';
    wait for 1ms;
end process;

end Behavioral;
