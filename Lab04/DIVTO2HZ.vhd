Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity DIVCLKTO2HZ is
	port(MCLK:in STD_LOGIC;
	     CLK2HZ:out STD_LOGIC);
end DIVCLKTO2HZ;

architecture Behaviorual of DIVCLKTO2HZ is
	signal DIV625MCOUNT:integer range 0 to 6250000:=0;
	signal CLK2HZT:STD_LOGIC:='0';
begin
	--Create 2Hz Frequency
		process(MCLK)
		begin
				if MCLK'event and MCLK='1' then
					if DIV625MCOUNT=6250000 then DIV625MCOUNT<=1;CLK2HZT<=not CLK2HZT;
					else DIV625MCOUNT <= DIV625MCOUNT + 1;
					end if;
				end if;
		end process;
	CLK2HZ<=CLK2HZT;
end architecture;