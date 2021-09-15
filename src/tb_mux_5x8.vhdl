library ieee;
use ieee.std_logic_1164.all;

entity tb_mux_5x8 is
    -- testbench
end entity tb_mux_5x8;

architecture tb_behavior of tb_mux_5x8 is
constant relogio 	: time 	:= 10 ns;

component mux_5x8 is
	port(
		C000 : in  std_logic_vector(7 downto 0);
		C001 : in  std_logic_vector(7 downto 0);
		C010 : in  std_logic_vector(7 downto 0);
		C011 : in  std_logic_vector(7 downto 0);
		C100 : in  std_logic_vector(7 downto 0);
		S    : in  std_logic_vector(2 downto 0);
		Z    : out std_logic_vector(7 downto 0)
	);
end component mux_5x8;

signal s_C000 : std_logic_vector(7 downto 0);
signal s_C001 : std_logic_vector(7 downto 0);
signal s_C010 : std_logic_vector(7 downto 0);
signal s_C011 : std_logic_vector(7 downto 0);
signal s_C100 : std_logic_vector(7 downto 0);
signal s_S    : std_logic_vector(2 downto 0);
signal s_Z    : std_logic_vector(7 downto 0);

begin
    u_mux : mux_5x8 port map(
        s_C000, s_C001, s_C010, s_C011, s_C100, s_S, s_Z
    );

    tb: process
    begin
        s_C000 <= "00000000";
        s_C001 <= "00000001";
        s_C010 <= "00101100";
        s_C011 <= "11111111";
        s_C100 <= "01010101";
        s_S    <= "000";
        wait for relogio;

        s_S    <= "001";
        wait for relogio;
		
        s_S    <= "010";
        wait for relogio;

        s_S    <= "011";
        wait for relogio;

        s_S    <= "100";
        wait for relogio;

        s_S    <= "111";
        wait for relogio;

        wait;
    end process;
end architecture;
