----------------------------------------------------------------------------------
-- Company: ENSEA
-- Engineer: 
-- 
-- Create Date: 02.02.2017 22:18:49
-- Design Name: 
-- Module Name: gestionChrono - Behavioral
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

entity Alarme is
    Port ( CLK : in STD_LOGIC;
           B_ON, B_OFF, capteur1, capteur2, capteur3 : in STD_LOGIC;
           LEDS : out STD_LOGIC_VECTOR (71 downto 0);
           SIGNAL_SONORE : out STD_LOGIC;
           LA_SIGNAL_SONORE : out STD_LOGIC;
           B_SORTIE2 : out STD_LOGIC;
           B_SORTIE : out STD_LOGIC);
end Alarme;

architecture Behavioral of Alarme is
		type liste_etat is (ETEINT, ATTENTE, MARCHE, DETECTION1, DETECTION2, DETECTION3, DETECTION4, DETECTION5, DETECTION6, DETECTION7);
		signal ETAT_PR,ETAT_FU : liste_etat:=ETEINT;
		--autres signaux
begin
-- bloc de synchronisation de letat present
	process(CLK)begin
		if rising_edge(CLK) then
			ETAT_PR <= ETAT_FU;
      end if;
	end process;
-- COMBINATOIRES: calcul de letat futur
	process (ETAT_PR, B_ON, B_OFF, capteur1, capteur2, capteur3) begin
		case ETAT_PR is
		      when ETEINT =>
                   if B_ON='1' then
                          ETAT_FU <= ATTENTE;
                   else 
                          ETAT_FU <= ETEINT;
                   end if;
              when ATTENTE =>
                   if B_ON='1' then
                          ETAT_FU <= MARCHE;
                   elsif B_OFF='1' then
                          ETAT_FU <= ETEINT;
                   else 
                          ETAT_FU <= ATTENTE;
                   end if;
              when MARCHE =>
                   if B_OFF='1' then
                          ETAT_FU <= ATTENTE;
                   elsif capteur1='1' then
                          ETAT_FU <= DETECTION1;
                   elsif capteur2='1' then
                          ETAT_FU <= DETECTION2;
                   elsif capteur3='1' then
                          ETAT_FU <= DETECTION3;
                   else 
                          ETAT_FU <= MARCHE;
                   end if;
               when DETECTION1 =>
                   if B_OFF='1' then
                          ETAT_FU <= ATTENTE;
                   elsif capteur2='1' then
                          ETAT_FU <= DETECTION4;
                   elsif capteur3='1' then
                          ETAT_FU <= DETECTION5;
                   else 
                          ETAT_FU <= DETECTION1;
                   end if;
               when DETECTION2 =>
                   if B_OFF='1' then
                          ETAT_FU <= ATTENTE;
                   elsif capteur1='1' then
                          ETAT_FU <= DETECTION4;
                   elsif capteur3='1' then
                          ETAT_FU <= DETECTION6;
                   else 
                          ETAT_FU <= DETECTION2;
                   end if;
               when DETECTION3 =>
                   if B_OFF='1' then
                          ETAT_FU <= ATTENTE;
                   elsif capteur1='1' then
                          ETAT_FU <= DETECTION5;
                   elsif capteur2='1' then
                          ETAT_FU <= DETECTION6;
                   else 
                          ETAT_FU <= DETECTION3;
                   end if;
               when DETECTION4 =>
                   if B_OFF='1' then
                          ETAT_FU <= ATTENTE;
                   elsif capteur3='1' then
                          ETAT_FU <= DETECTION7;
                   else 
                          ETAT_FU <= DETECTION4;
                   end if;
               when DETECTION5 =>
                   if B_OFF='1' then
                          ETAT_FU <= ATTENTE;
                   elsif capteur2='1' then
                          ETAT_FU <= DETECTION7;
                   else 
                          ETAT_FU <= DETECTION5;
                   end if;
               when DETECTION6 =>
                   if B_OFF='1' then
                          ETAT_FU <= ATTENTE;
                   elsif capteur1='1' then
                          ETAT_FU <= DETECTION7;
                   else 
                          ETAT_FU <= DETECTION6;
                   end if;
                when DETECTION7 =>
                   if B_OFF='1' then
                          ETAT_FU <= ATTENTE;
                   else 
                          ETAT_FU <= DETECTION7;
                   end if;
                when others =>
                   ETAT_FU <= ETEINT;
		end case;
	end process;	
-- le codage des sorties
    SIGNAL_SONORE <= '1' when (ETAT_PR=MARCHE and capteur1='1') OR (ETAT_PR=MARCHE and capteur2='1') OR (ETAT_PR=MARCHE and capteur3='1') else '0';
    LA_SIGNAL_SONORE <= '1' when (ETAT_PR=ETEINT and B_ON='1') or (ETAT_PR=MARCHE and capteur1='1') OR (ETAT_PR=MARCHE and capteur2='1') OR (ETAT_PR=MARCHE and capteur3='1') OR (ETAT_PR=DETECTION1 and B_ON='1') OR (ETAT_PR=DETECTION2 and B_ON='1') OR (ETAT_PR=DETECTION3 and B_ON='1') OR (ETAT_PR=DETECTION4 and B_ON='1') OR (ETAT_PR=DETECTION5 and B_ON='1') OR (ETAT_PR=DETECTION6 and B_ON='1') OR (ETAT_PR=DETECTION7 and B_ON='1') else '0';
    B_SORTIE <= '1' when (ETAT_PR=ETEINT and B_ON='1') else '0';
    B_SORTIE2 <= '1' when (ETAT_PR=ATTENTE and B_OFF='1') else '0';
    LEDS <= "000000000000000001000000000000000000000001000000000000000000000001000000" when ETAT_PR=ATTENTE else "010000000000000000000000010000000000000000000000010000000000000000000000" when ETAT_PR=MARCHE else "000000000100000000000000010000000000000000000000010000000000000000000000" when ETAT_PR=DETECTION1 else "010000000000000000000000000000000100000000000000010000000000000000000000" when ETAT_PR=DETECTION2 else "010000000000000000000000010000000000000000000000000000000100000000000000" when ETAT_PR=DETECTION3 else "000000000100000000000000000000000100000000000000010000000000000000000000" when ETAT_PR=DETECTION4 else "000000000100000000000000010000000000000000000000000000000100000000000000" when ETAT_PR=DETECTION5 else "010000000000000000000000000000000100000000000000000000000100000000000000" when ETAT_PR=DETECTION6 else "000000000100000000000000000000000100000000000000000000000100000000000000" when ETAT_PR=DETECTION7 else "000000000000000000000000000000000000000000000000000000000000000000000000" when ETAT_PR=ETEINT else CONV_STD_LOGIC_VECTOR(0,72);

    
end Behavioral;