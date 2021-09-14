------------------------------------------------------------
--  or.vhdl - OR opertation
------------------------------------------------------------
-- or1b --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity or1b is
	port (
		A , B :  in std_logic;
		S     : out std_logic
	);
end entity or1b;
architecture behaviour of or1b is
begin
	S <= A or B;
end architecture behaviour;
------------------------------------------------------------
-- or8b --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity or8b is
	port (
		A , B :  in std_logic_vector( 7 downto 0 );
		S     : out std_logic_vector( 7 downto 0 )
	);
end entity or8b;
architecture behaviour of or8b is
begin
	S <= A or B;
end architecture behaviour;
------------------------------------------------------------
