library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_mem is
end entity tb_mem;

architecture tb_behavior of tb_mem is
    constant relogio     : time     := 10 ns;
    component modulo_MEM is
        port (
            barramento : inout std_logic_vector(7 downto 0);
            addr_barr  : in std_logic_vector(7 downto 0);
            addr_pc    : in std_logic_vector(7 downto 0);
            barrPC     : in std_logic;
            rem_rw     : in std_logic;
            mem_rw     : in std_logic;
            rdm_rw     : in std_logic;
            clk        : in std_logic;
            cl         : in std_logic
        );
    end component modulo_MEM;
    signal s_barramento : std_logic_vector(7 downto 0);
    signal s_addr_pc    : std_logic_vector(7 downto 0);
    signal s_barrPC     : std_logic;
    signal s_rem_rw     : std_logic;
    signal s_mem_rw     : std_logic;
    signal s_rdm_rw     : std_logic;
    signal s_clk        : std_logic := '0';
    signal s_cl         : std_logic;
    --
    --signal barr_crtl    : std_logic_vector(10 downto 0);
begin
    s_clk <= not(s_clk) after relogio / 2;
    
    u_modulo_mem: modulo_MEM port map(
        s_barramento, s_barramento, s_addr_pc, 
        s_barrPC, s_rem_rw, s_mem_rw, s_rdm_rw, 
        s_clk, s_cl
    );

    tb: process
    begin
        --leitura da instruçao do endereço 0
        s_barramento <= "ZZZZZZZZ";
        s_addr_pc    <= "00000000";

        s_barrPC <= '0';
        s_rem_rw <= '0';
        s_mem_rw <= '0';
        s_rdm_rw <= '0';

        s_cl <='0';
        wait for relogio;
        s_cl <='1';

        s_barrPC <= '1';
        s_rem_rw <= '1';
        wait for relogio;

        s_rem_rw <= '0';
        s_rdm_rw <= '1';
        wait for relogio;

        s_rdm_rw <= '0';
        wait for relogio;

        s_barrPC <= '0';
        wait for relogio;

        --leitura de dados do endereco 130
        --s_addr_pc <= "10000010";
        --s_barrPC <= '0';
        --s_mem_rw <= '0';
        --wait for relogio;

        --s_rem_rw <= '1';
        --wait for relogio;

        --s_rem_rw <= '0';
        --s_rdm_rw <= '1';
        --wait for relogio;

        --s_rdm_rw <= '0';
        --wait for relogio;

        wait;
    end process;
end architecture;