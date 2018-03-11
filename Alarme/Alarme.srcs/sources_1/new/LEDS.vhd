----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.03.2017 15:37:50
-- Design Name: 
-- Module Name: LEDS - Behavioral
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

entity LEDS is
    Port ( CLK : in STD_LOGIC;
           B_ON : in STD_LOGIC;
           B_OFF: in STD_LOGIC;
           LEDS : in STD_LOGIC_VECTOR(71 downto 0);
           nextBit : in STD_LOGIC;
           nextOctet : in STD_LOGIC;
           nextPixel : in STD_LOGIC;
           nextSequence : in STD_LOGIC;
           nextLeds : in STD_LOGIC;
           B_OFF_FIN: out STD_LOGIC;
           CLR : out STD_LOGIC;
           start : out STD_LOGIC;
           EOS : out STD_LOGIC;
           bitToSend : out STD_LOGIC);
end LEDS;

architecture Behavioral of LEDS is

        type liste_etat is (REPOS, ATTENTE_COULEUR,VERIF1, VERIF2, VERIF3, B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16, B17, B18, B19, B20, B21, B22, B23, B24, B25, B26, B27, B28, B29, B30, B31, B32, B33, B34, B35, B36, B37, B38, B39, B40, B41, B42, B43, B44, B45, B46, B47, B48, B49, B50, B51, B52, B53, B54, B55, B56, B57, B58, B59, B60, B61, B62, B63, B64, B65, B66, B67, B68, B69, B70, B71, B72, ATTENTE_SEQUENCE);
		signal ETAT_PR,ETAT_FU : liste_etat:=REPOS;
		--autres signaux
begin
-- bloc de synchronisation de letat present
	process(CLK)begin
		if rising_edge(CLK) then
			ETAT_PR <= ETAT_FU;
      end if;
	end process;
	
-- COMBINATOIRES: calcul de letat futur
    process (ETAT_PR, B_ON, LEDS, nextBit, nextOctet, nextPixel, nextSequence, nextLeds) begin
		case ETAT_PR is
		      when REPOS =>
                   if B_ON = '1' then
                          ETAT_FU <= ATTENTE_COULEUR;
                   else 
                          ETAT_FU <= REPOS;
                   end if;
              when ATTENTE_COULEUR =>
                   if (NOT(LEDS = CONV_STD_LOGIC_VECTOR(0,72))) or B_OFF = '1' then
                           ETAT_FU <= B1;
                   else 
                           ETAT_FU <= ATTENTE_COULEUR;
                   end if;
              when B1 =>
                        if nextBit = '1' then
                               ETAT_FU <= B2;
                        else 
                               ETAT_FU <= B1;
                        end if;
                   when B2 =>
                        if nextBit = '1' then
                               ETAT_FU <= B3;
                        else 
                               ETAT_FU <= B2;
                        end if;
                   when B3 =>
                        if nextBit = '1' then
                               ETAT_FU <= B4;
                        else 
                               ETAT_FU <= B3;
                        end if;
                   when B4 =>
                        if nextBit = '1' then
                               ETAT_FU <= B5;
                        else 
                               ETAT_FU <= B4;
                        end if;
                   when B5 =>
                        if nextBit = '1' then
                               ETAT_FU <= B6;
                        else 
                               ETAT_FU <= B5;
                        end if;
                   when B6 =>
                        if nextBit = '1' then
                               ETAT_FU <= B7;
                        else 
                               ETAT_FU <= B6;
                        end if;
                   when B7 =>
                        if nextBit = '1' then
                               ETAT_FU <= B8;
                        else 
                               ETAT_FU <= B7;
                        end if;
                   when B8 =>
                        if nextBit = '1' then
                               ETAT_FU <= B9;
                        else 
                               ETAT_FU <= B8;
                        end if;
                   when B9 =>
                        if nextBit = '1' then
                               ETAT_FU <= B10;
                        else 
                               ETAT_FU <= B9;
                        end if;
                   when B10 =>
                        if nextBit = '1' then
                               ETAT_FU <= B11;
                        else 
                               ETAT_FU <= B10;
                        end if;
                   
                   
                   when B11 =>
                        if nextBit = '1' then
                               ETAT_FU <= B12;
                        else 
                               ETAT_FU <= B11;
                        end if;
                   when B12 =>
                        if nextBit = '1' then
                               ETAT_FU <= B13;
                        else 
                               ETAT_FU <= B12;
                        end if;
                   when B13 =>
                        if nextBit = '1' then
                               ETAT_FU <= B14;
                        else 
                               ETAT_FU <= B13;
                        end if;
                   when B14 =>
                        if nextBit = '1' then
                               ETAT_FU <= B15;
                        else 
                               ETAT_FU <= B14;
                        end if;
                   when B15 =>
                        if nextBit = '1' then
                               ETAT_FU <= B16;
                        else 
                               ETAT_FU <= B15;
                        end if;
                   when B16 =>
                        if nextBit = '1' then
                               ETAT_FU <= B17;
                        else 
                               ETAT_FU <= B16;
                        end if;
                   when B17 =>
                        if nextBit = '1' then
                               ETAT_FU <= B18;
                        else 
                               ETAT_FU <= B17;
                        end if;
                   when B18 =>
                        if nextBit = '1' then
                               ETAT_FU <= B19;
                        else 
                               ETAT_FU <= B18;
                        end if;
                   when B19 =>
                        if nextBit = '1' then
                               ETAT_FU <= B20;
                        else 
                               ETAT_FU <= B19;
                        end if;
                   when B20 =>
                        if nextBit = '1' then
                               ETAT_FU <= B21;
                        else 
                               ETAT_FU <= B20;
                        end if;
                   
                   
                   when B21 =>
                        if nextBit = '1' then
                               ETAT_FU <= B22;
                        else 
                               ETAT_FU <= B21;
                        end if;
                   when B22 =>
                        if nextBit = '1' then
                               ETAT_FU <= B23;
                        else 
                               ETAT_FU <= B22;
                        end if;
                   when B23 =>
                        if nextBit = '1' then
                               ETAT_FU <= B24;
                        else 
                               ETAT_FU <= B23;
                        end if;
                   when B24 =>
                        if nextBit ='1' then
                               ETAT_FU <= VERIF1;
                        else 
                               ETAT_FU <= B24;
                        end if;
                   when VERIF1 =>
                        if nextLeds = '1'then
                               ETAT_FU <= B25;
                        elsif nextLeds ='0' then
                               ETAT_FU <= B1;
                        else 
                               ETAT_FU <= VERIF1;
                        end if;
                   when B25 =>
                        if nextBit = '1' then
                               ETAT_FU <= B26;
                        else 
                               ETAT_FU <= B25;
                        end if;
                   when B26 =>
                        if nextBit = '1' then
                               ETAT_FU <= B27;
                        else 
                               ETAT_FU <= B26;
                        end if;
                   when B27 =>
                        if nextBit = '1' then
                               ETAT_FU <= B28;
                        else 
                               ETAT_FU <= B27;
                        end if;
                   when B28 =>
                        if nextBit = '1' then
                               ETAT_FU <= B29;
                        else 
                               ETAT_FU <= B28;
                        end if;
                   when B29 =>
                        if nextBit = '1' then
                               ETAT_FU <= B30;
                        else 
                               ETAT_FU <= B29;
                        end if;
                   when B30 =>
                        if nextBit = '1' then
                               ETAT_FU <= B31;
                        else 
                               ETAT_FU <= B30;
                        end if;
                   
                   
                   when B31 =>
                        if nextBit = '1' then
                               ETAT_FU <= B32;
                        else 
                               ETAT_FU <= B31;
                        end if;
                   when B32 =>
                        if nextBit = '1' then
                               ETAT_FU <= B33;
                        else 
                               ETAT_FU <= B32;
                        end if;
                   when B33 =>
                        if nextBit = '1' then
                               ETAT_FU <= B34;
                        else 
                               ETAT_FU <= B33;
                        end if;
                   when B34 =>
                        if nextBit = '1' then
                               ETAT_FU <= B35;
                        else 
                               ETAT_FU <= B34;
                        end if;
                   when B35 =>
                        if nextBit = '1' then
                               ETAT_FU <= B36;
                        else 
                               ETAT_FU <= B35;
                        end if;
                   when B36 =>
                        if nextBit = '1' then
                               ETAT_FU <= B37;
                        else 
                               ETAT_FU <= B36;
                        end if;
                   when B37 =>
                        if nextBit = '1' then
                               ETAT_FU <= B38;
                        else 
                               ETAT_FU <= B37;
                        end if;
                   when B38 =>
                        if nextBit = '1' then
                               ETAT_FU <= B39;
                        else 
                               ETAT_FU <= B38;
                        end if;
                   when B39 =>
                        if nextBit = '1' then
                               ETAT_FU <= B40;
                        else 
                               ETAT_FU <= B39;
                        end if;
                   when B40 =>
                        if nextBit = '1' then
                               ETAT_FU <= B41;
                        else 
                               ETAT_FU <= B40;
                        end if;
                   
                   
                   when B41 =>
                        if nextBit = '1' then
                               ETAT_FU <= B42;
                        else 
                               ETAT_FU <= B41;
                        end if;
                   when B42 =>
                        if nextBit = '1' then
                               ETAT_FU <= B43;
                        else 
                               ETAT_FU <= B42;
                        end if;
                   when B43 =>
                        if nextBit = '1' then
                               ETAT_FU <= B44;
                        else 
                               ETAT_FU <= B43;
                        end if;
                   when B44 =>
                        if nextBit = '1' then
                               ETAT_FU <= B45;
                        else 
                               ETAT_FU <= B44;
                        end if;
                   when B45 =>
                        if nextBit = '1' then
                               ETAT_FU <= B46;
                        else 
                               ETAT_FU <= B45;
                        end if;
                   when B46 =>
                        if nextBit = '1' then
                               ETAT_FU <= B47;
                        else 
                               ETAT_FU <= B46;
                        end if;
                   when B47 =>
                        if nextBit = '1' then
                               ETAT_FU <= B48;
                        else 
                               ETAT_FU <= B47;
                        end if;
                   when B48 =>
                        if nextBit = '1' then
                               ETAT_FU <= VERIF2;
                        else 
                               ETAT_FU <= B48;
                        end if;
                   when VERIF2 =>
                        if nextLeds = '1'then
                               ETAT_FU <= B49;
                        elsif nextLeds ='0' then
                               ETAT_FU <= B25;
                        else 
                               ETAT_FU <= VERIF2;
                        end if;
                   when B49 =>
                        if nextBit = '1' then
                               ETAT_FU <= B50;
                        else 
                               ETAT_FU <= B49;
                        end if;
                   when B50 =>
                        if nextBit = '1' then
                               ETAT_FU <= B51;
                        else 
                               ETAT_FU <= B50;
                        end if;
                   
                   
                   when B51 =>
                        if nextBit = '1' then
                               ETAT_FU <= B52;
                        else 
                               ETAT_FU <= B51;
                        end if;
                   when B52 =>
                        if nextBit = '1' then
                               ETAT_FU <= B53;
                        else 
                               ETAT_FU <= B52;
                        end if;
                   when B53 =>
                        if nextBit = '1' then
                               ETAT_FU <= B54;
                        else 
                               ETAT_FU <= B53;
                        end if;
                   when B54 =>
                        if nextBit = '1' then
                               ETAT_FU <= B55;
                        else 
                               ETAT_FU <= B54;
                        end if;
                   when B55 =>
                        if nextBit = '1' then
                               ETAT_FU <= B56;
                        else 
                               ETAT_FU <= B55;
                        end if;
                   when B56 =>
                        if nextBit = '1' then
                               ETAT_FU <= B57;
                        else 
                               ETAT_FU <= B56;
                        end if;
                   when B57 =>
                        if nextBit = '1' then
                               ETAT_FU <= B58;
                        else 
                               ETAT_FU <= B57;
                        end if;
                   when B58 =>
                        if nextBit = '1' then
                               ETAT_FU <= B59;
                        else 
                               ETAT_FU <= B58;
                        end if;
                   when B59 =>
                        if nextBit = '1' then
                               ETAT_FU <= B60;
                        else 
                               ETAT_FU <= B59;
                        end if;
                   when B60 =>
                        if nextBit = '1' then
                               ETAT_FU <= B61;
                        else 
                               ETAT_FU <= B60;
                        end if;
                   
                   
                   when B61 =>
                        if nextBit = '1' then
                               ETAT_FU <= B62;
                        else 
                               ETAT_FU <= B61;
                        end if;
                   when B62 =>
                        if nextBit = '1' then
                               ETAT_FU <= B63;
                        else 
                               ETAT_FU <= B62;
                        end if;
                   when B63 =>
                        if nextBit = '1' then
                               ETAT_FU <= B64;
                        else 
                               ETAT_FU <= B63;
                        end if;
                   when B64 =>
                        if nextBit = '1' then
                               ETAT_FU <= B65;
                        else 
                               ETAT_FU <= B64;
                        end if;
                   when B65 =>
                        if nextBit = '1' then
                               ETAT_FU <= B66;
                        else 
                               ETAT_FU <= B65;
                        end if;
                   when B66 =>
                        if nextBit = '1' then
                               ETAT_FU <= B67;
                        else 
                               ETAT_FU <= B66;
                        end if;
                   when B67 =>
                        if nextBit = '1' then
                               ETAT_FU <= B68;
                        else 
                               ETAT_FU <= B67;
                        end if;
                   when B68 =>
                        if nextBit = '1' then
                               ETAT_FU <= B69;
                        else 
                               ETAT_FU <= B68;
                        end if;
                   when B69 =>
                        if nextBit = '1' then
                               ETAT_FU <= B70;
                        else 
                               ETAT_FU <= B69;
                        end if;
                   when B70 =>
                        if nextBit = '1' then
                               ETAT_FU <= B71;
                        else 
                               ETAT_FU <= B70;
                        end if;
                   
                   
                   when B71 =>
                        if nextBit = '1' then
                               ETAT_FU <= B72;
                        else 
                               ETAT_FU <= B71;
                        end if;
                   
                   when B72 =>
                        if nextBit = '1' then
                               ETAT_FU <= VERIF3;
                        else 
                               ETAT_FU <= B72;
                        end if;
                    when VERIF3 =>
                        if nextLeds = '1'then
                               ETAT_FU <= ATTENTE_SEQUENCE;
                        elsif nextLeds ='0' then
                               ETAT_FU <= B49;
                        else 
                               ETAT_FU <= VERIF3;
                        end if;

              when ATTENTE_SEQUENCE =>
                   if nextSequence = '0' then
                           ETAT_FU <= ATTENTE_COULEUR;
                   else
                           ETAT_FU <= ATTENTE_SEQUENCE;
                   end if;
              when others =>
                          ETAT_FU <= REPOS;
         end case;
    end process;    
    
-- le codage des sorties

bitToSend <= LEDS(71) when ETAT_PR = B1 else LEDS(70) when ETAT_PR = B2 else LEDS(69) when ETAT_PR = B3 else LEDS(68) when ETAT_PR = B4 else LEDS(67) when ETAT_PR = B5 else LEDS(66) when ETAT_PR = B6 else LEDS(65) when ETAT_PR = B7 else LEDS(64) when ETAT_PR = B8 else LEDS(63) when ETAT_PR = B9 else LEDS(62) when ETAT_PR = B10 else LEDS(61) when ETAT_PR = B11 else LEDS(60) when ETAT_PR = B12 else LEDS(59) when ETAT_PR = B13 else LEDS(58) when ETAT_PR = B14 else LEDS(57) when ETAT_PR = B15 else LEDS(56) when ETAT_PR = B16 else LEDS(55) when ETAT_PR = B17 else LEDS(54) when ETAT_PR = B18 else LEDS(53) when ETAT_PR = B19 else LEDS(52) when ETAT_PR = B20 else  LEDS(51) when ETAT_PR = B21 else LEDS(50) when ETAT_PR = B22 else LEDS(49) when ETAT_PR = B23 else LEDS(48) when ETAT_PR = B24 else LEDS(47) when ETAT_PR = B25 else LEDS(46) when ETAT_PR = B26 else LEDS(45) when ETAT_PR = B27 else LEDS(44) when ETAT_PR = B28 else LEDS(43) when ETAT_PR = B29 else LEDS(42) when ETAT_PR = B30 else LEDS(41) when ETAT_PR = B31 else LEDS(40) when ETAT_PR = B32 else LEDS(39) when ETAT_PR = B33 else LEDS(38) when ETAT_PR = B34 else LEDS(37) when ETAT_PR = B35 else LEDS(36) when ETAT_PR = B36 else LEDS(35) when ETAT_PR = B37 else LEDS(34) when ETAT_PR = B38 else LEDS(33) when ETAT_PR = B39 else LEDS(32) when ETAT_PR = B40 else LEDS(31) when ETAT_PR = B41 else LEDS(30) when ETAT_PR = B42 else LEDS(29) when ETAT_PR = B43 else LEDS(28) when ETAT_PR = B44 else LEDS(27) when ETAT_PR = B45 else LEDS(26) when ETAT_PR = B46 else LEDS(25) when ETAT_PR = B47 else LEDS(24) when ETAT_PR = B48 else LEDS(23) when ETAT_PR = B49 else LEDS(22) when ETAT_PR = B50 else LEDS(21) when ETAT_PR = B51 else LEDS(20) when ETAT_PR = B52 else LEDS(19) when ETAT_PR = B53 else LEDS(18) when ETAT_PR = B54 else LEDS(17) when ETAT_PR = B55 else LEDS(16) when ETAT_PR = B56 else LEDS(15) when ETAT_PR = B57 else LEDS(14) when ETAT_PR = B58 else LEDS(13) when ETAT_PR = B59 else LEDS(12) when ETAT_PR = B60 else LEDS(11) when ETAT_PR = B61 else LEDS(10) when ETAT_PR = B62 else LEDS(9) when ETAT_PR = B63 else LEDS(8) when ETAT_PR = B64 else LEDS(7) when ETAT_PR = B65 else LEDS(6) when ETAT_PR = B66 else LEDS(5) when ETAT_PR = B67 else LEDS(4) when ETAT_PR = B68 else LEDS(3) when ETAT_PR = B69 else LEDS(2) when ETAT_PR = B70 else LEDS(1) when ETAT_PR = B71 else LEDS(0) when ETAT_PR = B72 else '0';
EOS <= '1' when ETAT_PR = B72 and nextPixel = '1' else '0';
start <= '1' when (ETAT_PR = ATTENTE_COULEUR and ((NOT(LEDS = CONV_STD_LOGIC_VECTOR(0,72))) or B_OFF = '1')) else '0';
CLR <= '1' when (ETAT_PR = VERIF1 and nextLeds='1') or (ETAT_PR = VERIF2 and nextLeds ='1') or (ETAT_PR = VERIF3 and nextLeds ='1')else '0';
B_OFF_FIN <= '1' when (ETAT_PR=B1) else '0';

end Behavioral;
