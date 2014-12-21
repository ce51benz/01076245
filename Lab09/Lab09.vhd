Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity Lab09 is
	port(VCLK,MCLK,RESET:IN STD_LOGIC;
		  SEL:in STD_LOGIC_VECTOR(3 downto 0);
		  Y:out STD_LOGIC_VECTOR(6 downto 0);
		  BP:out STD_LOGIC;
		  COM:out STD_LOGIC_VECTOR(1 downto 0));
		  
end Lab09;


architecture Behavirual of Lab09 is
	--signal COUNT1:integer range 0 to 4:=0;
	signal COUNT,COUNT1,COUNT2:integer range 0 to 25000000:=0;
	signal CLKIN:STD_LOGIC:='0';
	signal MONEYBCD,MONEY:STD_LOGIC_VECTOR(11 downto 0):="000000000000";
	signal NUMOUT:STD_LOGIC_VECTOR(3 downto 0);
	signal CLK8HZ,CLK1HZ,TRIG,CLK06HZ:STD_LOGIC:='0';
	signal MODE:integer range 0 to 5;
	type S is (S0,SC5,SC10,S5,S10,SB13,SB18,SBDN13,SBDN18,
	SDBB13_1,SDBB13_2,SDBB13_3,SDBB18_1,SDBB18_2,SDBB18_3,SDBB18_4,SDBB18_5,
	COUNTDN1,COUNTDN2,COUNTDN3,COUNTDN4);
	signal STATE:S:=S0;
begin

	COM<="10" when VCLK = '1' else
		  "01";
	
	process(MCLK)
	begin
		if MCLK'event and MCLK = '1' then
			if COUNT = 1562500 then COUNT <= 1;CLK8HZ <= not CLK8HZ;
			else COUNT <= COUNT +1;
			end if;
		end if;
	end process;
	
	process(MCLK)
	begin
		if MCLK'event and MCLK = '1' then
			if COUNT2 = 12500000 then COUNT2 <= 1;CLK1HZ <= not CLK1HZ;
			else COUNT2 <= COUNT2 +1;
			end if;
		end if;
	end process;
	with STATE select
			CLKIN <= CLK06HZ when SDBB13_1|SDBB13_2|SDBB13_3|SDBB18_1|SDBB18_2|SDBB18_3|SDBB18_4|SDBB18_5,
						CLK1HZ when COUNTDN1,
						CLK8HZ when COUNTDN2|COUNTDN3|COUNTDN4,
						MCLK when others;
	process(MCLK)
	begin
		if MCLK'event and MCLK = '1' then
			if COUNT1 = 16000000 then COUNT1 <= 1;CLK06HZ <= not CLK06HZ;
			else COUNT1 <= COUNT1 +1;
			end if;
		end if;
	end process;
	
	process(STATE)
	begin
			if RESET = '1' then STATE <= S0;
			elsif CLKIN'event and CLKIN = '1' then
			case STATE is
				when S0 => if SEL = "1011" then STATE <= SC5;
							  elsif SEL = "0111" then STATE <= SC10;
							  elsif SEL = "0001" and MONEY >= 13 then STATE <= SB13;
							  elsif SEL = "0010" and MONEY >= 18 then STATE <= SB18;
							  else STATE <= S0;
							  end if;
				when SC5 => if SEL = "0011" then STATE <= S5;
								else STATE <= SC5;
								end if;
				when SC10 => if SEL = "0011" then STATE <= S10;
								 else STATE <= SC10;
								 end if;
				when SB13 => if SEL = "0011" then STATE <= SBDN13;
								 else STATE <= SB13;
								 end if;
				when SBDN13 => STATE <= SDBB13_1;
				when SB18 => if SEL = "0011" then STATE <= SBDN18;
								 else STATE <= SB18;
								 end if;
				when SBDN18 => STATE <= SDBB18_1;
				when SDBB13_1=> STATE <= SDBB13_2;
				when SDBB13_2=> STATE <= SDBB13_3;
				when SDBB13_3=> STATE <= COUNTDN1;
				when SDBB18_1=> STATE <= SDBB18_2;
				when SDBB18_2=> STATE <= SDBB18_3;
				when SDBB18_3=> STATE <= SDBB18_4;
				when SDBB18_4=> STATE <= SDBB18_5;
				when SDBB18_5=> STATE <= COUNTDN1;
				when COUNTDN1 => if MONEY = 0 then STATE <= S0;
									  else STATE <= COUNTDN2;
									  end if;
				when COUNTDN2 => STATE <= COUNTDN3;
				when COUNTDN3 => STATE <= COUNTDN4;
				when COUNTDN4 => STATE <= COUNTDN1;
				when S5 => STATE <= S0;
				when S10 => STATE <= S0;
			end case;
			end if;
	end process;
	
	process(STATE)
	begin

			case STATE is
				when S0 => TRIG <= '0';MODE <= 0;BP<='0';
				when SC5 => TRIG <= '0';MODE <= 1;
				when SC10 => TRIG <= '0';MODE <= 2;
				when S5 =>TRIG <= '1';MODE <= 1;
				when S10 =>TRIG <= '1';MODE <= 2;
				when SB13 => TRIG <= '0';MODE <= 3;
				when SBDN13 => TRIG <= '1';MODE <= 3;
				when SB18 => TRIG <= '0';MODE <= 4;
				when SBDN18 => TRIG <= '1';MODE <= 4;
				when SDBB13_1=> TRIG <= '0';BP <= '0';
				when SDBB13_2=> TRIG <= '0';BP <= '1';
				when SDBB13_3=> TRIG <= '0';BP <= '0';
				when SDBB18_1=> TRIG <= '0';BP <= '0';
				when SDBB18_2=> TRIG <= '0';BP <= '1';
				when SDBB18_3=> TRIG <= '0';BP <= '0';
				when SDBB18_4=> TRIG <= '0';BP <= '1';
				when SDBB18_5=> TRIG <= '0';BP <= '0';
				when COUNTDN1 => TRIG <= '0';BP <= '0';MODE <= 5;
				when COUNTDN2 => TRIG <= '0';BP <= '0';MODE <= 5;
				when COUNTDN3 => TRIG <= '1';BP <= '1';MODE <= 5;
				when COUNTDN4 => TRIG <= '0';BP <= '0';MODE <= 5;
			end case;
	end process;
	
	
	process(TRIG,RESET)
	begin
			if RESET = '1' then MONEY <= "000000000000";
			elsif TRIG'event and TRIG = '1' then
				if MODE = 1 and MONEY + 5 <= 95 then
				MONEY <= MONEY + 5;
				elsif MODE = 2 and MONEY + 10 <= 90 then
				MONEY <= MONEY + 10;
				elsif MODE = 3 then
				MONEY <= MONEY - 13;
				elsif MODE = 4 then
				MONEY <= MONEY - 18;
				elsif MODE = 5 then
				MONEY <= MONEY - 1;
				end if;
			end if;
	end process;


	MONEYBCD <= MONEY + 6  when MONEY >= 10 and MONEY < 20 else
		            MONEY + 12 when MONEY >= 20 and MONEY < 30 else
						MONEY + 18 when MONEY >= 30 and MONEY < 40 else
						MONEY + 24 when MONEY >= 40 and MONEY < 50 else
						MONEY + 30 when MONEY >= 50 and MONEY < 60 else
						MONEY + 36 when MONEY >= 60 and MONEY < 70 else
						MONEY + 42 when MONEY >= 70 and MONEY < 80 else
						MONEY + 48 when MONEY >= 80 and MONEY < 90 else
						MONEY + 54 when MONEY >= 90 and MONEY < 100 else
						"000010010101" when MONEY >= 100 else
						MONEY;
	NUMOUT <= MONEYBCD(3 downto 0) when VCLK = '1' else
				   MONEYBCD(7 downto 4);
				 
	Y<=  "1101111" when  NUMOUT="1001" else
		  "1111111" when  NUMOUT="1000" else
		  "0000111" when  NUMOUT="0111" else
		  "1111101" when  NUMOUT="0110" else
		  "1101101" when  NUMOUT="0101" else
		  "1100110" when  NUMOUT="0100" else
		  "1001111" when  NUMOUT="0011" else
		  "1011011" when  NUMOUT="0010" else
		  "0000110" when  NUMOUT="0001" else
		  "0111111";
end Behavirual;