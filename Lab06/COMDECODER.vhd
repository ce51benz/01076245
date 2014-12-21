Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity COMMON_DECODER is
	port(SEL:in STD_LOGIC_VECTOR(1 downto 0);
		  AS:in STD_LOGIC;
	     COM:out STD_LOGIC_VECTOR(3 downto 0));
end COMMON_DECODER;

architecture Behaviorual of COMMON_DECODER is
begin
	--2 TO 4 COMMON OUT DECODER
	COM <= "1110" when SEL = "00" else
			 "1101" when SEL = "01" else
			 "1011" when SEL = "10" else
			 "0111" when SEL = "11" and AS = '1' else
			 "1111";
end architecture;