library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity comparator is
	port(A,B:in std_logic;
	Y:out std_logic);
end comparator;
architecture arh1 of comparator is
begin
	process(A,B)
	begin
		if(A>B)
			then Y<='1';
		elsif(A=B) then 
			Y<='0';
		end if;
		end process;
end architecture arh1;
		