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
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UC is
	port (
		dec2un : in std_logic_vector(10 downto 0);
		nz : in std_logic_vector(1 downto 0);
		clk, cl : in std_logic;
		barr_crtl_out : out std_logic_vector(10 downto 0)
	);
end entity UC;
architecture inferno of UC is
	component counter3b is
		port (
			clk, cl : in std_logic;
			s : out std_logic_vector(2 downto 0)
		);
	end component;
	component op_nop is
		port(
			ci : in std_logic_vector(2 downto 0);
			instr : out std_logic(10 downto 0)
		);
	end component;
	component op_sta is
		port(
			ci : in std_logic_vector(2 downto 0);
			instr : out std_logic(10 downto 0)
		);
	end component;
	component op_lda is
		port(
			ci : in std_logic_vector(2 downto 0);
			instr : out std_logic(10 downto 0)
		);
	end component;
	component op_add is
		port(
			ci : in std_logic_vector(2 downto 0);
			instr : out std_logic(10 downto 0)
		);
	end component;
	component op_and is
		port(
			ci : in std_logic_vector(2 downto 0);
			instr : out std_logic(10 downto 0)
		);
	end component;
	component op_or is
		port(
			ci : in std_logic_vector(2 downto 0);
			instr : out std_logic(10 downto 0)
		);
	end component;
	component op_not is
		port(
			ci : in std_logic_vector(2 downto 0);
			instr : out std_logic(10 downto 0)
		);
	end component;
	component op_jmp is
		port(
			ci : in std_logic_vector(2 downto 0);
			instr : out std_logic(10 downto 0)
		);
	end component;
	component op_jn is
		port(
			ci : in std_logic_vector(2 downto 0);
			n : in std_logic;
			instr : out std_logic(10 downto 0)
		);
	end component;
	component op_jz is
		port(
			ci : in std_logic_vector(2 downto 0);
			z : in std_logic;
			instr : out std_logic(10 downto 0)
		);
	end component;
	component op_hlt is
		port(
			ci : in std_logic_vector(2 downto 0);
			instr : out std_logic(10 downto 0)
		);
	end component;
	-- sinal de Ciclo de Instrucao
	signal CI : std_logic_vector(2 downto 0);
	signal snop, sstam, slda, sadd, sand, sor, snot, sjmp, sjn, sjz, shlt: std_logic_vector(10 downto 0);
begin
	u_c3b : counter3b port map(clk,cl,CI);
	-- TODO: modulo de micro operações
	--	NOP
	u_nop : op_nop port map(CI,snop);
	--	STA TODO:
	u_sta : op_sta port map(CI,ssta);
	--	LDA
	u_lda : op_lda port map(CI,slda);
	--	ADD TODO:
	u_add : op_add port map(CI,sadd);
	--	AND TODO:
	u_and : op_and port map(CI,sand);
	--	OR  TODO:
	u_or : op_or port map(CI,sor);
	--	NOT TODO:
	u_not : op_not port map(CI,snot);
	--	JMP TODO:
	u_jmp : op_jmp port map(CI,sjmp);
	--	JN  TODO:
	u_jn : op_jn port map(CI,nz(1),sjn);
	--	JZ  TODO:
	u_jz : op_jz port map(CI,nz(0),sjz);
	--	HLT
	u_hlt : op_hlt port map(CI,shlt);

	--	mux11x11 special
	with dec2un select barr_crtl_out <=
		snop  when "10000000000",
		sstam when "01000000000",
		slda  when "00100000000",
		sadd  when "00010000000",
		sand  when "00001000000",
		sor   when "00000100000",
		snot  when "00000010000",
		sjmp  when "00000001000",
		sjn   when "00000000100",
		sjz   when "00000000010",
		shlt  when "00000000001",
		"ZZZZZZZZZZZ" when others;
end architecture inferno;

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
	component decoder is
		port (
			instr_in : in std_logic_vector(7 downto 0);
			instr_out : out std_logic_vector(10 downto 0)
		);
	end component;
	component UC is
		port (
			dec2un : in std_logic_vector(10 downto 0);
			nz : in std_logic_vector(1 downto 0);
			clk, cl : in std_logic;
			barr_crtl_out : out std_logic_vector(10 downto 0)
		);
	end component;
	signal s_barr_crtl : std_logic_vector(10 downto 0);
	signal s_ri2dec : std_logic_vector(7 downto 0);
	signal    s_dec2uc : std_logic_vector(10 downto 0);
begin
	u_ri : regc8b port map(
		barr_di, s_barr_crtl(0), clk, '1', cl, s_ri2dec
	);
	u_dec : decoder port map(
		s_ri2dec, s_dec2uc
	);
	u_uc : UC port map(
		s_dec2uc, nz, clk, cl, s_barr_crtl
	);
	barr_crtl <= s_barr_crtl;
end architecture behaviour;
------------------------------------------------------------
