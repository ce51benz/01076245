Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ex2vf is
	port(A,B:in STD_LOGIC_VECTOR(2 downto 0);
		  C:out STD_LOGIC_VECTOR(3 downto 0));
end entity;

architecture Behavioral of ex2vf is
begin
		C<= ('0'&A) + ('0'&B);
end architecture;