------------------------------------------------------------
--	Counters - Test bench
------------------------------------------------------------
--	Counter 3 bits - Test Bench
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity tb_counter3b is
end entity tb_counter3b;
architecture tb_behaviour of tb_counter3b is
	constant clock : time := 10 ns;
	component counter3b is
		port (
			clk, cl : in std_logic;
			s : out std_logic_vector(2 downto 0)
		);
	end component;
	signal s_clk : std_logic := '0';
	signal s_cl : std_logic;
	signal s_count : std_logic_vector(2 downto 0);
begin
	s_clk <= not(s_clk) after clock / 2;
	
	u_c3b : counter3b port map(s_clk,s_cl,s_count);
	
	tb : process begin
		s_cl <= '0';
		wait for clock;
		
		s_cl <= '1';
		wait;

	end process;
	
end architecture tb_behaviour;
