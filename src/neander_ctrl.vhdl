------------------------------------------------------------
--	Neander - Modulo de Controle
------------------------------------------------------------
--	Componentes
--		PC (RIP - Registrador de ponteiro de funcao)
--		RI (IR - Registrador de instrução)
--		Decodificador (Decode)
------------------------------------------------------------
--	RIP
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RIP is
	port (
		barramento : in std_logic_vector(7 downto 0);
		--
		barr_inc : in std_logic;
		pc_rw : in std_logic;
		--
		clk, cl : in std_logic;
		--
		addr_out : out std_logic_vector(7 downto 0)
	);
end entity RIP;
architecture behaviour of RIP is
	component fAdder8b is
		port (
			A, B : in  std_logic_vector(7 downto 0);
			Cin  : in  std_logic;
			Cout : out std_logic;
			S    : out std_logic_vector(7 downto 0)
		);
	end component;
	component regc8b is
		port (
			d      : in  std_logic_vector(7 downto 0);
			rw     : in  std_logic;
			clk    : in  std_logic;
			pr, cl : in  std_logic;
			s      : out std_logic_vector(7 downto 0)
		);
	end component;
	signal sadd, s_mux2pc, s_PCatual : std_logic_vector(7 downto 0);
	signal cout : std_logic;
begin
	u_fa8b : fAdder8b port map(
		"00000001", s_PCatual, '0', cout, sadd
	);
	-- mux
	s_mux2pc <= barramento when barr_inc = '0' else sadd;
	u_reg_pc : regc8b port map(
		s_mux2pc, pc_rw, clk, '1', cl, s_PCatual
	);
	addr_out <= s_PCatual;
end architecture behaviour;
------------------------------------------------------------
--	Decoder
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decoder is
	port (
		instr_in : in std_logic_vector(7 downto 0);
		instr_out : out std_logic_vector(10 downto 0)
	);
end entity decoder;
architecture behaviour of decoder is
begin
	-- big wall of 0s
	with instr_in(7 downto 4) select instr_out <=
		"10000000000" when "0000",--NOP
		"01000000000" when "0001",--STA
		"00100000000" when "0010",--LDS
		"00010000000" when "0011",--ADD
		"00001000000" when "0100",--OR
		"00000100000" when "0101",--AND
		"00000010000" when "0110",--NOT
		"00000001000" when "1000",--JMP
		"00000000100" when "1001",--JN
		"00000000010" when "1010",--JZ
		"00000000001" when "1111",--HLT
		"00000000000" when others;
end architecture behaviour;
------------------------------------------------------------
--	UC
------------------------------------------------------------
--	Modulo de controle
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CTRL is
	port (
		barr_di : in std_logic_vector(7 downto 0);
		nz : in std_logic_vector(1 downto 0);
		barr_crtl : out std_logic_vector(10 downto 0)
	);
end entity CTRL;
architecture behaviour of CTRL is
	component regc8b is
		port (
			d      : in  std_logic_vector(7 downto 0);
			rw     : in  std_logic;
			clk    : in  std_logic;
			pr, cl : in  std_logic;
			s      : out std_logic_vector(7 downto 0)
		);
	end component;
	--signal s_decoded 
begin
	
end architecture behaviour;
------------------------------------------------------------
