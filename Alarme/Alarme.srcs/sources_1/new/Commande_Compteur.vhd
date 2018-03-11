----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2017 21:15:36
-- Design Name: 
-- Module Name: Commande_Compteur - Behavioral
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

entity Commande_Compteur is
    Port ( launch : in STD_LOGIC;
           EOC : in STD_LOGIC;
           CLK : in STD_LOGIC;
           EN : out STD_LOGIC;
           CLR : out STD_LOGIC);
end Commande_Compteur;

architecture Behavioral of Commande_Compteur is
        type liste_etat is (UN, DEUX);
		signal ETAT_PR,ETAT_FU : liste_etat:=UN;

begin
-- bloc de synchronisation de letat present
	process(CLK)begin
		if rising_edge(CLK) then
			ETAT_PR <= ETAT_FU;
      end if;
	end process;
-- COMBINATOIRES: calcul de letat futur
        process (ETAT_PR, launch, EOC) begin
            case ETAT_PR is
                 when UN =>
                    if launch='1' then
                        ETAT_FU <= DEUX;
                    else 
                        ETAT_FU <= UN;
                    end if;
                 when DEUX =>
                    if EOC='1' then
                        ETAT_FU <= UN;
                    else 
                        ETAT_FU <= DEUX;
                    end if;
                 when others =>
                        ETAT_FU <= UN;
             end case;
         end process;

-- le codage des sorties

        CLR <= '1' when ETAT_PR = UN and launch='1' else '0';
        EN <= '1' when ETAT_PR = DEUX and EOC='0' else '0';

end Behavioral;
