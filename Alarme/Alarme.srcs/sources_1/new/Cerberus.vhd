----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2017 10:47:19
-- Design Name: 
-- Module Name: Cerberus - Behavioral
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

entity Cerberus is
    Port ( B_ON : in STD_LOGIC;
           B_OFF : in STD_LOGIC;
           CLK : in STD_LOGIC;
           capteur1 : in STD_LOGIC;
           capteur2 : in STD_LOGIC;
           capteur3 : in STD_LOGIC;
           NPsignal : out STD_LOGIC;
           HP : out STD_LOGIC);
end Cerberus;

architecture Behavioral of Cerberus is

signal CLK_50Hz : STD_LOGIC;
signal LEDS : STD_LOGIC_VECTOR (71 downto 0);
signal SIGNAL_SONORE : STD_LOGIC;
signal LA_SIGNAL_SONORE : STD_LOGIC;
signal B_SORTIE, B_SORTIE2, B_OFF2 : STD_LOGIC;
signal B_ON1, B_OFF1, B_OFF_FIN : STD_LOGIC;
signal CE : STD_LOGIC;
signal capteur11 : STD_LOGIC;

begin

Bouton_ON : entity work.DFM port map(CLK => CLK_50Hz, Btn => B_ON, Detect => B_ON1);

Bouton_OFF : entity work.DFM port map(CLK => CLK_50Hz, Btn => B_OFF, Detect => B_OFF1);

Attente : entity work.attente port map(CLK => CLK_50Hz, EN => capteur1, Sortie => capteur11);

CLK1 : entity work.CLK_50Hz port map(CLK => CLK, TICK => CLK_50Hz, EN => '1');

Alarme1 : entity work.Alarme port map(CLK => CLK_50Hz, B_ON => B_ON1, B_OFF => B_OFF1, capteur1 => capteur11, capteur2 => capteur2, capteur3 => capteur3, LEDS => LEDS, B_SORTIE => B_SORTIE, B_SORTIE2 => B_SORTIE2, SIGNAL_SONORE => SIGNAL_SONORE, LA_SIGNAL_SONORE => LA_SIGNAL_SONORE);

NEOPIXEL1 : entity work.NEOPIXEL port map(CLK => CLK_50Hz, B_ON => B_SORTIE, B_OFF => B_OFF2, B_OFF_FIN => B_OFF_FIN, LEDS => LEDS, NPsignal => NPsignal);

FDE1 : entity work.FDE port map(CLK => CLK_50Hz, D => SIGNAL_SONORE, CE => LA_SIGNAL_SONORE, Q => HP);

FDE2 : entity work.FDE2 port map(CLK => CLK_50Hz, CE => CE, D => B_SORTIE2, Q => B_OFF2);

CE <= '1' when B_OFF1= '1' or B_OFF_FIN = '1' else '0';

end Behavioral;
