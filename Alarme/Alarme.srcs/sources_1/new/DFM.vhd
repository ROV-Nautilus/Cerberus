----------------------------------------------------------------------------------
-- Company: ENSEA
-- Engineer: 
-- 
-- Create Date: 28.12.2016 09:16:12
-- Design Name: 
-- Module Name: DFM - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DFM is
    Port ( CLK : in STD_LOGIC;
           Btn : in STD_LOGIC;
           Niveau : out STD_LOGIC;
           Detect : out STD_LOGIC);
end DFM;

architecture Behavioral of DFM is
    signal BtnCurr,BtnPrev : STD_LOGIC:= '0';
    signal Q,D : STD_LOGIC_VECTOR(1 downto 0):= "00";
    signal EF,EP : STD_LOGIC:= '0';
begin 
  
    process(CLK) begin
        if RISING_EDGE (CLK)then 
                BtnCurr <= Btn;
                BtnPrev <= BtnCurr;
        end if;
    end process;
    
    D(1) <= (NOT(Q(1)) and NOT(Q(0))) and(BtnCurr and NOT(BtnPrev));
    D(0) <= (Q(1) and NOT(Q(0)))  or ((NOT(Q(1)) and Q(0)) and (BtnCurr or BtnPrev));
    
    process(CLK) begin
        if RISING_EDGE (CLK)then
            Q(1) <= D(1);
            Q(0) <= D(0);         
        end if;
    end process;
    
    EF <= EP XOR Q(1);
    process(CLK) begin
        if RISING_EDGE (CLK)then
            EP <= EF;
        end if;
    end process;
    
    Detect <= Q(1);
    Niveau <= EP;

end Behavioral;