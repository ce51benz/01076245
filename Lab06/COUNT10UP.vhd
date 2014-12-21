
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COUNT10UP is
port(CLK,CLR:in STD_LOGIC;
	  Q:OUT STD_LOGIC_VECTOR(3 downto 0));
end COUNT10UP;


architecture Behavioral of COUNT10UP is
	 component JKFF
    Port(J,K,C,CLR : in  STD_LOGIC;
           Q : out  STD_LOGIC);
	end component;
	signal QT:STD_LOGIC_VECTOR(3 downto 0);
	signal JD,KD,JC,KC,JB,KB,JA,KA:STD_LOGIC;
begin
	JD<=QT(2) and QT(1) and QT(0);
	KD<=QT(0);
	JC<=QT(1) and QT(0);
	KC<=QT(1) and QT(0);
	JB<=not QT(3) and QT(0);
	KB<=QT(0);
	JA<='1';
	KA<='1';	
	D:JKFF port map(JD,KD,CLK,CLR,QT(3));
	C:JKFF port map(JC,KC,CLK,CLR,QT(2));
	B:JKFF port map(JB,KB,CLK,CLR,QT(1));
	A:JKFF port map(JA,KA,CLK,CLR,QT(0));
	Q(0)<=QT(0);
	Q(1)<=QT(1);
	Q(2)<=QT(2);
	Q(3)<=QT(3);
end Behavioral;

