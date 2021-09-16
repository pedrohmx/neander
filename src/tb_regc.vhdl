library ieee;
use ieee.std_logic_1164.all;

entity tb_regc8b is
    -- testbench
end entity tb_regc8b;

architecture tb_behavior of tb_regc8b is
constant relogio 	: time 	:= 10 ns;

component regc8b is
	port (
		d      : in  std_logic_vector(7 downto 0);
		rw     : in  std_logic;
		clk    : in  std_logic;
		pr, cl : in  std_logic;
		s      : out std_logic_vector(7 downto 0)
	);
end component regc8b;

signal s_d        : std_logic_vector(7 downto 0);
signal s_rw       : std_logic;
signal s_clk      : std_logic :='0';
signal s_pr, s_cl : std_logic;
signal s_s        : std_logic_vector(7 downto 0);

begin
    s_clk <= not(s_clk) after relogio / 2;
    u_regc: regc8b port map(
        s_d, s_rw, s_clk, s_pr, s_cl, s_s
    );

    tb: process
    begin
        
        s_d   <= "00001111";
        s_rw  <= '0';
        s_pr  <= '1';
        s_cl  <= '0';
        wait for relogio;

        s_rw  <= '1';
        s_cl  <= '1';
        wait for relogio;

        wait;
    end process;
end architecture;