------------------------------------------------------------
-- Mux - Multiplexadores
------------------------------------------------------------
-- 2x8

library ieee;
use ieee.std_logic_1164.all;

entity mux_2x8 is
	port(
		C1 : in  std_logic_vector(7 downto 0);
		C2 : in  std_logic_vector(7 downto 0);
		S  : in  std_logic;
		Z  : out std_logic_vector(7 downto 0)
	);
end mux_2x8;

architecture behavior of mux_2x8 is
begin

	Z <= C1 when S = '0' else C2;	

end architecture;
------------------------------------------------------------
-- 2x1

library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1 is
	port(
		C1 : in  std_logic;
		C2 : in  std_logic;
		S  : in  std_logic;
		Z  : out std_logic
	);
end mux_2x1;

architecture behavior of mux_2x1 is
begin

	Z <= C1 when S = '0' else C2;	

end architecture;
------------------------------------------------------------