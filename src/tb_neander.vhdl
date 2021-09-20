library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_neander is
    -- testbench
end entity tb_neander;
architecture tb_behavior of tb_neander is
    constant relogio 	: time 	:= 10 ns;
    component neander is
        port (
            cl, clk : in std_logic
            );
    end component neander;
    signal s_clk : std_logic :='0';
    signal s_cl : std_logic;
begin
    s_clk <= not(s_clk) after relogio / 2;
    u_cur: neander port map(
        s_cl, s_clk
    );

    tb : process
    begin
        s_cl <= '0';
        wait for relogio;
        wait for relogio;
        
        s_cl <= '1';

       -- wait for relogio;
        wait;
    end process;
end architecture;
