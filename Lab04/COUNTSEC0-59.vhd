Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity COUNT_SEC0_59 is
	port(CLK,H,M:in STD_LOGIC;
		  TRIGSECOUT:out STD_LOGIC);
end COUNT_SEC0_59;

architecture Behaviorual of COUNT_SEC0_59 is
	COMPONENT COUNT10UP
	PORT(
		CLK : IN std_logic;
		CLR : IN std_logic;          
		Q : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
		
	COMPONENT COUNT6UP
	PORT(
		CLK : IN std_logic;
		CLR : IN std_logic;          
		Q : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	signal CLRSEC:STD_LOGIC;
	signal S2,S1:STD_LOGIC_VECTOR(3 downto 0):="0000";
begin
		CLRSEC <= H or M;
		--COUNTSEC0-59
		COUNTSEC2: COUNT10UP PORT MAP(CLK,CLRSEC,S2);
		COUNTSEC1: COUNT6UP PORT MAP(S2(3),CLRSEC,S1(2 downto 0));
	   TRIGSECOUT <= S1(2);	
end Behaviorual; 