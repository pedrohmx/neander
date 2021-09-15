------------------------------------------------------------
-- mux.vhdl - Multiplexadores
------------------------------------------------------------
-- 2x1
library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1 is
	port(
		C0 : in  std_logic;
		C1 : in  std_logic;
		S  : in  std_logic;
		Z  : out std_logic
	);
end entity mux_2x1;
architecture behaviour of mux_2x1 is
begin
	Z <= C0 when S = '0' else C1;
end architecture behaviour;
------------------------------------------------------------
-- 2x8
library ieee;
use ieee.std_logic_1164.all;

entity mux_2x8 is
	port(
		C0 : in  std_logic_vector(7 downto 0);
		C1 : in  std_logic_vector(7 downto 0);
		S  : in  std_logic;
		Z  : out std_logic_vector(7 downto 0)
	);
end entity mux_2x8;
architecture behaviour of mux_2x8 is
begin
	Z <= C0 when S = '0' else C1;
end architecture behaviour;
------------------------------------------------------------
-- 5x8
library ieee;
use ieee.std_logic_1164.all;

entity mux_5x8 is
	port(
		C000 : in  std_logic_vector(7 downto 0);
		C001 : in  std_logic_vector(7 downto 0);
		C010 : in  std_logic_vector(7 downto 0);
		C011 : in  std_logic_vector(7 downto 0);
		C100 : in  std_logic_vector(7 downto 0);
		S  : in  std_logic_vector(2 downto 0);
		Z  : out std_logic_vector(7 downto 0)
	);
end entity mux_5x8;
architecture behaviour of mux_5x8 is
begin
	with S select
	Z <= C000 when "000",
		C001 when "001",
		C010 when "010",
		C011 when "011",
		C100 when others;--,
		--x"00" when others;
end architecture behaviour;
------------------------------------------------------------
