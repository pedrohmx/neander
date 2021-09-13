------------------------------------------------------------
-- fAdder.vhdl - Full Adder
------------------------------------------------------------
-- fAdder1b
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fAdder1b is
	port (
		A, B : in  bit; -- inputs
		Cin  : in  bit; -- carry in
		Cout : out bit; -- carry out
		S    : out bit  -- output
	);
end entity fAdder1b;
architecture behaviour of fAdder1b is
begin
	-- logic
	-- carry out: must be one if at least two out of the three input bits are 1s
	Cout <=
		(A and B) or
		(A and Cin) or
		(B and Cin);
	-- output:
	-- if 1 bit is 1 -> 1
	-- if 2 1s -> 0
	-- if 3 1s -> 1
	-- can be achieved using xor
	S <= (A xor B) xor Cin;

end architecture behaviour;

------------------------------------------------------------
-- fAdder4b
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fAdder4b is
	port (
		A, B : in  bit_vector(3 downto 0); -- inputs
		Cin  : in  bit; -- carry in
		Cout : out bit; -- carry out
		S    : out bit_vector(3 downto 0)  -- output
	);
end entity fAdder4b;
architecture behaviour of fAdder4b is

	component fAdder1b is
		port (
			A, B : in  bit; -- inputs
			Cin  : in  bit; -- carry in
			Cout : out bit; -- carry out
			S    : out bit  -- output
		);
	end component;
	-- internal carry signal
	-- carry vector
	signal cv : bit_vector (2 downto 0);

begin
	-- uso de 4 fadders1b
	u_fa1b_0 : fAdder1b
	port map (A(0), B(0),   Cin, cv(0), S(0));
	
	u_fa1b_1 : fAdder1b
	port map (A(1), B(1), cv(0), cv(1), S(1));
	
	u_fa1b_2 : fAdder1b
	port map (A(2), B(2), cv(1), cv(2), S(2));
	
	u_fa1b_3 : fAdder1b
	port map (A(3), B(3), cv(2),  Cout, S(3));

end architecture behaviour;
------------------------------------------------------------
-- fAdder8b
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fAdder8b is
	port (
		A, B : in  bit_vector(7 downto 0); -- inputs
		Cin  : in  bit; -- carry in
		Cout : out bit; -- carry out
		S    : out bit_vector(7 downto 0)  -- output
	);
end entity fAdder8b;
architecture behaviour of fAdder8b is

	component fAdder4b is
		port (
			A, B : in  bit_vector(3 downto 0); -- inputs
			Cin  : in  bit; -- carry in
			Cout : out bit; -- carry out
			S    : out bit_vector(3 downto 0)  -- output
		);
	end component;
	-- internal carry signal
	-- carry bit
	signal cv : bit;

begin
	-- uso de 2 fadders4b
	u_fa4b_0 : fAdder4b
	port map (A(3 downto 0), B(3 downto 0), Cin,   cv, S(3 downto 0));
	
	u_fa4b_3 : fAdder4b
	port map (A(7 downto 4), B(7 downto 4),  cv, Cout, S(7 downto 4));

end architecture behaviour;
------------------------------------------------------------
