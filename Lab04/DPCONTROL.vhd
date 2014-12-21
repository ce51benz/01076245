Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY DP_CONTROLLER is
	port(CLK,H,M:in STD_LOGIC;
	     COM:in STD_LOGIC_VECTOR(3 downto 0);
		  DP:out STD_LOGIC);
END DP_CONTROLLER;


ARCHITECTURE BEHAVIORUAL OF DP_CONTROLLER is
	signal DPSEL:STD_LOGIC_VECTOR(1 downto 0):="00";
BEGIN
	--DP CONTROLLER--------------------
	DPSEL(1)<=not(COM(3)) nor (not COM(0));
	DPSEL(0)<= H or M;		
	with DPSEL select
	DP<= '0' when "00"|"01",
	CLK when "10",
	'1' when others;
	-----------------------------------	  
END BEHAVIORUAL;