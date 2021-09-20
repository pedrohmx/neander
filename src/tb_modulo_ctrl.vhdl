library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_ctrl is
	-- test bench
end entity tb_ctrl;
architecture tb_mctrl of tb_ctrl is
	constant relogio 	: time 	:= 10 ns;
	component CTRL is
		port (
			barr_di : in std_logic_vector(7 downto 0);
			nz : in std_logic_vector(1 downto 0);
			clk, cl : in std_logic;
			barr_ctrl : out std_logic_vector(10 downto 0)
		);
	end component;
	signal s_clk        : std_logic := '0';
	signal s_cl         : std_logic;
	signal s_barr_di : std_logic_vector(7 downto 0);
	signal s_flags_nz : std_logic_vector(1 downto 0);
	signal s_barr_ctrl : std_logic_vector(10 downto 0);
begin
	s_clk <= not(s_clk) after relogio / 2;

	u_ctrl : ctrl port map(
		s_barr_di, s_flags_nz, s_clk, s_cl, s_barr_ctrl
	);
	
	tb : process
	begin
		s_barr_di <= "ZZZZZZZZ";
		s_flags_nz <= "00";
		s_cl <= '0';
		wait for relogio;
		wait for relogio;
		s_cl <= '1';
		s_barr_di <= "00000000"; -- NOP
		wait for 8 * relogio;
		s_barr_di <= "00010000"; -- STA
		wait for 8 * relogio;
		s_barr_di <= "00100000"; -- LDA
		wait for 8 * relogio;
		s_barr_di <= "00110000"; -- ADD
		wait for 8 * relogio;
		s_barr_di <= "01000000"; -- OR
		wait for 8 * relogio;
		s_barr_di <= "01010000"; -- AND
		wait for 8 * relogio;
		s_barr_di <= "01100000"; -- NOT
		wait for 8 * relogio;
		s_barr_di <= "10000000"; -- JMP
		wait for 8 * relogio;
		s_barr_di <= "10010000"; -- JN
		wait for 8 * relogio;
		s_flags_nz <= "11";
		wait for 8 * relogio;
		s_flags_nz <= "00";
		s_barr_di <= "10100000"; -- JZ
		wait for 8 * relogio;
		s_flags_nz <= "11";
		wait for 8 * relogio;
		s_barr_di <= "11110000"; -- HLT
		wait for 8 * relogio;
	end process;
end architecture tb_mctrl;
