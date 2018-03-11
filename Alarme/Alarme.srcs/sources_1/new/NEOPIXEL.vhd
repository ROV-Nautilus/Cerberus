----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.03.2017 16:24:08
-- Design Name: 
-- Module Name: NEOPIXEL - Behavioral
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

entity NEOPIXEL is
    Port ( B_ON : in STD_LOGIC;
           B_OFF: in STD_LOGIC;
           LEDS : in STD_LOGIC_VECTOR (71 downto 0);
           NPsignal : out STD_LOGIC;
           B_OFF_FIN : out STD_LOGIC;
           CLK : in STD_LOGIC);
end NEOPIXEL;

architecture Behavioral of NEOPIXEL is

signal nextBit, nextOctet, nextPixel, nextLeds, nextLeds1, nextSequence, bitToSend, start, EOS, CLR: STD_LOGIC;

begin

LEDS1 : entity work.LEDS port map(CLK => CLK, CLR => CLR, B_ON => B_ON, B_OFF => B_OFF,B_OFF_FIN => B_OFF_FIN, LEDS => LEDS, nextBit => nextBit, nextOctet => nextOctet, nextPixel => nextPixel, nextSequence => nextSequence, bitToSend => bitToSend, start => start, EOS => EOS, nextLeds => nextLeds1);

CMPT4 : entity work.CMPT4 port map(CLK => CLK, CLR => CLR, EN => nextLeds, Q => nextLeds1);

GENERATION_NPSIGNAL : entity work.GEN_NPSIGNAL port map(CLK => CLK, nextBit => nextBit, nextOctet => nextOctet, nextPixel => nextPixel, nextSequence => nextSequence, bitToSend => bitToSend, start => start, EOS => EOS, NPsignal => NPsignal, nextLeds => nextLeds);

end Behavioral;
