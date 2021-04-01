library ieee;
use ieee.std_logic_1164.all;
entity mux is
	port(A:in std_logic_vector(4 downto 0):="00001";
	B:in std_logic_vector(4 downto 0):="00010";
	C:in std_logic_vector(4 downto 0):="01010";
	D:in std_logic_vector(4 downto 0):="00000";
	E:in std_logic_vector(4 downto 0):="00000";
	F:in std_logic_vector(4 downto 0):="00000";
	G:in std_logic_vector(4 downto 0):="00000";
	H:in std_logic_vector(4 downto 0):="00000";
	S:in std_logic_vector(2 downto 0);
	Y:out std_logic_vector(4 downto 0));
end mux;
architecture arh1 of mux is	 
begin
	process(a,s)
	begin
		case S is
			when"100"=>Y<=C;
			when"010"=>Y<=B;
			when"001"=>Y<=A;
			when"101"=>Y<=D;
			when"011"=>Y<=E;
			when"111"=>Y<=F;
			when"000"=>Y<=G;
			when"110"=>Y<=H;
			when OTHERS=>
			Y<="00000";
		end case;
	end process;
end arh1;
		


