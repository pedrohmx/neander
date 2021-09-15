library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_and8b is
-- testbench
end entity tb_and8b;

architecture tb_behavior of tb_and8b is
constant relogio 	: time 	:= 10 ns;

component and8b is
	port (
		A , B :  in std_logic_vector( 7 downto 0 );
		S     : out std_logic_vector( 7 downto 0 )
	);
end component and8b;

signal s_A, s_B, s_S : std_logic_vector(7 downto 0);

begin
    u_and: and8b port map(
        s_A, s_B, s_S
    );

    tb: process
    begin
        s_A <= "00000000";
        s_B <= "00000000";
        wait for relogio;

        s_A <= "00000000";
        s_B <= "00000001";
        wait for relogio;

        s_A <= "00000001";
        s_B <= "00000001";
        wait for relogio;

        s_A <= "11111111";
        s_B <= "11110111";
        wait for relogio;

        wait;
    end process;
end architecture;