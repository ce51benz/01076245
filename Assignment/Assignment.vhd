library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Assignment is
	port(START,MCLK,RESET,AVSW,MODE:in STD_LOGIC;
		  COM:out STD_LOGIC_VECTOR(3 downto 0);
		  LED,LED1:out STD_LOGIC_VECTOR(7 downto 0);
		  BP:out STD_LOGIC;
		  Y:out STD_LOGIC_VECTOR(6 downto 0));
end Assignment;

architecture Behavioral of Assignment is
	  type S is (A,B,S5,S5B_1,S5B_2,S4,S4B_1,
					 S4B_2,S3,S3B_1,S3B_2,S2,S2B_1,S2B_2,S1,S1B_1,S1B_2,S0,SD5,
					 SDBEEP,SDBEEP1,SDBEEP2,DELAYOVER,GAMEOVER1,GAMEOVER2,GAMEOVER3,
					 GAMEOVER4,RANDOMSTATE,C,D);
	  signal NUMOUT:STD_LOGIC_VECTOR(3 downto 0);
	  signal SCORE,SCOREBCD,COUNTDN,BCDOUT,SCOREBCDMAX,
				SCOREBCDMAX2,SCORE1,SCORE2:STD_LOGIC_VECTOR(7 downto 0):="00000000";
	  signal TRIG,TRIGC,CLK4HZ,CLK3HZ,CLRSCR,
				CLKLEVEL,CLKSIN,CLK1HZ,CLK2HZ,CLK8HZ,
				CLK6HZ,CCLK,CLKDIV64HZ,CLK10HZ,MODESEL:STD_LOGIC:='0';
	  signal COUNT1,COUNT,COUNT2,COUNT3,COUNT4,
				COUNT5,DIV64COUNT,COUNT6,COUNT7:integer range 0 to 20000000:=0;
	  signal STATE,SCORESTATE:S:=A;
	  signal NUM:STD_LOGIC_VECTOR(31 downto 0);
	  signal MEM:STD_LOGIC_VECTOR(3 downto 0);
	  signal DIN,DINREAL:STD_LOGIC_VECTOR(1 downto 0);
	  signal LEDT,LEDT1:STD_LOGIC_VECTOR(7 downto 0):="00000000";
	  signal INITLEVEL,DETECTLEVEL:integer range 0 to 3:=0;
	  signal SEL : STD_LOGIC_VECTOR (1 downto 0) := "00";
	   COMPONENT DFF PORT(
		D : in std_logic;
		CLR : in std_logic;
		C : in std_logic;          
		Q : out std_logic);
	END COMPONENT;
		COMPONENT random
		GENERIC ( width : integer :=  32 );
		PORT (
      CLK : IN std_logic;
      RANDOM_NUM : OUT std_logic_vector (width-1 downto 0)        
		);
		END COMPONENT;
begin
		--RANDOM GENERATOR
		RAND:random generic map(32)
						port map(MCLK,NUM);
		---------------------
		
		INITLEVEL <= 1 when NUM > 1400000000 else
		             2 when NUM >= 500000000 and NUM < 1399999999 else
						 3;				 
						 
		DIN <= "10" and (TRIG&TRIG) when NUM > 1931655765 else 
				 "01" and (TRIG&TRIG) when NUM > 315827883 and NUM <= 1931655765 else
				 "00";
		---------------------------------------------------------------------		 
		--FIREBALL DISPLAY
		DFF1:DFF port map(DINREAL(0),RESET,CLKLEVEL,LEDT(0));
		DFF2:DFF port map(LEDT(0),RESET,CLKLEVEL,LEDT(1));
		DFF3:DFF port map(LEDT(1),RESET,CLKLEVEL,LEDT(2));
		DFF4:DFF port map(LEDT(2),RESET,CLKLEVEL,LEDT(3));
		DFF5:DFF port map(LEDT(3),RESET,CLKLEVEL,LEDT(4));
		DFF6:DFF port map(LEDT(4),RESET,CLKLEVEL,LEDT(5));
		DFF7:DFF port map(LEDT(5),RESET,CLKLEVEL,LEDT(6));
		DFF8:DFF port map(LEDT(6),RESET,CLKLEVEL,LEDT(7));
		LED<= LEDT;
		
		DFF9:DFF port map(DINREAL(1),RESET,CLKLEVEL,LEDT1(0));
		DFF10:DFF port map(LEDT1(0),RESET,CLKLEVEL,LEDT1(1));
		DFF11:DFF port map(LEDT1(1),RESET,CLKLEVEL,LEDT1(2));
		DFF12:DFF port map(LEDT1(2),RESET,CLKLEVEL,LEDT1(3));
		DFF13:DFF port map(LEDT1(3),RESET,CLKLEVEL,LEDT1(4));
		DFF14:DFF port map(LEDT1(4),RESET,CLKLEVEL,LEDT1(5));
		DFF15:DFF port map(LEDT1(5),RESET,CLKLEVEL,LEDT1(6));
		DFF16:DFF port map(LEDT1(6),RESET,CLKLEVEL,LEDT1(7));
		
		LED1<= not LEDT1;
		
		--FIREBALL CONTROL
		MEM1:DFF port map(DIN(0),RESET,CLKLEVEL,MEM(0));
		MEM2:DFF port map(MEM(0),RESET,CLKLEVEL,MEM(1));
		MEM3:DFF port map(DIN(1),RESET,CLKLEVEL,MEM(2));
		MEM4:DFF port map(MEM(2),RESET,CLKLEVEL,MEM(3));
		DINREAL <= "00" when MEM = "1001" or MEM = "0110" else
					  MEM(2)&MEM(0);
		---------------------------------------------------------------------
		

		with STATE select
                 CCLK <= CLK1HZ when SD5|S5|S4|S3|S2|S1|S0|SDBEEP|SDBEEP1|SDBEEP2,
								 CLK8HZ when S5B_1|S4B_1|S3B_1|S2B_1|S1B_1,
								 CLK4HZ when DELAYOVER|GAMEOVER1|GAMEOVER2|GAMEOVER3|GAMEOVER4,
								 MCLK when others;
								 
		----------FREQUENCY DIVIDER---------------------------
		process(MCLK)
		begin
				if MCLK'event and MCLK = '1' then
					if COUNT = 3125000 then COUNT <= 1;CLK4HZ <= not CLK4HZ;
					else COUNT <= COUNT + 1;
					end if;
				end if;
		end process;
		
		process(MCLK)
		begin
				if MCLK'event and MCLK = '1' then
					if COUNT6 = 1250000 then COUNT6 <= 1;CLK10HZ <= not CLK10HZ;
					else COUNT6 <= COUNT6 + 1;
					end if;
				end if;
		end process;
		
		
		process(MCLK)
		begin
				if MCLK'event and MCLK = '1' then
					if COUNT1 = 6250000 then COUNT1 <= 1;CLK2HZ <= not CLK2HZ;
					else COUNT1 <= COUNT1 + 1;
					end if;
				end if;
		end process;
		
		
		process(MCLK)
		begin
				if MCLK'event and MCLK = '1' then
					if COUNT4 = 4166666 then COUNT4 <= 1;CLK3HZ <= not CLK3HZ;
					else COUNT4 <= COUNT4 + 1;
					end if;
				end if;
		end process;
		
		
		process(MCLK)
		begin
				if MCLK'event and MCLK = '1' then
					if COUNT5 = 2083333 then COUNT5 <= 1;CLK6HZ <= not CLK6HZ;
					else COUNT5 <= COUNT5 + 1;
					end if;
				end if;
		end process;
		
		
		process(MCLK)
		begin
				if MCLK'event and MCLK = '1' then
					if COUNT2 = 1562500 then COUNT2 <= 1;CLK8HZ <= not CLK8HZ;
					else COUNT2 <= COUNT2 + 1;
					end if;
				end if;
		end process;
		
	
		process(MCLK)
		begin
				if MCLK'event and MCLK = '1' then
					if COUNT3 = 12500000 then COUNT3 <= 1;CLK1HZ <= not CLK1HZ;
					else COUNT3 <= COUNT3 + 1;
					end if;
				end if;
		end process;
		
		
		process(MCLK)
		begin
				if MCLK'event and MCLK='1' then
					if DIV64COUNT=31 then DIV64COUNT<=0;CLKDIV64HZ<=not CLKDIV64HZ;
					else DIV64COUNT <= DIV64COUNT + 1;
					end if;
				end if;
		end process;
		
		------------------------------------------------------
		
		--MAIN GAME STATEMACHINE---------------------------------------------		
		process(STATE)
		begin
				if RESET = '1' then STATE <= A;
				elsif CCLK'EVENT and CCLK = '1' then 
				case STATE is
					when SD5 => STATE <= S5;
					when S5 => STATE <= S5B_1;
					when SDBEEP => STATE <= SDBEEP1;
					when SDBEEP1 => STATE <= SDBEEP2;
					when SDBEEP2 => STATE <= C;
					when A => 
						if START = '1' then STATE <=B;
						else STATE <=A;
						end if;
					when B =>
						if START = '0' and (not MODE) = '0' then STATE <=SD5;
						elsif START = '0' and (not MODE) = '1' then STATE <=RANDOMSTATE;
						else STATE <= B;
						end if;
				   when RANDOMSTATE => STATE <= SD5;
					when S5B_1 => STATE <= S5B_2;
					when S5B_2 => STATE <= S4;
					
					when S4 => STATE <= S4B_1;
					when S4B_1 => STATE <= S4B_2;
					when S4B_2 => STATE <= S3;
					
					when S3 => STATE <= S3B_1;
					when S3B_1 => STATE <= S3B_2;
					when S3B_2 => STATE <= S2;
					
					when S2 => STATE <= S2B_1;
					when S2B_1 => STATE <= S2B_2;
					when S2B_2 => STATE <= S1;
					
					when S1 => STATE <= S1B_1;
					when S1B_1 => STATE <= S1B_2;
					when S1B_2 => STATE <= S0;
					
					when S0 => STATE <= SDBEEP;
					
					when C =>
						if LEDT(7) = '1' and (not AVSW) = '0' then STATE <= DELAYOVER;
						elsif LEDT1(7) = '1' and (not AVSW) = '1' then STATE <= DELAYOVER;
						else STATE <= C;
						end if;
					when DELAYOVER => STATE <= GAMEOVER1;
					when GAMEOVER1 => STATE <= GAMEOVER2;
					when GAMEOVER2 => STATE <= GAMEOVER3;
					when GAMEOVER3 => STATE <= GAMEOVER4;
					when GAMEOVER4 => STATE <= D;
					when D => STATE <=A;
				end case;
				end if;
		end process;
		 --------------------------------------------------------------
		
		
		--MAIN GAME OUTPUT CONTROLLER-------------------------------
		process(STATE)
		begin
				case STATE is
					when A => TRIG <= '0';BP <= '0';COUNTDN <= "00000000";
					when SD5 => TRIG <= '0';BP <= '0';COUNTDN <= "00000101";
					when S5 =>  TRIG <= '0';BP <= '0';COUNTDN <= "00000101";
					when S5B_1 =>  TRIG <= '0';BP <= '1';COUNTDN <= "00000100";
					when S5B_2 =>  TRIG <= '0';BP <= '0';COUNTDN <= "00000100";
					when B =>
						if START = '0' and (not MODE) = '0' then DETECTLEVEL <= 0;MODESEL<= '0';
						elsif START = '0' and (not MODE) = '1' then DETECTLEVEL <= INITLEVEL;MODESEL <= '1';
						else DETECTLEVEL <= 0;MODESEL <= '0';
						end if;
					when RANDOMSTATE => TRIG <= '0';BP <= '0';COUNTDN <= "00000101";
					when S4 => TRIG <= '0';BP <= '0';COUNTDN <= "00000100";
					when S4B_1 => TRIG <= '0';BP <= '1';COUNTDN <= "00000011";
					when S4B_2 => TRIG <= '0';BP <= '0';COUNTDN <= "00000011";
					
					when S3 => TRIG <= '0';BP <= '0';COUNTDN <= "00000011";
					when S3B_1 => TRIG <= '0';BP <= '1';COUNTDN <= "00000010";
					when S3B_2 => TRIG <= '0';BP <= '0';COUNTDN <= "00000010";
					
					when S2 => TRIG <= '0';BP <= '0';COUNTDN <= "00000010";
					when S2B_1 => TRIG <= '0';BP <= '1';COUNTDN <= "00000001";
					when S2B_2 => TRIG <= '0';BP <= '0';COUNTDN <= "00000001";
					
					when S1 => TRIG <= '0';BP <= '0';COUNTDN <= "00000001";
					when S1B_1 => TRIG <= '0';BP <= '1';COUNTDN <= "00000000";
					when S1B_2 => TRIG <= '0';BP <= '0';COUNTDN <= "00000000";
					
					when S0 => TRIG <= '0';BP <= '0';COUNTDN <= "00000000";
					when SDBEEP => TRIG <= '0';BP <= '0';COUNTDN <= "00000000";
					when SDBEEP1 => TRIG <= '0';BP <= '1';COUNTDN <= "00000000";
					when SDBEEP2 => TRIG <= '0';BP <= '0';COUNTDN <= "00000000";
					when C => TRIG <= '1';BP <= '0';COUNTDN <= "00000000";
					when DELAYOVER => TRIG <= '0';BP <= '0';COUNTDN <= "00000000";
					when GAMEOVER1 => TRIG <= '0';BP <= '1';COUNTDN <= "00000000";
					when GAMEOVER2 => TRIG <= '0';BP <= '0';COUNTDN <= "00000000";
					when GAMEOVER3 => TRIG <= '0';BP <= '1';COUNTDN <= "00000000";
					when GAMEOVER4 => TRIG <= '0';BP <= '0';COUNTDN <= "00000000";
					when D => TRIG <= '0';BP <= '0';COUNTDN <= "00000000";
				end case;
		end process;
		---------------------------------------------------------------
		
		-----------SCORE COUNTER---------------------------------------
		process(CLRSCR,RESET,STATE)
		begin
			if CLRSCR = '1' or RESET = '1' or STATE = A then SCORE <= "00000000";
			elsif TRIGC'event and TRIGC = '1' then
			SCORE <= SCORE + 1;
			end if;
		end process;
		---------------------------------------------------------------
		
		----GAME LEVEL CONTROLLER--------------------------------------
		CLKLEVEL <= CLK1HZ  when SCORE >= 0  and SCORE  < 5 and DETECTLEVEL = 0 else
						CLK2HZ  when SCORE >= 5  and SCORE  < 10 and DETECTLEVEL = 0 else
						CLK3HZ  when SCORE >= 10 and SCORE  < 20 and DETECTLEVEL = 0 else
		            CLK4HZ  when SCORE >= 20 and SCORE  < 35 and DETECTLEVEL = 0 else
						CLK6HZ  when SCORE >= 35 and SCORE  < 50 and DETECTLEVEL = 0 else
						CLK8HZ  when SCORE >= 50 and SCORE  < 70 and DETECTLEVEL = 0 else
						CLK2HZ  when SCORE >= 0  and SCORE  < 15 and DETECTLEVEL = 1 else
						CLK3HZ  when SCORE >= 15 and SCORE  < 30 and DETECTLEVEL = 1 else
		            CLK4HZ  when SCORE >= 30 and SCORE  < 50 and DETECTLEVEL = 1 else
						CLK6HZ  when SCORE >= 50 and SCORE  < 70 and DETECTLEVEL = 1 else
						CLK4HZ  when SCORE >=  0 and SCORE  < 50 and DETECTLEVEL = 2 else
						CLK6HZ  when SCORE >= 50 and SCORE  < 70 and DETECTLEVEL = 2 else
						CLK6HZ  when SCORE >=  0 and SCORE  < 70 and DETECTLEVEL = 3 else
						CLK10HZ;
		---------------------------------------------------------------				
						
		CLKSIN <= MCLK when SCORESTATE = C or SCORESTATE = D or SCORESTATE = B else
					 CLKLEVEL;
		
		----SCORE STATE COUNTER CONTROLLER-----------------------------
		process(SCORESTATE)
		begin
				if RESET = '1' then SCORESTATE <= A;
				elsif CLKSIN'EVENT and CLKSIN = '1' then 
				case SCORESTATE is
					when A => 
						if LEDT(7) = '1' then
							if not AVSW = '1' then SCORESTATE <= B;
							else SCORESTATE <= C;
							end if;
						elsif LEDT1(7) = '1' then
							if not AVSW = '0' then SCORESTATE <= B;
							else SCORESTATE <= C;
							end if;
						else SCORESTATE <= A;
						end if;
					when B =>
						SCORESTATE <=A;
					when C => 
						if START = '1' then SCORESTATE <=D;
						else SCORESTATE <=C;
						end if;
					when D =>
						if START = '0' then SCORESTATE <=A;
						else SCORESTATE <= D;
						end if;
					when others => SCORESTATE <= A;
				end case;
				end if;
		end process;
		
		------SCORE GEN TRIG CONTROLLER---------------------------------------------
		process(SCORESTATE)
		begin 
				case SCORESTATE is
				   when A =>
					if LEDT(7) = '1' then
							if not AVSW = '1' then TRIGC <= '1';CLRSCR <= '0';
							else TRIGC <= '0';CLRSCR <= '1';
							end if;
					elsif LEDT1(7) = '1' then
							if not AVSW = '0' then TRIGC <= '1';CLRSCR <= '0';
							else TRIGC <= '0';CLRSCR <= '1';
							end if;
					else TRIGC <= '0';CLRSCR <= '0';
					end if;
					when B =>
						TRIGC <= '0';CLRSCR <= '0';
					when C =>
						TRIGC <= '0';CLRSCR <= '1';
					when D =>
						TRIGC <= '0';CLRSCR <= '0';
					when others => TRIGC <= '0';CLRSCR <= '1';
				end case;
		end process;
		-----------------------------------------------------------------------------
		
		--Counter4(0-3)------------------------------------
		process(CLKDIV64HZ)
		begin
				if CLKDIV64HZ'event and CLKDIV64HZ = '1' then
					if SEL="11" then SEL <="00";
					else SEL <= SEL + 1;
					end if;
				end if;
		end process;
		
		
		--CORRECT BINARY TO BCD CIRCUIT--------------------------------------------
		SCOREBCD <= SCORE + 6  when SCORE >= 10 and SCORE < 20 else
		            SCORE + 12 when SCORE >= 20 and SCORE < 30 else
						SCORE + 18 when SCORE >= 30 and SCORE < 40 else
						SCORE + 24 when SCORE >= 40 and SCORE < 50 else
						SCORE + 30 when SCORE >= 50 and SCORE < 60 else
						SCORE + 36 when SCORE >= 60 and SCORE < 70 else
						SCORE + 42 when SCORE >= 70 and SCORE < 80 else
						SCORE + 48 when SCORE >= 80 and SCORE < 90 else
						SCORE + 54 when SCORE >= 90 and SCORE < 100 else
						"10011001" when SCORE >= 100 else
						SCORE;
						
		SCOREBCDMAX <= SCORE1 + 6  when SCORE1 >= 10 and SCORE1 < 20 else
		            SCORE1 + 12 when SCORE1 >= 20 and SCORE1 < 30 else
						SCORE1 + 18 when SCORE1 >= 30 and SCORE1 < 40 else
						SCORE1 + 24 when SCORE1 >= 40 and SCORE1 < 50 else
						SCORE1 + 30 when SCORE1 >= 50 and SCORE1 < 60 else
						SCORE1 + 36 when SCORE1 >= 60 and SCORE1 < 70 else
						SCORE1 + 42 when SCORE1 >= 70 and SCORE1 < 80 else
						SCORE1 + 48 when SCORE1 >= 80 and SCORE1 < 90 else
						SCORE1 + 54 when SCORE1 >= 90 and SCORE1 < 100 else
						"10011001" when SCORE1 >= 100 else
						SCORE1;
		SCOREBCDMAX2 <= SCORE2 + 6  when SCORE2 >= 10 and SCORE2 < 20 else
		            SCORE2 + 12 when SCORE2 >= 20 and SCORE2 < 30 else
						SCORE2 + 18 when SCORE2 >= 30 and SCORE2 < 40 else
						SCORE2 + 24 when SCORE2 >= 40 and SCORE2 < 50 else
						SCORE2 + 30 when SCORE2 >= 50 and SCORE2 < 60 else
						SCORE2 + 36 when SCORE2 >= 60 and SCORE2 < 70 else
						SCORE2 + 42 when SCORE2 >= 70 and SCORE2 < 80 else
						SCORE2 + 48 when SCORE2 >= 80 and SCORE2 < 90 else
						SCORE2 + 54 when SCORE2 >= 90 and SCORE2 < 100 else
						"10011001" when SCORE2 >= 100 else
						SCORE2;
			---------------------------------------------------------------------------

		--7SEG CONTROLLER----------------------------------------------------------
		COM    <= "1110" when SEL = "00" else
					 "1101" when SEL = "01" else
					 "1011" when SEL = "10" else
					 "0111";
		NUMOUT <=  BCDOUT(3 downto 0) when SEL = "00" else
					  BCDOUT(7 downto 4) when SEL = "01" else
					  SCOREBCDMAX(3 downto 0) when SEL = "10" and (not MODE) ='0' else
					  SCOREBCDMAX(7 downto 4) when SEL = "11" and (not MODE) ='0' else
					  BCDOUT(3 downto 0) when SEL = "00" else
					  BCDOUT(7 downto 4) when SEL = "01" else
					  SCOREBCDMAX2(3 downto 0) when SEL = "10" and (not MODE)= '1' else
					  SCOREBCDMAX2(7 downto 4) when SEL = "11" and (not MODE)= '1' ;
					  
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
		------------------------------------------------------------------------
		
		--HIGHSCORE COMPARATOR-------------------------
		SCORE1 <= SCORE when SCORE1 < SCORE and MODESEL = '0' else
					 SCORE1;
							
		SCORE2 <= SCORE when SCORE2 < SCORE and MODESEL = '1' else
					 SCORE2;
		-----------------------------------------------
		
		----CURRENT SCORE DISPLAY CONTROLLER-----------
		with STATE select
                 BCDOUT <= COUNTDN when A|B|S5|S4|S3|S2|S1|S0|S5B_1|S5B_2|S4B_1|
													 S4B_2|S3B_1|S3B_2|S2B_1|S2B_2|S1B_1|S1B_2|
													 DELAYOVER|GAMEOVER1|
													 GAMEOVER2|GAMEOVER3|GAMEOVER4,
					  SCOREBCD when others;
		-----------------------------------------------
      
		
end Behavioral;

