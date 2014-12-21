Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity OUTPUT_7SEGMUX is
	port(SEL:in STD_LOGIC_VECTOR(1 downto 0);
		  H1,H2,M1,M2:in STD_LOGIC_VECTOR(3 downto 0);
	     NUMOUT:out STD_LOGIC_VECTOR(3 downto 0));
end OUTPUT_7SEGMUX;

architecture Behaviorual of OUTPUT_7SEGMUX is
begin
	--7 SECMENT OUTPUT SELECTOR
		with SEL select
				NUMOUT<=M2 when "00",
						  M1 when "01",
					     H2 when "10",
					     H1 when others;
end architecture;