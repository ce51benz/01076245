Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity DIVCLKTO1HZ is
	port(MCLK:in STD_LOGIC;
	     CLK1HZ:out STD_LOGIC);
end DIVCLKTO1HZ;

architecture Behaviorual of DIVCLKTO1HZ is
	signal DIV125MCOUNT:integer range 0 to 12500000:=0;
	signal CLK1HZT:STD_LOGIC:='0';
begin
	--Create 1Hz Frequency
		process(MCLK)
		begin
				if MCLK'event and MCLK='1' then
					if DIV125MCOUNT=12500000 then DIV125MCOUNT<=1;CLK1HZT<=not CLK1HZT;
					else DIV125MCOUNT <= DIV125MCOUNT + 1;
					end if;
				end if;
		end process;
	CLK1HZ<=CLK1HZT;
end architecture;