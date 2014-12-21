
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity JKFF is
    Port ( J,K,C,CLR : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end JKFF;

architecture Behavioral of JKFF is
	signal JK:STD_LOGIC_VECTOR(1 downto 0);
begin
	JK<= J&K;
	process(CLR,JK)
	variable QT:STD_LOGIC;
	begin
		if JK="00" then QT :=QT;
		elsif CLR='1' then QT:='0';
		elsif(C'event and C='0') then
			if JK="11" then QT :=not QT;
			elsif JK="10" then QT :='1';
			elsif JK="01" then QT :='0';
			
			end if;
		end if;
		Q<=QT;
		end process;
end Behavioral;