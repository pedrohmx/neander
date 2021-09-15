library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_or8b is
-- testbench
end entity tb_or8b;

architecture tb_behavior of tb_or8b is
constant relogio 	: time 	:= 10 ns;

component or8b is
	port (
		A , B :  in std_logic_vector( 7 downto 0 );
		S     : out std_logic_vector( 7 downto 0 )
	);
end component or8b;

signal s_A, s_B, s_S : std_logic_vector(7 downto 0);

begin
    u_or: or8b port map(
        s_A, s_B, s_S
    );

    tb: process
    begin
        s_A <= "00100000";
        s_B <= "00000000";
        wait for relogio;

        s_A <= "00000000";
        s_B <= "00000001";
        wait for relogio;

        s_A <= "00000001";
        s_B <= "00000001";
        wait for relogio;

        s_A <= "10111111";
        s_B <= "11110111";
        wait for relogio;

        wait;
    end process;
end architecture;