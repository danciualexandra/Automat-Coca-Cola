library ieee;

use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
entity distribuitor is
	port(A:in std_logic_vector(3 downto 0);
	Nr_sucuri:in std_logic;
	CLK:in std_logic;
	Button:in std_logic;
	Rest:out std_logic_vector(4 downto 0):="00000";
	Suc:out std_logic;
	RM:out std_logic_vector(4 downto 0):="00000";
	FS:out std_logic;
	AT:out std_logic;
	AM:out std_logic;
	F3:out std_logic);
end distribuitor;
architecture arh_dis of distribuitor is
component comparator is
	port(A,B:in std_logic;
	Y:out std_logic);
end component;
component COMP_5 is
	port(A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	q: out std_logic);
end component;
component COMP_10 is
	port(A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	q: OUT std_logic);
end component;
component COMP_50 is
	port(A: in std_logic_vector(3 downto 0);
	B: in std_logic_vector(3 downto 0);
	q: OUT std_logic);
end component;
component mux is
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
end component;
component comp_suma is
	port(A,B:in std_logic_vector(4 downto 0);
	Suc:out std_logic;
	RM:out std_logic_vector(4 downto 0));
end component;
component reg is
	port(iEnable:in std_logic;
	 CLK:in std_logic;
	 Reset:in std_logic;
	 iData:in std_logic_vector(4 downto 0);
	 oData:out std_logic_vector(4 downto 0));
end component;
component sumator is
   port
   (A, B : in std_logic_vector(4 downto 0); 
   sum: out std_logic_vector(4 downto 0));
end component;
component scazator is
   port
   (A,B: in std_logic_vector(4 downto 0);
   dif: out std_logic_vector(4 downto 0));
end component;
component buton is
	port(A:in std_logic;
	Y:out std_logic);
end component;
constant M1:integer:=0;
constant F0:std_logic_vector(3 downto 0):="0001";-- moneda de 5 bani
constant F1:std_logic_vector(3 downto 0):="0010";-- moneda de 10 bani
constant F2:std_logic_vector(3 downto 0):="1010";-- moneda de 50 de bani
constant M5:std_logic_vector(4 downto 0):="10100";-- pretul sucului de 100 de bani
signal p2,p3,p4:std_logic;
signal a1:std_logic_vector(4 downto 0):="00001";  --intrare mux semnificand moneda de 5 bani
signal a2:std_logic_vector(4 downto 0):="00010";  --intrare mux semnificand moneda de 10 bani
signal a3:std_logic_vector(4 downto 0):="01010";  --intrare mux semnificand moneda de 50 bani
signal a4,a5,a6,a7,a8:std_logic_vector(4 downto 0):="00000";--restul intrarilor mux care vor fi 0 bani
signal a0:std_logic_vector(4 downto 0);
signal sum:std_logic_vector(4 downto 0);
signal s:std_logic_vector(2 downto 0);
signal q:std_logic_vector(4 downto 0);-- suma introdusa
signal Rest1:std_logic_vector(4 downto 0); 
signal nr0:std_logic:='0';
signal rm1:std_logic_vector(4 downto 0);
signal R,Enable:std_logic;
begin 
	C0:comparator port map(Nr_sucuri,nr0,Enable);
	C1:COMP_5 port map(A,F0,p2);
	C2:COMP_10 port map(A,F1,p3);
	C3:COMP_50 port map(A,F2,p4);
	C4:mux port map(a1,a2,a3,a4,a5,a6,a7,a8,s,a0);
	C5:sumator port map(a0,q,sum);
	C6:reg port map(Enable,CLK,R,sum,q);
	C7:comp_suma port map(q,M5,Suc,rm1);
	C8:scazator port map(q,M5,Rest1);
	C9:buton port map(Button,Enable);  
	
	process(CLK)
	begin 
		if(Nr_sucuri=nr0) then
			FS<='1';
			RM(3 downto 0)<=A; --daca nu exista sucuri atunci se variable activa iesirea FS,iar orice moneda introdusa va fi returnata
		else
			FS<='0';
		end if;
		if(Button='1') then
			AT<='1';
			RM<=q;
			R<='1' after 100 ns;                      --Button semnifica faptul ca utilizatorul s-a oprit din introdus monede(in cazul in care suma este mai mica decat pretul)
								  --Este folosit pentru cazul in care utilizatorul a introdus o suma mai mica decat pretul si doreste sa-i fie returnata
		elsif(q>M5) then
		Enable<='0';		 --Daca suma introdusa depaseste pretul dupa o anumita moneda acesta nu mai accepta monezi signal returneaza sucul impreuna cu restul
		AT<='1';             --Aceasta tactica a fost folosita pentru a nu lasa utilizatorul sa introduca monede la nesfarsit(este o metoda de optimizare)
		Rest<=Rest1;
		R<='1' after 100 ns;
		elsif(q=M5) then	 --Daca suma introdusa este egala cu pretul se elibereaza sucul
			Enable<='0';
			AT<='1';
			R<='1' after 100 ns;
		else
			Enable<='1';
			AT<='0';
			R<='0';
			Rest<="00000";
		end if;
	if CLK='1' and CLK'event then
		if(p2='1') then			  --Verificam daca moneda introdusa este de 5 bani;daca da atunci pe iesirea muxului variable fi "00001"(5 bani)
			AM<='1';
			F3<='0';
			a0<=a1; --iesire mux
			s(0)<=p2;
			s(1)<='0';
			s(2)<='0';
		elsif(p3='1') then	       --Verificam daca moneda introdusa este de 10 bani;daca da atunci pe iesirea muxului variable fi "00010"(10 bani)
			AM<='1';
			F3<='0';
			a0<=a2;	   --iesire mux
			s(1)<=p3;
			s(2)<='0';
			s(0)<='0';
		elsif(p4='1') then	       --Verificam daca moneda introdusa este de 50 bani;daca da atunci pe iesirea muxului variable fi "01010"(10 bani) 
			AM<='1';
			F3<='0';
			a0<=a3;
			s(2)<=p4; 
			s(1)<='0';
			s(0)<='0';
		else
			AM<='0';				--Daca moneda introdusa nu este una din cele acceptare de distribuitor atunci pe iesirea muxului va fi "00000"(0 bani)
			F3<='1';                 
			s(2)<='0';
			s(1)<='0';
			s(0)<='0';
			a0<=a4;				   --Nu se va adauga la suma moneda introdusa
			RM(3 downto 0)<=A;		--Moneda este returnata
		end if;
	end if;
	end process;
end arh_dis;