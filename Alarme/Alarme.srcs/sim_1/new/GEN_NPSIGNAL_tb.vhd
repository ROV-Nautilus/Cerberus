----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2017 21:19:08
-- Design Name: 
-- Module Name: GEN_NPSIGNAL_tb - Behavioral
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

entity GEN_NPSIGNAL_tb is
    --  Port ( );
end GEN_NPSIGNAL_tb;

architecture Behavioral of GEN_NPSIGNAL_tb is

component GEN_NPSIGNAL
Port ( start : in STD_LOGIC;
           CLK : in STD_LOGIC;
           bitToSend : in STD_LOGIC;
           EOS : in STD_LOGIC;
           nextBit : out STD_LOGIC;
           nextOctet : out STD_LOGIC;
           nextSequence : out STD_LOGIC;
           nextPixel : out STD_LOGIC;
           NPsignal : out STD_LOGIC);
end component;

signal start, CLK, bitToSend, EOS, nextBit, nextOctet, nextSequence, nextPixel, NPsignal : STD_LOGIC;
constant CLK_period : time := 10 ns;
    
begin

UUT : GEN_NPSIGNAL
    port map (CLK => CLK, start => start, bitToSend => bitToSend, EOS => EOS, nextBit => nextBit, nextOctet => nextOctet, nextPixel => nextPixel, nextSequence => nextSequence, NPsignal => NPsignal);

CLK_process : process
begin
    CLK <= '0';
    wait for CLK_period;
    CLK <= '1';
    wait for CLK_period;    
end process;

stimulis : process
begin    
    EOS <= '0';
    wait for 5 us;
    wait for 10 us;
    EOS <= '1';
    wait for 100us;
end process;

stimulisb : process
begin
    start <= '0';
    wait for 5 us;
    start <= '1';
    wait for 20 ns;
    start <= '0';
    wait for 100 us;
end process;

stimulisa : process
begin
    bitToSend <= '0';
    wait for 5 us;
    bitToSend <= '1';
    wait for 1250ns;
    bitToSend <= '1';
    wait for 1250ns;
    bitToSend <= '1';
    wait for 1250ns;
    bitToSend <= '1';
    wait for 1250ns;
    bitToSend <= '1';
    wait for 1250ns;
    bitToSend <= '1';
    wait for 1250ns;
    bitToSend <= '1';
    wait for 1250ns;
    bitToSend <= '1';
    wait for 1250ns;
    bitToSend <= '1';
    wait for 50us;
end process;


end Behavioral;
