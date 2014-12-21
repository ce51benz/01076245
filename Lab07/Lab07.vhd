Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity LAB07 is
	port(OP1,OP2:in STD_LOGIC_VECTOR(7 downto 0);
		  CLK:in STD_LOGIC;
		  SEL:in STD_LOGIC_VECTOR(3 downto 0);
		  COM:out STD_LOGIC_VECTOR(1 downto 0);
		  Y:out STD_LOGIC_VECTOR(6 downto 0));
end LAB07;


architecture Behavirual of LAB07 is
		signal ADD,SUB,EOR,LSL:STD_LOGIC_VECTOR(7 downto 0);
		signal ANS:STD_LOGIC_VECTOR(7 downto 0);
		signal NUMOUT:STD_LOGIC_VECTOR(3 downto 0);
begin 
		COM <= "10" when CLK = '1' else
				 "01";
		ADD <=(not OP1) + (not OP2);
		SUB <=(not OP1) - (not OP2);
		EOR <=(not OP1) xor (not OP2);
		LSL <=(not OP1(6 downto 0))&'0';
		
		with SEL select
					ANS <= ADD when "1011",
							 SUB when "0111",
							 EOR when "0001",
							 LSL when "0010",
							 "00000000" when others;
							 
		NUMOUT <= ANS(3 downto 0) when CLK = '1' else
					 ANS(7 downto 4);
					  
		Y<="1110001" when NUMOUT="1111" else
	     "1111001" when NUMOUT="1110" else
		  "1011110" when NUMOUT="1101" else
		  "0111001" when NUMOUT="1100" else
		  "1111100" when NUMOUT="1011" else
		  "1110111" when NUMOUT="1010" else
		  "1101111" when NUMOUT="1001" else
		  "1111111" when NUMOUT="1000" else
		  "0000111" when NUMOUT="0111" else
		  "1111101" when NUMOUT="0110" else
		  "1101101" when NUMOUT="0101" else
		  "1100110" when NUMOUT="0100" else
		  "1001111" when NUMOUT="0011" else
		  "1011011" when NUMOUT="0010" else
		  "0000110" when NUMOUT="0001" else
		  "0111111";
end Behavirual;