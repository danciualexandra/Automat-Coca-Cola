library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity scazator is
   port
   (A,B: in std_logic_vector(4 downto 0);
   dif: out std_logic_vector(4 downto 0));
end entity scazator;

architecture arh of scazator is
signal temp : std_logic_vector(4 downto 0);	
begin
process(A,B) 
variable Sa,Sb,Sq:integer;
begin
	Sa:=conv_integer(A);
	Sb:=conv_integer(B);
	Sq:=Sa-Sb;
   temp<=conv_std_logic_vector(Sq,5);
end process;
dif<=temp;
end architecture arh;
