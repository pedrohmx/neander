------------------------------------------------------------
-- regc.vhdl - Registradores com carga
------------------------------------------------------------
-- regc1b
library IEEE;
use IEEE.std_logic_1164.all;

entity regc1b is
	port (
		d      : in  std_logic;
		rw     : in  std_logic;
		clk    : in  std_logic;
		pr, cl : in  std_logic;
		s      : out std_logic
	);
end entity regc1b;
architecture behaviour of regc1b is
	component ffd is
		port (
			d       : in  std_logic; -- entrada d
			clk     : in  std_logic; -- clock
			pr, cl  : in  std_logic; -- preset e clear
			q, nq   : out std_logic  -- q e nao-q
		);
	end component;

	signal sd  : std_logic;
	signal sq  : std_logic;
	signal snq : std_logic;
begin
	-- mux
	sd <= d when rw = '1' else sq;
	u_ffd: ffd port map(sd, clk, pr, cl, sq, snq);
	s  <= sq;
end architecture behaviour;
------------------------------------------------------------
--  regc2b
library IEEE;
use IEEE.std_logic_1164.all;

entity regc2b is
	port (
		d      : in  std_logic_vector(1 downto 0);
		rw     : in  std_logic;
		clk    : in  std_logic;
		pr, cl : in  std_logic;
		s      : out std_logic_vector(1 downto 0)
	);
end entity regc2b;
architecture behaviour of regc2b is
	component regc1b is
		port (
			d      : in  std_logic;
			rw     : in  std_logic;
			clk    : in  std_logic;
			pr, cl : in  std_logic;
			s      : out std_logic
		);
	end component;
begin
	gen_r : for i in 1 downto 0 generate
		rx : regc1b port map(
			d(i), rw, clk, pr, cl, s(i)
		);
	end generate gen_r;
end architecture behaviour;
------------------------------------------------------------
--  regc8b
library IEEE;
use IEEE.std_logic_1164.all;

entity regc8b is
	port (
		d      : in  std_logic_vector(7 downto 0);
		rw     : in  std_logic;
		clk    : in  std_logic;
		pr, cl : in  std_logic;
		s      : out std_logic_vector(7 downto 0)
	);
end entity regc8b;
architecture behaviour of regc8b is
	component regc1b is
		port (
			d      : in  std_logic;
			rw     : in  std_logic;
			clk    : in  std_logic;
			pr, cl : in  std_logic;
			s      : out std_logic
		);
	end component;
begin
	gen_r : for i in 7 downto 0 generate
		rx : regc1b port map(
			d(i), rw, clk, pr, cl, s(i)
		);
	end generate gen_r;
end architecture behaviour;
