------------------------------------------------------------
--  and.vhdl - AND opertation
------------------------------------------------------------
-- and1b --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity and1b is
	port (
		A , B :  in std_logic;
		S     : out std_logic
	);
end entity and1b;
architecture behaviour of and1b is
begin
	S <= A and B;
end architecture behaviour;
------------------------------------------------------------
-- and8b --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity and8b is
	port (
		A , B :  in std_logic_vector( 7 downto 0 );
		S     : out std_logic_vector( 7 downto 0 )
	);
end entity and8b;
architecture behaviour of and8b is
begin
	S <= A and B;
end architecture behaviour;
------------------------------------------------------------
