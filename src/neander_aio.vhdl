------------------------------------------------------------
--	Neander
------------------------------------------------------------
--	Componentes
--		Modulo ULA
--		Modulo Memoria
--		Modulo Controle
------------------------------------------------------------
--  Neander
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity neander is
	port (
		cl, clk : in std_logic
		);
end entity neander;
architecture behaviour of neander is
	component modulo_ULA is
		port (
			barramento : inout std_logic_vector(7 downto 0);
			ula_op : in std_logic_vector(2 downto 0);
			ac_rw : in std_logic;
			mem_rw : in std_logic;
			clk : in std_logic;
			cl : in std_logic;
			flags : out std_logic_vector(1 downto 0)
		);
	end component;
	component modulo_MEM is
		port (
			barramento : inout std_logic_vector(7 downto 0);
			addr_barr : in std_logic_vector(7 downto 0);
			addr_pc : in std_logic_vector(7 downto 0);
			barrPC : in std_logic;
			rem_rw : in std_logic;
			mem_rw : in std_logic;
			rdm_rw : in std_logic;
			clk : in std_logic;
			cl : in std_logic--;
		);
	end component;
	component RIP is
		port (
			barramento : in std_logic_vector(7 downto 0);
			barr_inc : in std_logic;
			pc_rw : in std_logic;
			clk, cl : in std_logic;
			addr_out : out std_logic_vector(7 downto 0)
		);
	end component;
	component CTRL is
		port (
			barr_di : in std_logic_vector(7 downto 0);
			nz : in std_logic_vector(1 downto 0);
			clk, cl : in std_logic;
			barr_ctrl : out std_logic_vector(10 downto 0)
		);
	end component;
	signal s_barr_di : std_logic_vector(7 downto 0);
	signal s_pc2mem : std_logic_vector(7 downto 0);
	signal s_nz : std_logic_vector(1 downto 0);
	--signal barr_ctrl : std_logic_vector(11 downto 0);
	signal s_barr_inc : std_logic;
	signal s_barr_pc : std_logic;
	signal s_ula_op : std_logic_vector(2 downto 0);
	signal s_pc_rw : std_logic;
	signal s_ac_rw : std_logic;
	signal s_mem_rw : std_logic;
	signal s_rem_rw : std_logic;
	signal s_rdm_rw : std_logic;
	signal s_ri_rw : std_logic;
begin
	u_m_ula : modulo_ULA port map(
		s_barr_di,
		s_ula_op, s_ac_rw, s_mem_rw,
		clk, cl,
		s_nz
	);
	u_m_mem : modulo_MEM port map(
		-- barramento e end_barr recebem o mesmo sinal
		-- porem, o barramento é inout apenas na interface de barr
		s_barr_di, s_barr_di, s_pc2mem,
		s_barr_pc, s_rem_rw, s_mem_rw, s_rdm_rw,
		clk, cl
	);
	u_m_rip : RIP port map(
		s_barr_di, s_barr_inc, s_pc_rw, clk, cl, s_pc2mem
	);
	u_m_ctrl : CTRL port map(
		barr_di => s_barr_di,
		nz => s_nz,
		clk => clk,
		cl => cl,
		-- desmontndo barramento de controle em varios sinais
		barr_ctrl(10) => s_barr_inc,
		barr_ctrl(9) => s_barr_pc,
		barr_ctrl(8 downto 6) => s_ula_op,
		barr_ctrl(5) => s_pc_rw,
		barr_ctrl(4) => s_ac_rw,
		barr_ctrl(3) => s_mem_rw,
		barr_ctrl(2) => s_rem_rw,
		barr_ctrl(1) => s_rdm_rw,
		barr_ctrl(0) => s_ri_rw
	);
end architecture behaviour;

------------------------------------------------------------
