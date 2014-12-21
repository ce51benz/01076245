Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity COUNT_TIME is
	port(CLK1,CLK2,H,M:in STD_LOGIC;
		  S1,S2,H1,H2,M1,M2:out STD_LOGIC_VECTOR(3 downto 0));
end COUNT_TIME;

architecture Behaviorual of COUNT_TIME is	
	COMPONENT COUNT_SEC0_59
	port(CLK,H,M:in STD_LOGIC;
		  TRIGSECOUT:out STD_LOGIC;
		  S1OUT,S2OUT:out STD_LOGIC_VECTOR(3 downto 0));
	end COMPONENT;
	
	COMPONENT COUNT_MIN0_59
	port(CLKM:in STD_LOGIC;
		  TRIGMINOUT:out STD_LOGIC;
		  M1,M2:out STD_LOGIC_VECTOR(3 downto 0));
	end COMPONENT;
	
	COMPONENT COUNT_HR0_23
	port(CLKH,EN:in STD_LOGIC;
		  H1,H2:out STD_LOGIC_VECTOR(3 downto 0));
	end COMPONENT;

	signal CLKH,CLKM,EN,TRIGSECOUT,TRIGMINOUT:STD_LOGIC:='0';
	signal HM:STD_LOGIC_VECTOR(1 downto 0);
begin
	COUNTSEC0_59:COUNT_SEC0_59 port map(CLK1,H,M,TRIGSECOUT,S1,S2);
	COUNTMIN0_59:COUNT_MIN0_59 port map(CLKM,TRIGMINOUT,M1,M2);
	COUNTHR0_23:COUNT_HR0_23 port map(CLKH,EN,H1,H2);
		--CLKM is TRIGGER to count minute which will be selected.
		CLKM<=CLK2 when M='1' else --USE TRIGGER AS CLK2HZ
				TRIGSECOUT; 					  --TRIGGER FROM COUNTSEC1.
		
		--CLKH is TRIGGER to count hour which will be selected.
		HM<=H&M;
		process(HM,TRIGMINOUT)
		begin
					if HM = "01" then CLKH <= CLKH;
					elsif HM = "00" then CLKH <= TRIGMINOUT;
					else CLKH <= CLK2;
					end if;
		end process;
		
		process(M)
		begin
				if H = '1' or M = '0' then EN <= '1';
				else EN <= '0';
				end if;
		end process;

end Behaviorual;