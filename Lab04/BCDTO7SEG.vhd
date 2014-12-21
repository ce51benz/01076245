Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity BCDTO7SEG is
	port(NUMOUT:in STD_LOGIC_VECTOR(3 downto 0);
	     Y:out STD_LOGIC_VECTOR(6 downto 0));
end BCDTO7SEG;

architecture Behaviorual of BCDTO7SEG is
begin
	with NUMOUT select
				Y <= "1101111" when "1001",
					  "1111111" when "1000",
					  "0000111" when "0111",
					  "1111101" when "0110",
					  "1101101" when "0101",
					  "1100110" when "0100",
					  "1001111" when "0011",
					  "1011011" when "0010",
					  "0000110" when "0001",
					  "0111111" when others;
end architecture;