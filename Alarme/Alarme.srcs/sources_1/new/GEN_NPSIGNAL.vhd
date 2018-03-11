----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2017 20:14:55
-- Design Name: 
-- Module Name: GEN_NPSIGNAL - Behavioral
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

entity GEN_NPSIGNAL is
    Port ( CLK : in STD_LOGIC;
           start : in STD_LOGIC;
           bitToSend : in STD_LOGIC;
           EOS : in STD_LOGIC;
           nextBit : out STD_LOGIC;
           nextOctet : out STD_LOGIC;
           nextPixel : out STD_LOGIC;
           nextSequence : out STD_LOGIC;
           nextLeds : out STD_LOGIC;
           NPsignal : out STD_LOGIC);
end GEN_NPSIGNAL;

architecture Behavioral of GEN_NPSIGNAL is

signal valBit : STD_LOGIC;
signal nextBit1 : STD_LOGIC;
signal nextOctet1 : STD_LOGIC;
signal nextSequence1 : STD_LOGIC;
signal N1 : STD_LOGIC_VECTOR (5 downto 0);
signal CLR, GO : STD_LOGIC;
signal CE1 : STD_LOGIC;
signal CE2 : STD_LOGIC;

begin

CE1 <= '1' when (start = '1' or nextBit1 = '1') else '0';

Attente1Front : entity work.Attente_1_front port map(CLK => CLK, CE_IN => CE1, CE_OUT => CE2);

FDE : entity work.FDE port map(CLK => CLK, D => bitToSend, CE => CE2, Q => valBit);

TEMPO_50us : entity work.TEMPO_50us port map(CLK => CLK, launch => EOS, pulse50us => nextSequence1);

GEST_gen : entity work.GEST_gen port map(CLK => CLK, EOS => EOS, start => start, CLR => CLR, GO => GO);

CMPT_1toNmax : entity work.CMPT_1toNmax port map(CLK => CLK, CLR => CLR, EN => GO, N => N1, nextBit => nextBit1);

GEN_Bitsignal : entity work.GEN_Bitsignal port map(valBit => valBit, N => N1, heldLow => nextSequence1, NPsignal => NPsignal);

CMPT1 : entity work.CMPT1 port map(CLK => CLK, CLR => CLR, EN => nextBit1, Cout => nextOctet1);

CMPT2 : entity work.CMPT2 port map(CLK => CLK, CLR => CLR, EN => nextOctet1, Cout => nextPixel);

CMPT3 : entity work.CMPT3 port map(CLK => CLK, CLR => CLR, EN => nextOctet1, Cout => nextLeds);

nextSequence <= nextSequence1;

nextBit <= nextBit1;

nextOctet <= nextOctet1;

end Behavioral;
