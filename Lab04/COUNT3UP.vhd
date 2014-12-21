
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COUNT3UP is
port(CLK,CLR:in STD_LOGIC;
	  Q:OUT STD_LOGIC_VECTOR(1 downto 0));
end COUNT3UP;

architecture Behavioral of COUNT3UP is
	 component JKFF
    Port(J,K,C,CLR : in  STD_LOGIC;
           Q : out  STD_LOGIC);
	end component;
	signal QT:STD_LOGIC_VECTOR(1 downto 0);
	signal JB,KB,JA,KA:STD_LOGIC;
begin
	JB<=QT(0);
	KB<='1';
	JA<=not QT(1);
	KA<='1';
	B:JKFF port map(JB,KB,CLK,CLR,QT(1));
	A:JKFF port map(JA,KA,CLK,CLR,QT(0));
	Q(0)<=QT(0);
	Q(1)<=QT(1);
end Behavioral;
