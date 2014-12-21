Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity COMMON_DECODER is
	port(SEL:in STD_LOGIC_VECTOR(1 downto 0);
	     COM:out STD_LOGIC_VECTOR(3 downto 0));
end COMMON_DECODER;

architecture Behaviorual of COMMON_DECODER is
begin
	--2 TO 4 COMMON OUT DECODER
		with SEL select
				COM<="1110" when "00",
                 "1101" when "01",
					  "1011" when "10",
					  "0111" when others;
end architecture;