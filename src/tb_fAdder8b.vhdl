library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_fAdder8b is
-- testbench
end entity tb_fAdder8b;

architecture tb_behavior of tb_fAdder8b is
constant relogio 	: time 	:= 10 ns;

component fAdder8b is
	port (
		A, B : in  std_logic_vector(7 downto 0); -- inputs
		Cin  : in  std_logic; -- carry in
		Cout : out std_logic; -- carry out
		S    : out std_logic_vector(7 downto 0)  -- output
	);
end component fAdder8b;

signal s_A, s_B      : std_logic_vector(7 downto 0);
signal s_Cin, s_Cout : std_logic;
signal s_S           : std_logic_vector(7 downto 0);

begin
    u_fAdder: fAdder8b port map (
        s_A, s_B, s_Cin, s_Cout, s_S
    );
    
    tb: process
    begin
        s_A <= x"C3";
        s_B <= x"23";
        s_Cin <= '0';
        wait for relogio;

        s_A <= x"00";
        s_B <= x"EF";
        wait for relogio;

        s_A <= x"01";
        s_B <= x"FF";
        wait for relogio;

        wait;
    end process;
end architecture;
