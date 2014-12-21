library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity MAINCLOCK is
	port(CLK,H,M:STD_LOGIC;
		  Y:out STD_LOGIC_VECTOR(6 downto 0);
		  COM:out STD_LOGIC_VECTOR(3 downto 0);
		  DP:out STD_LOGIC);
end MAINCLOCK;


architecture Behavioral of MAINCLOCK is
	COMPONENT SIMCLOCK
	port(
			CLK,H,M:in STD_LOGIC;
			Y:out STD_LOGIC_VECTOR(6 downto 0);
			COM:out STD_LOGIC_VECTOR(3 downto 0);
			DP:out STD_LOGIC);
			end COMPONENT;
	begin
	C1:SIMCLOCK port map(CLK,H,M,Y,COM,DP);
end architecture;




