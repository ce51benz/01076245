Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab03 is
	port(C:in STD_LOGIC;
		  Y:out STD_LOGIC_VECTOR(6 downto 0);
		  COM:out STD_LOGIC
		  );
end lab03;

architecture behavirual of lab03 is
component COUNT10UP
port(CLK:in STD_LOGIC;
	  N:out STD_LOGIC_VECTOR(3 downto 0));
end component;
	signal A:STD_LOGIC_VECTOR(3 downto 0);
	begin
	IC1:COUNT10UP
	port map(C,A);
	Y<="1101111" when A="1001" else
	   "1111111" when A="1000" else
		"0000111" when A="0111" else
		"1111101" when A="0110" else
		"1101101" when A="0101" else
		"1100110" when A="0100" else
		"1001111" when A="0011" else
		"1011011" when A="0010" else
		"0000110" when A="0001" else
		"0111111";
	COM<='0';
end behavirual;