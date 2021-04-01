library ieee;
use ieee.std_logic_1164.all;
entity buton is
	port(A:in std_logic;
	Y:out std_logic);
end entity;
architecture arh_buton of buton is
begin 
	Y<=not A;
end architecture;
	
