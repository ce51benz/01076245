Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity COUNT_MIN0_59 is
	port(CLKM:in STD_LOGIC;
		  TRIGMINOUT:out STD_LOGIC;
		  M1,M2:out STD_LOGIC_VECTOR(3 downto 0));
end COUNT_MIN0_59;

architecture Behaviorual of COUNT_MIN0_59 is
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
	signal M1T,M2T:STD_LOGIC_VECTOR(3 downto 0):="0000";
begin
		--COUNTMIN0-59		
		COUNTMIN2: COUNT10UP PORT MAP(CLKM,'0',M2T);
		COUNTMIN1: COUNT6UP PORT MAP(M2T(3),'0',M1T(2 downto 0));
		M1<=M1T;
		M2<=M2T;
	   TRIGMINOUT <= M1T(2);
end Behaviorual;