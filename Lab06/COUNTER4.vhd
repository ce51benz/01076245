Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity COUNTER4 is
	port(CLK:in STD_LOGIC;
		  SEL:out STD_LOGIC_VECTOR(1 downto 0));
end COUNTER4;

architecture Behaviorual of COUNTER4 is
	signal SELT:STD_LOGIC_VECTOR(1 downto 0):="00";
	begin
	--Counter4(0-3)------------------------------------
		process(CLK)
		begin
				if CLK'event and CLK = '1' then
					if SELT="11" then SELT <="00";
					else SELT <= SELT + 1;
					end if;
				end if;
		end process;
	SEL <= SELT;
end Behaviorual;