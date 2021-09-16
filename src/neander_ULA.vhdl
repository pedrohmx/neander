------------------------------------------------------------
--	Neander - Modulo de ULA
------------------------------------------------------------
--	Componentes
--		reg AC
--		reg FLAGS
--		ULA
------------------------------------------------------------
--  ULA
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ULA is
	port (
		X, Y : in  std_logic_vector(7 downto 0);
		OP : in std_logic_vector(2 downto 0);
		NZ : out std_logic_vector(1 downto 0);
		S : out  std_logic_vector(7 downto 0)
	);
end entity ULA;
architecture behaviour of ULA is
	component not8b is 
		port (
			A :  in std_logic_vector( 7 downto 0 );
			S : out std_logic_vector( 7 downto 0 )
		);
	end component;
	component and8b is
		port (
			A , B :  in std_logic_vector( 7 downto 0 );
			S     : out std_logic_vector( 7 downto 0 )
		);
	end component;
	component or8b is
		port (
			A , B :  in std_logic_vector( 7 downto 0 );
			S     : out std_logic_vector( 7 downto 0 )
		);
	end component;
	component fAdder8b is
		port (
			A, B : in  std_logic_vector(7 downto 0); -- inputs
			Cin  : in  std_logic; -- carry in
			Cout : out std_logic; -- carry out
			S    : out std_logic_vector(7 downto 0)  -- output
		);
	end component;
	component mux_5x8 is
		port(
			C000 : in  std_logic_vector(7 downto 0);
			C001 : in  std_logic_vector(7 downto 0);
			C010 : in  std_logic_vector(7 downto 0);
			C011 : in  std_logic_vector(7 downto 0);
			C100 : in  std_logic_vector(7 downto 0);
			S  : in  std_logic_vector(2 downto 0);
			Z  : out std_logic_vector(7 downto 0)
		);
	end component;

	signal snot, sand, sor, sadd : std_logic_vector(7 downto 0);
	signal sres: std_logic_vector(7 downto 0);
	-- carry out
	signal sco : std_logic;
begin
	u_not: not8b    port map (X,    snot);
	u_and: and8b    port map (X, Y, sand);
	u_or : or8b     port map (X, Y,  sor);
	u_add: fAdder8b port map (X, Y, '0', sco, sadd);
	u_mux: mux_5x8  port map (
		Y, sadd, sor, sand, snot, OP, sres
	);
	NZ(0) <= '1' when sres = "00000000" else '0';
	NZ(1) <= sres(7);
	S <= sres;
	
end architecture behaviour;
------------------------------------------------------------
--  Modulo ULA
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity modulo_ULA is
	port (
		barramento : inout std_logic_vector(7 downto 0);
		ula_op : in std_logic_vector(2 downto 0);
		ac_rw : in std_logic;
		mem_rw : in std_logic;

		clk : in std_logic;
		cl : in std_logic;

		flags : out std_logic_vector(1 downto 0)
	);
end entity modulo_ULA;
architecture behaviour of modulo_ULA is
	--  registers - ac and flags
	component regc8b is
		port (
			d      : in  std_logic_vector(7 downto 0);
			rw     : in  std_logic;
			clk    : in  std_logic;
			pr, cl : in  std_logic;
			s      : out std_logic_vector(7 downto 0)
		);
	end component;
	component regc2b is
		port (
			d      : in  std_logic_vector(1 downto 0);
			rw     : in  std_logic;
			clk    : in  std_logic;
			pr, cl : in  std_logic;
			s      : out std_logic_vector(1 downto 0)
		);
	end component;
	component ULA is
		port (
			X, Y : in  std_logic_vector(7 downto 0);
			OP : in std_logic_vector(2 downto 0);
			NZ : out std_logic_vector(1 downto 0);
			S : out  std_logic_vector(7 downto 0)
		);
	end component;
	--  signals
	signal s_ac2flags : std_logic_vector(1 downto 0);
	signal s_ac2ula : std_logic_vector(7 downto 0);
	signal s_ula2ac : std_logic_vector(7 downto 0);
begin
	-- mux2x8z especial
	barramento <= s_ac2ula when mem_rw = '1' else (others => 'Z');

	u_reg_ac : regc8b port map(
		--  pr always on
		s_ula2ac,   ac_rw, clk, '1', cl, s_ac2ula
	);
	
	u_reg_flags : regc2b port map(
		s_ac2flags, ac_rw, clk, '1', cl, flags
	);
	
	u_ula : ULA port map(
		s_ac2ula, barramento, ula_op, s_ac2flags, s_ula2ac
	);

end architecture behaviour;