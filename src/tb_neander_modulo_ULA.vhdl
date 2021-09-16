library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_neander_modulo_ULA is
    -- testbench
end entity tb_neander_modulo_ULA;

architecture tb_behavior of tb_neander_modulo_ULA is
constant relogio 	: time 	:= 10 ns;

component modulo_ULA is
	port (
		barramento : inout std_logic_vector(7 downto 0);
		ula_op     : in std_logic_vector(2 downto 0);
		ac_rw      : in std_logic;
		mem_rw     : in std_logic;
		clk        : in std_logic;
		cl         : in std_logic;
		flags      : out std_logic_vector(1 downto 0)
	);
end component modulo_ULA;

signal s_barramento : std_logic_vector(7 downto 0);
signal s_ula_op     : std_logic_vector(2 downto 0);
signal s_ac_rw      : std_logic;
signal s_mem_rw     : std_logic;
signal s_clk        : std_logic := '0';
signal s_cl         : std_logic;
signal s_flags      : std_logic_vector(1 downto 0);

begin
    s_clk <= not(s_clk) after relogio / 2;

    u_modulo_ULA: modulo_ULA port map(
        s_barramento, s_ula_op, s_ac_rw, s_mem_rw, s_clk, s_cl, s_flags
    );
    -- 000 - LDA
    -- 001 - ADD
    -- 010 - OR
    -- 011 - AND
    -- 100 - NOT

    

    tb: process
    begin
        s_barramento <= "00000000";
        s_ula_op <= "000"; ---load
        s_ac_rw <= '0';
        s_mem_rw <= '0';
        --s_clk <=
        s_cl <= '0';
        wait for relogio;

        s_cl <= '1';
        -- escrevendo o barramento em AC
        s_ac_rw <= '1';
        wait for relogio;

        s_barramento <= "00000101";
        s_ula_op <= "001";
        -- somando 5
        wait for relogio;

        s_barramento <= "00011100";
        s_ula_op <= "010";
        -- op OR tem que ver
        wait for relogio;

        s_barramento <= "10001100"; -- esperamos que no AC esteja 00011101
        s_ula_op <= "011";
        -- op AND
        wait for relogio;

        s_ula_op <= "100";
        -- op NOT
        wait for relogio;

        wait;
    end process;
end architecture;