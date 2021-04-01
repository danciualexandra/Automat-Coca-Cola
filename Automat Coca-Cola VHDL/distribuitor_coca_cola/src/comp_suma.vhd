library ieee;
use ieee.std_logic_1164.all;
entity comp_suma is
	port(A:in std_logic_vector(4 downto 0);
	B:in std_logic_vector(4 downto 0):="10100";
	Suc:out std_logic;
	RM:out std_logic_vector(4 downto 0));
end comp_suma;
architecture arh1 of comp_suma is
component scazator is
   port
   (A,B: in std_logic_vector(4 downto 0);
   dif: out std_logic_vector(4 downto 0));
end component;
signal q,Rest:std_logic_vector(4 downto 0);
constant M5:std_logic_vector(4 downto 0):="10100";
begin  
	process(A,B)
	begin
		if(A<B)
			then RM<=A;
			Suc<='0';
		elsif(A=B) 
			then Suc<='1';
			RM<="00000";
		elsif(A>B) then
			RM<="00000";
			Suc<='1';
		end if;
		end process;
end architecture arh1;
		