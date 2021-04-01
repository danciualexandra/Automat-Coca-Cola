library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity sumator is
   port
   (A,B: in std_logic_vector(4 downto 0);
   sum: out std_logic_vector(4 downto 0));
end entity sumator;
 
architecture arh of sumator is
signal temp : std_logic_vector(4 downto 0);	
begin
process(A,B) 
variable Sa,Sb,Sq:integer;
begin
	Sa:=conv_integer(A);
	Sb:=conv_integer(B);
	Sq:=Sa+Sb;
   --temp <= ("0" & A) + B; 
   -- OR use the following syntax:
   -- temp <= ('0' & nibble1) + ('0' & nibble2);
   temp<=conv_std_logic_vector(Sq,5);
   --sum       <= temp(3 downto 0); 
   --carry_out <= temp(4); 
end process;
sum<=temp;--(3 downto 0);
--carry_out<=temp(4);
end architecture arh;