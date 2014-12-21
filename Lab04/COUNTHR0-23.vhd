Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity COUNT_HR0_23 is
	port(CLKH,EN:in STD_LOGIC;
		  H1,H2:out STD_LOGIC_VECTOR(3 downto 0));
end COUNT_HR0_23;

architecture Behaviorual of COUNT_HR0_23 is
	COMPONENT COUNT10UPEN
	port(CLK,CLR,EN:in STD_LOGIC;
	  Q:OUT STD_LOGIC_VECTOR(3 downto 0));
	end COMPONENT;
	
	COMPONENT COUNT3UP
	PORT(
		CLK : IN std_logic;
		CLR : IN std_logic;		
		Q : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	signal CLRHR:STD_LOGIC;
	signal H1T,H2T:STD_LOGIC_VECTOR(3 downto 0):="0000";
begin
		CLRHR <= (H2T(2) and not H2T(1) and not H2T(0)) and (not H1T(0) and H1T(1));
		COUNTHOUR2: COUNT10UPEN PORT MAP(CLKH,CLRHR,EN,H2T);
		COUNTHOUR1: COUNT3UP PORT MAP(H2T(3),CLRHR,H1T(1 downto 0));
		H1<=H1T;
		H2<=H2T;
end Behaviorual;