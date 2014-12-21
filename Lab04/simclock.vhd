Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SIMCLOCK is
	port(
			CLK,H,M:in STD_LOGIC;
			Y:out STD_LOGIC_VECTOR(6 downto 0);
			COM:out STD_LOGIC_VECTOR(3 downto 0);
			DP:out STD_LOGIC);
			
end entity;

architecture Behavioral of SIMCLOCK is
		
		signal M1,M2,H1,H2,S2,S1,COMT:STD_LOGIC_VECTOR(3 downto 0):="0000";
		signal CLK1HZ,CLK2HZ,CLKM,CLKH,CLRSEC,CLKDIV64HZ,CLRHR,EN:STD_LOGIC:='0';
		signal SEL:STD_LOGIC_VECTOR(1 downto 0):="00";
		signal HM:STD_LOGIC_VECTOR(1 downto 0);
	
	COMPONENT COUNT_TIME
	port(CLK1,CLK2,H,M:in STD_LOGIC;
		  H1,H2,M1,M2:out STD_LOGIC_VECTOR(3 downto 0));
	end COMPONENT;
	
	
	COMPONENT DP_CONTROLLER
		port(CLK,H,M:in STD_LOGIC;
			  COM:in STD_LOGIC_VECTOR(3 downto 0);
		     DP:out STD_LOGIC);
	END COMPONENT;
	
	
	COMPONENT SEVENSEG_CONTROLLER
	port(SEL:in STD_LOGIC_VECTOR(1 downto 0);
		  H1,H2,M1,M2:in STD_LOGIC_VECTOR(3 downto 0);
		  COM:out STD_LOGIC_VECTOR(3 downto 0);
		  Y:out STD_LOGIC_VECTOR(6 downto 0));
	end COMPONENT;
	
	COMPONENT FREQ_DEVIDER
	port(CLK:in STD_LOGIC;
		  CLK1HZ,CLK2HZ,CLK390KHZ:out STD_LOGIC);
	end COMPONENT;
	
	COMPONENT COUNTER4
	port(CLK:in STD_LOGIC;
		  SEL:out STD_LOGIC_VECTOR(1 downto 0));
	end COMPONENT;


begin	
		FREQDEVIDER:FREQ_DEVIDER port map(CLK,CLK1HZ,CLK2HZ,CLKDIV64HZ);
		COUNTER4UP:COUNTER4 port map(CLKDIV64HZ,SEL);
		SEVENSEGCONTROLLER:SEVENSEG_CONTROLLER port map(SEL,H1,H2,M1,M2,COMT,Y);
		DPCONTROLLER:DP_CONTROLLER port map(CLK1HZ,H,M,COMT,DP);
		COUNTTIME:COUNT_TIME port map(CLK1HZ,CLK2HZ,H,M,H1,H2,M1,M2);
		COM <= COMT;
end architecture;
