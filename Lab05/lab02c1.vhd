
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity lab02 is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
			  CLK:in STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (6 downto 0));
end lab02;

architecture Behavioral of lab02 is
     signal X:STD_LOGIC_VECTOR(4 downto 0);
	  signal C:STD_LOGIC_VECTOR(3 downto 0);
begin
	  -------------------------
	  X<=('0'& A)+('0'& B);
	  C<= X(3 downto 0) when CLK = '1' else
	      "000"& X(4);
	  Y<="1110001" when C="1111" else
	     "1111001" when C="1110" else
		  "1011110" when C="1101" else
		  "0111001" when C="1100" else
		  "1111100" when C="1011" else
		  "1110111" when C="1010" else
		  "1101111" when C="1001" else
		  "1111111" when C="1000" else
		  "0000111" when C="0111" else
		  "1111101" when C="0110" else
		  "1101101" when C="0101" else
		  "1100110" when C="0100" else
		  "1001111" when C="0011" else
		  "1011011" when C="0010" else
		  "0000110" when C="0001" else
		  "0111111";
end architecture;

