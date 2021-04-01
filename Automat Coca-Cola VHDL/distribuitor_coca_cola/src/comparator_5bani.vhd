library IEEE; 
use ieee.std_logic_1164.all;
entity COMP_5 is
	port(A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0):="0001";
	q: OUT std_logic);
end COMP_5;

architecture ARH_Comportamentala of COMP_5 is
begin 
	process(A,B)
	begin
	if(A=B) then
		q<='1';	
	else
		q<='0';
	end if;
	end process;
end architecture ARH_Comportamentala;