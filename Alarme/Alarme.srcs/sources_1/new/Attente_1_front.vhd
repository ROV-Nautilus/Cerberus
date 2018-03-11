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

entity Attente_1_front is
    Port ( CLK : in STD_LOGIC;
           CE_IN : in STD_LOGIC;
           CE_OUT : out STD_LOGIC);
end Attente_1_front;

architecture Behavioral of Attente_1_front is
		type liste_etat is (UN, DEUX);
		signal ETAT_PR,ETAT_FU : liste_etat:=UN;
		--autres signaux
begin
-- bloc de synchronisation de letat present
	process(CLK)begin
		if rising_edge(CLK) then
			ETAT_PR <= ETAT_FU;
      end if;
	end process;
-- COMBINATOIRES: calcul de letat futur
	process (ETAT_PR, CE_IN) begin
		case ETAT_PR is
		      when UN =>
                   if CE_IN='1' then
                          ETAT_FU <= DEUX;
                   else 
                          ETAT_FU <= UN;
                   end if;
              when DEUX =>
                  ETAT_FU <= UN;
                when others =>
                   ETAT_FU <= UN;
		end case;
	end process;	
-- le codage des sorties
    
    CE_OUT <= '1' when ETAT_PR=DEUX else '0';
    
end Behavioral;