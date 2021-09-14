------------------------------------------------------------
--  not.vhdl - not opertation
------------------------------------------------------------
-- not1b --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity not1b is
	port (
		A :  in std_logic;
		S : out std_logic
	);
end entity not1b;
architecture behaviour of not1b is
begin
	S <= not A;
end architecture behaviour;
------------------------------------------------------------
-- not8b --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity not8b is
	port (
		A :  in std_logic_vector( 7 downto 0 );
		S : out std_logic_vector( 7 downto 0 )
	);
end entity not8b;
architecture behaviour of not8b is
begin
	S <= not A;
end architecture behaviour;
------------------------------------------------------------
