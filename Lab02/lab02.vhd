
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity lab02 is
    Port ( E : in  STD_LOGIC;
           A : in  STD_LOGIC_VECTOR (1 downto 0);
           D : out  STD_LOGIC_VECTOR (3 downto 0));
end lab02;

architecture Behavioral of lab02 is

begin
process(A,E)
	begin
		if E='1' then D <= "1111";
		else if A="11" then D<="1110";
		elsif   A="10" then D<="1101";
		elsif   A="01" then D<="1011";
		elsif   A="00" then D<="0111";
		else D<="1111";
		end if;
	end if;
end process;
		end Behavioral;

