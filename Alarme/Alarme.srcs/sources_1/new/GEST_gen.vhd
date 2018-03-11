----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2017 19:47:13
-- Design Name: 
-- Module Name: GEST_gen - Behavioral
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

entity GEST_gen is
    Port ( start : in STD_LOGIC;
           EOS : in STD_LOGIC;
           CLK : in STD_LOGIC;
           CLR : out STD_LOGIC;
           GO : out STD_LOGIC);
end GEST_gen;

architecture Behavioral of GEST_gen is
        type liste_etat is (ENV_CLR, ATT_START, ATT_END);
        signal ETAT_PR,ETAT_FU : liste_etat:=ENV_CLR;

begin

-- bloc de synchronisation de letat present
	process(CLK)begin
		if rising_edge(CLK) then
			ETAT_PR <= ETAT_FU;
      end if;
	end process;

-- COMBINATOIRES: calcul de letat futur
        process (ETAT_PR, start, EOS) begin
            case ETAT_PR is
                 when ENV_CLR =>
                    ETAT_FU <= ATT_START;
                 when ATT_START =>
                    if start = '1' then
                        ETAT_FU <= ATT_END;
                    else
                        ETAT_FU <= ATT_START;
                    end if;
                 when ATT_END =>
                    if EOS = '1' then
                        ETAT_FU <= ENV_CLR;
                    else
                        ETAT_FU <= ATT_END;
                    end if;
                 when others =>
                        ETAT_FU <= ENV_CLR;
            end case;
        end process;
                    
-- le codage des sorties

    CLR <= '1' when ETAT_PR = ENV_CLR else '0';
    GO <= '1' when ETAT_PR = ATT_END or (ETAT_PR = ATT_START and start = '1') else '0';

end Behavioral;
