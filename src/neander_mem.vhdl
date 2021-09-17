------------------------------------------------------------
--	Neander - Modulo de Memoria
------------------------------------------------------------
--	Componentes
--		reg RDM (MBR)
--		reg REM (MAR)
--		memoria
------------------------------------------------------------
--	Modulo Memoria
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity modulo_MEM is
	port (
		barramento : inout std_logic_vector(7 downto 0);
		--
		addr_barr : in std_logic_vector(7 downto 0);
		addr_pc : in std_logic_vector(7 downto 0);
		--
		barrPC : in std_logic;
		rem_rw : in std_logic;
		mem_rw : in std_logic;
		rdm_rw : in std_logic;
		--
		clk : in std_logic;
		cl : in std_logic
	);
end entity modulo_MEM;
architecture behaviour of modulo_MEM is
	component regc8b is
		port (
			d      : in  std_logic_vector(7 downto 0);
			rw     : in  std_logic;
			clk    : in  std_logic;
			pr, cl : in  std_logic;
			s      : out std_logic_vector(7 downto 0)
		);
	end component;
	component as_ram is
		port(
			addr  : in    std_logic_vector(7 downto 0);
			data  : inout std_logic_vector(7 downto 0);
			notrw : in    std_logic;
			reset : in    std_logic
		);
	end component as_ram;
	-- freestyle
	signal s_mux2rem : std_logic_vector(7 downto 0);
	signal     s_rem2mem : std_logic_vector(7 downto 0);
	signal         s_mem2rdm : std_logic_vector(7 downto 0);
	signal             s_rdm2barr : std_logic_vector(7 downto 0);
begin
	--  mux2x8z 2 memory boogaloo ft dante from dmc series
	barramento <= s_rdm2barr when mem_rw = '0' else (others => 'Z');
	s_mem2rdm  <= barramento when mem_rw = '1' else (others => 'Z');
	--  mux2x8
	s_mem2rdm <= addr_barr when barrPC = '0' else addr_pc;
	--  rem
	u_reg_rem : regc8b port map(
		s_mux2rem, rem_rw, clk, '1', cl, s_rem2mem
	);
	--  mem
	u_ram : as_ram port map(
		s_rem2mem, s_mem2rdm, mem_rw, cl
	);
	--  rdm
	u_reg_rdm : regc8b port map(
		s_mem2rdm, rdm_rw, clk, '1', cl, s_rdm2barr
	);
end architecture behaviour;
------------------------------------------------------------
