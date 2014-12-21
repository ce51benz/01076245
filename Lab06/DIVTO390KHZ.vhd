Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity DIVCLKTO390KHZ is
	port(MCLK:in STD_LOGIC;
	     CLK390KHZ:out STD_LOGIC);
end DIVCLKTO390KHZ;

architecture Behaviorual of DIVCLKTO390KHZ is
	signal DIV64COUNT:integer range 0 to 32:=0;
	signal CLK390KHZT:STD_LOGIC:='0';
begin
	--Create 390.625KHz Frequency
		process(MCLK)
		begin
				if MCLK'event and MCLK='1' then
					if DIV64COUNT=31 then DIV64COUNT<=0;CLK390KHZT<=not CLK390KHZT;
					else DIV64COUNT <= DIV64COUNT + 1;
					end if;
				end if;
		end process;
		CLK390KHZ <= CLK390KHZT;
end architecture;