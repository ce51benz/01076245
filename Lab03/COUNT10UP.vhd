Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity COUNT10UP is
	port(CLK:in STD_LOGIC;
			 Y:out STD_LOGIC_VECTOR(6 downto 0);
		  COM:out STD_LOGIC);
end COUNT10UP;


architecture behavirual of COUNT10UP is
	signal NT:integer range 0 to 9:=0;
	signal COUNT:integer range 0 to 25000001:=0;
	signal TRIG:STD_LOGIC:='0';
	begin
	process(CLK,COUNT)
		begin
			if CLK'event and CLK ='1' then
			if COUNT=12500000 then COUNT <= 1;TRIG<= not TRIG;
			else  COUNT<=COUNT + 1;
			end if;
			end if;
	end process;
   process(TRIG)
   begin
		if TRIG'event and TRIG='1' then
			if NT=9 then NT<=0;
			else NT<= NT+1;
			end if;
			end if;
	end process;
	Y<="1101111" when NT=9 else
	   "1111111" when NT=8 else
		"0000111" when NT=7 else
		"1111101" when NT=6 else
		"1101101" when NT=5 else
		"1100110" when NT=4 else
		"1001111" when NT=3 else
		"1011011" when NT=2 else
		"0000110" when NT=1 else
		"0111111";
	COM<='0';
end behavirual;