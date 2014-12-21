library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity DFF is
	port(D,CLR,C:in STD_LOGIC;
		  Q:out STD_LOGIC);
end DFF;


architecture Behaviorual of DFF is
begin
	process(CLR)
	variable QT:STD_LOGIC:='0';
	begin
			if CLR = '1' then QT := '0';
			elsif C'event and C = '1' then
				if D = '1' then QT:= '1';
				else QT:='0';
				end if;
			end if;
	Q<=QT;
	end process;
end Behaviorual;
