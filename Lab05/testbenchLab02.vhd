library IEEE;
use std.TEXTIO.all;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;

entity TESTBENCH is
end TESTBENCH;

architecture Behavirual of TESTBENCH is
		COMPONENT lab02
		Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
			  CLK:in STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (6 downto 0));
		end component;
		signal A,B:STD_LOGIC_VECTOR(3 downto 0):="0000";
		signal CLK:STD_LOGIC;
		signal Y:STD_LOGIC_VECTOR(6 downto 0);
begin
		UUT:lab02 port map(A,B,CLK,Y);
		TEST:process
			FILE FILEIN:TEXT open READ_MODE is "Input_4_Bit_Adder.txt";
			FILE FILEOUT:TEXT open WRITE_MODE is "Output_4_Bit_Adder.txt";
			variable LINE_IN:LINE;
			variable LINE_OUT:LINE;
			variable Ain,Bin:STD_LOGIC_VECTOR(3 downto 0);
		begin
			while NOT endfile(FILEIN) loop
				readline(FILEIN,LINE_IN);
				read(LINE_IN,Ain);
				read(LINE_IN,Bin);
				A<=Ain;
				B<=Bin;
				CLK <= '0';
				wait for 50 ns;
				LINE1NUM1:case Y is
						when "0111111"|"1011011"|"1001111"|"1101101"|
								"1111101"|"0000111"|"1111111"|"1101111"|
								"1110111"|"0111001"|"1111001"|"1110001" =>
									write(LINE_OUT,"****");
						when "0000110"|"1011110" =>
							write(LINE_OUT,"   *");
						when "1100110" =>
							write(LINE_OUT,"*  *");
						when "1111100" =>
							write(LINE_OUT,"*   ");
						when others => write(LINE_OUT,"ERROR");
				end case LINE1NUM1;
				---------------------------------------
				wait for 50 ns;
				write(LINE_OUT," ");
				CLK <= '1';
				wait for 50 ns;
				LINE1NUM2:case Y is
						when "0111111"|"1011011"|"1001111"|"1101101"|
								"1111101"|"0000111"|"1111111"|"1101111"|
								"1110111"|"0111001"|"1111001"|"1110001" =>
									write(LINE_OUT,"****");
						when "0000110" =>
							write(LINE_OUT,"   *");
						when "1100110" =>
							write(LINE_OUT,"*  *");
						when "1111100" =>
							write(LINE_OUT,"*   ");
						when "1011110" =>
							write(LINE_OUT,"   *");
						when others => write(LINE_OUT,"ERRO");
				end case LINE1NUM2;
				---------------------------------------
				wait for 50 ns;
				writeline(FILEOUT,LINE_OUT);
				wait for 50 ns;
				CLK <= '0';
				wait for 50 ns;
				LINE2NUM1:case Y is
						when "0111111"|"1100110"|"1111111"|"1101111"|"1110111" =>
							write(LINE_OUT,"*  *");
						when "0000110"|"1011011"|"1001111"|"0000111"|"1011110" =>
							write(LINE_OUT,"   *");
						when "1101101"|"1111101"|"1111100"|"0111001"|"1111001"|"1110001" =>
							write(LINE_OUT,"*   ");
						when others => write(LINE_OUT,"ERROR");
				end case LINE2NUM1;
				---------------------------------------
				wait for 50 ns;
				write(LINE_OUT," ");
				CLK <= '1';
				wait for 50 ns;
				LINE2NUM2:case Y is
						when "0111111"|"1100110"|"1111111"|"1101111"|"1110111" =>
							write(LINE_OUT,"*  *");
						when "0000110"|"1011011"|"1001111"|"0000111"|"1011110" =>
							write(LINE_OUT,"   *");
						when "1101101"|"1111101"|"1111100"|"0111001"|"1111001"|"1110001" =>
							write(LINE_OUT,"*   ");
						when others => write(LINE_OUT,"ERROR");
				end case LINE2NUM2;
				---------------------------------------
				wait for 50 ns;
				writeline(FILEOUT,LINE_OUT);
				wait for 50 ns;
				CLK <= '0';
				wait for 50 ns;
				LINE3NUM1:case Y is
						when "1011011"|"1001111"|"1100110"|"1101101"|"1111101"|
							  "1111111"|"1101111"|"1110111"|"1111100"|"1011110"|
							  "1111001"|"1110001" =>
								write(LINE_OUT,"****");
						when "0111111"=>
								write(LINE_OUT,"*  *");
						when "0000110"|"0000111" =>
								write(LINE_OUT,"   *");
						when "0111001" =>
								write(LINE_OUT,"*   ");
						when others => write(LINE_OUT,"ERROR");
				end case LINE3NUM1;
				---------------------------------------
				wait for 50 ns;
				write(LINE_OUT," ");
				CLK <= '1';
				wait for 50 ns;
				LINE3NUM2:case Y is
						when "1011011"|"1001111"|"1100110"|"1101101"|"1111101"|
							  "1111111"|"1101111"|"1110111"|"1111100"|"1011110"|
							  "1111001"|"1110001" =>
								write(LINE_OUT,"****");
						when "0111111"=>
								write(LINE_OUT,"*  *");
						when "0000110"|"0000111" =>
								write(LINE_OUT,"   *");
						when "0111001" =>
								write(LINE_OUT,"*   ");
						when others => write(LINE_OUT,"ERROR");		
				end case LINE3NUM2;
				---------------------------------------
				wait for 50 ns;
				writeline(FILEOUT,LINE_OUT);
				wait for 50 ns;
				CLK <= '0';
				wait for 50 ns;
				LINE4NUM1:case Y is
						when "0111111"|"1111101"|"1111111"|"1110111"|"1111100"|"1011110" =>
								write(LINE_OUT,"*  *");
						when "0000110"|"1001111"|"1100110"|"1101101"|"0000111"|"1101111" =>
								write(LINE_OUT,"   *");
						when "1011011"|"0111001"|"1111001"|"1110001" =>
								write(LINE_OUT,"*   ");
						when others => write(LINE_OUT,"ERROR");
				end case LINE4NUM1;
				---------------------------------------
				wait for 50 ns;
				write(LINE_OUT," ");
				CLK <= '1';
				wait for 50 ns;
				LINE4NUM2:case Y is
						when "0111111"|"1111101"|"1111111"|"1110111"|"1111100"|"1011110" =>
								write(LINE_OUT,"*  *");
						when "0000110"|"1001111"|"1100110"|"1101101"|"0000111"|"1101111" =>
								write(LINE_OUT,"   *");
						when "1011011"|"0111001"|"1111001"|"1110001" =>
								write(LINE_OUT,"*   ");
						when others => write(LINE_OUT,"ERROR");
				end case LINE4NUM2;
				---------------------------------------
				wait for 50 ns;
				writeline(FILEOUT,LINE_OUT);
				wait for 50 ns;
				CLK <= '0';
				wait for 50 ns;
				LINE5NUM1:case Y is
						when "0111111"|"1011011"|"1001111"|"1101101"|"1111101"|"1111111"|
							  "1101111"|"1111100"|"0111001"|"1011110"|"1111001" =>
								write(LINE_OUT,"****");
						when "0000110"|"1100110"|"0000111" =>
								write(LINE_OUT,"   *");
						when "1110111" =>
								write(LINE_OUT,"*  *");
						when "1110001" =>
								write(LINE_OUT,"*   ");
						when others => write(LINE_OUT,"ERROR");
				end case LINE5NUM1;
				---------------------------------------
				wait for 50 ns;
				write(LINE_OUT," ");
				CLK <= '1';
				wait for 50 ns;
				LINE5NUM2:case Y is
						when "0111111"|"1011011"|"1001111"|"1101101"|"1111101"|"1111111"|
							  "1101111"|"1111100"|"0111001"|"1011110"|"1111001" =>
								write(LINE_OUT,"****");
						when "0000110"|"1100110"|"0000111" =>
								write(LINE_OUT,"   *");
						when "1110111" =>
								write(LINE_OUT,"*  *");
						when "1110001" =>
								write(LINE_OUT,"*   ");
						when others => write(LINE_OUT,"ERROR");
				end case LINE5NUM2;
				---------------------------------------
				wait for 50 ns;
				writeline(FILEOUT,LINE_OUT);
				wait for 50 ns;
				write(LINE_OUT," ");
				wait for 50 ns;
				writeline(FILEOUT,LINE_OUT);
		end loop;
		wait;
		end process TEST;
end Behavirual;