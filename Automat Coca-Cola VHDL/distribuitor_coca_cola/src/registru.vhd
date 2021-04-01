 library ieee;
 use ieee.std_logic_1164.all;
 entity reg is
	 port(iEnable:in std_logic;
	 iData:in std_logic_vector(4 downto 0);	 
	 CLK:in std_logic;
	 Reset:in std_logic;
	 oData:out std_logic_vector(4 downto 0));
 end entity	;
 architecture arh of reg is	
 signal carry_out:std_logic;
begin
	process(CLK,Reset,iEnable)
	begin
	if(Reset='1') then
		oData<="00000";
	elsif(CLK='1') and (CLK'event) and(iEnable='1') then
	Odata<=iData; 
	end if;
	end process;
end arh;