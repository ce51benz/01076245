Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY DP_CONTROLLER is
	port(CLK,H,M,AM,VA,AH:in STD_LOGIC;
	     COM:in STD_LOGIC_VECTOR(3 downto 0);
		  DP:out STD_LOGIC);
END DP_CONTROLLER;


ARCHITECTURE BEHAVIORUAL OF DP_CONTROLLER is
	signal DPSEL:STD_LOGIC_VECTOR(2 downto 0):="000";
	signal ALARMVIEW:STD_LOGIC;
BEGIN
	--DP CONTROLLER--------------------
	ALARMVIEW <= (not AM) or (not AH) or (not VA);
	DPSEL(2) <= ALARMVIEW;
	DPSEL(1)<=not(COM(3)) nor (not COM(0));
	DPSEL(0)<= H or M;		
	with DPSEL select
	DP<= '0' when "000"|"001",
	CLK when "010",
	'1' when "110"|"111"|"011",
	'0' when others;
	-----------------------------------	  
END BEHAVIORUAL;