Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity BCDTO7SEG is
	port(NUMOUT:in STD_LOGIC_VECTOR(3 downto 0);
	SEL:in STD_LOGIC_VECTOR(1 downto 0);
		  AS:in STD_LOGIC;
	     Y:out STD_LOGIC_VECTOR(6 downto 0));
end BCDTO7SEG;

architecture Behaviorual of BCDTO7SEG is
		signal TOBCD:STD_LOGIC_VECTOR(6 downto 0);
begin
	with NUMOUT select
				TOBCD <= "1101111" when "1001",
					  "1111111" when "1000",
					  "0000111" when "0111",
					  "1111101" when "0110",
					  "1101101" when "0101",
					  "1100110" when "0100",
					  "1001111" when "0011",
					  "1011011" when "0010",
					  "0000110" when "0001",
					  "0111111" when others;
	
	Y <= TOBCD when SEL = "00" or SEL = "01" else
		  TOBCD when (SEL = "10" or SEL = "11") and (AS = '1') else
	     "0000000";
end architecture;