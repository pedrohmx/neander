------------------------------------------------------------
--	Counters
------------------------------------------------------------
--	Counter 3 bits
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity counter3b is
	port (
		clk, cl : in std_logic;
		s : out std_logic_vector(2 downto 0)
	);
end entity counter3b;
architecture behaviour of counter3b is
	component ffjk is
		port(
			j, k   : in  std_logic;
			clk    : in  std_logic;
			pr, cl : in  std_logic;
			q, nq  : out std_logic
		);
	end component;
	signal sj, sk : std_logic_vector(2 downto 0);
	signal sq, snq : std_logic_vector(2 downto 0);
begin
	gen_ffjk : for i in 0 to 2 generate
		ffjk_x : ffjk port map(
			sj(i), sk(i), clk, '1', cl, sq(i), snq(i)
		);
	end generate;
	
	sj(0) <= '1';
	sj(1) <= sq(0);
	sj(2) <= sq(0) and sq(1);
	
	sk(0) <= '1';
	sk(1) <= sq(0);
	sk(2) <= sq(0) and sq(1);

	s <= sq;
end architecture behaviour;
------------------------------------------------------------
