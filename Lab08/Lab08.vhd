Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Lab08 is
	port(SEL:IN STD_LOGIC_VECTOR(4 downto 0);
		  OP:IN STD_LOGIC_VECTOR(7 downto 0);
		  CLK,OKBT,MCLK:IN STD_LOGIC;
		  LEDOP:OUT STD_LOGIC_VECTOR(7 downto 0);
		  Y:OUT STD_LOGIC_VECTOR(6 downto 0);
		  COM:OUT STD_LOGIC_VECTOR(1 downto 0);
		  BP:OUT STD_LOGIC);
end Lab08;


architecture Behavirual of Lab08 is
		signal ACC,ACCOUT:STD_LOGIC_VECTOR(7 downto 0):="00000000";
		signal NUMOUT:STD_LOGIC_VECTOR(3 downto 0);
		signal STATE,NEXTSTATE,COUNT1:integer range 0 to 3:=0;
		signal CLK8HZ:STD_LOGIC:= '0';
		signal COUNT:integer range 0 to 1562500:=0;
		signal BPTEMP,EN:STD_LOGIC:= '0';
begin
		process(MCLK)
		begin
				if MCLK'event and MCLK = '1' then
					if COUNT = 1562500 then COUNT <= 1;CLK8HZ <= not CLK8HZ;
					else COUNT <= COUNT + 1;
					end if;
				end if;
		end process;
		

		process(OKBT,STATE,OP,CLK8HZ)
		
		begin
				if STATE = 0 then EN<='0';
					if OKBT = '1' then NEXTSTATE <= 1;
					end if;
				elsif STATE = 1 then 
					if OKBT = '0' then EN<= '1';NEXTSTATE <= 2;
					end if;	
				
				elsif STATE = 2 then EN<='0';
					if CLK8HZ'EVENT and CLK8HZ = '1' then
						if COUNT1 = 1 then BPTEMP <= not BPTEMP;COUNT1 <= 0;NEXTSTATE <= 0;
						else COUNT1 <= COUNT1 + 1;BPTEMP <= not BPTEMP;
						end if;
					end if;
				end if;
		STATE <= NEXTSTATE;		
		end process;
		ACCOUT <= ACC;
		
		
		process(EN,SEL)
		begin
				if EN = '1' then
						if SEL = "01111" then ACC <= ACC + (not OP);
						elsif SEL = "10111" then ACC <= ACC - (not OP);
						elsif SEL = "11011" then ACC <= ACC XOR (not OP);
						elsif SEL = "11101" then ACC <= ACC(6 downto 0) & "0";
						elsif SEL = "11110" then ACC <= not OP;
						end if;
				end if;
		end process;
		
				
		BP<= BPTEMP;
		
		--SELECT COMMON OUTPUT
		with CLK select
				COM <= "10" when '1',
						 "01" when others;
		
		--SELECT EXPECTED OUTPUT TO DISPLAY
		with CLK select
				NUMOUT <= ACCOUT(3 downto 0) when '1',
						 ACCOUT(7 downto 4) when others;				 
		
		--LED DISPLAY
		LEDOP <= not OP;
		
		
		--BEEP BY 1 PULSE
		--BP <= CLK2HZ;
		
		--BASE16 TO 7 SEG
		Y<="1110001" when NUMOUT="1111" else
	     "1111001" when 	NUMOUT="1110" else
		  "1011110" when 	NUMOUT="1101" else
		  "0111001" when  NUMOUT="1100" else
		  "1111100" when  NUMOUT="1011" else
		  "1110111" when  NUMOUT="1010" else
		  "1101111" when  NUMOUT="1001" else
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