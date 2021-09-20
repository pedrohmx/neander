library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_rip is
-- testbench
end entity tb_rip;

architecture tb_behavior of tb_rip is
	constant relogio    : time  := 10 ns;
	component RIP is
		port (
			barramento : in std_logic_vector(7 downto 0);
			barr_inc : in std_logic;
			pc_rw : in std_logic;
			clk, cl : in std_logic;
			addr_out : out std_logic_vector(7 downto 0)
		);
	end component RIP;
	signal s_barramento   : std_logic_vector(7 downto 0);
	signal s_barr_inc     : std_logic;
	signal s_pc_rw        : std_logic;
	signal s_clk          : std_logic :='0';
	signal s_cl           : std_logic;
	signal s_addr_out     : std_logic_vector(7 downto 0);
begin
    s_clk <= not(s_clk) after relogio / 2;
    
    u_rip: RIP port map(
        s_barramento, s_barr_inc, s_pc_rw, s_clk, s_cl, s_addr_out
    );

    tb : process
	begin
        s_barr_inc      <= '0';
        s_pc_rw         <= '0';
        s_barramento    <= "00001010";
        
		s_cl <= '0';
		wait for relogio;
		s_cl <= '1';
		
		-- deixar incrementando por um tempo
		s_barr_inc      <= '1';
        s_pc_rw         <= '1';
		wait for relogio;
		wait for relogio;
		-- para de escrever no registrador
        s_pc_rw         <= '0';
		wait for relogio;
		-- selecionamos um valor do barramento
		s_barramento <= "01101001";
		s_barr_inc <='0';
		wait for relogio;
		-- liberamos escrita no registrador
		s_pc_rw <= '1';
		wait for relogio;
		s_barramento <= "00001010";
		wait for relogio;
		-- voltamos a incrementar
		s_barr_inc <= '1';
		wait;
	end process;
end architecture;