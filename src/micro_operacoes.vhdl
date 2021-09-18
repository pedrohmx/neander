------------------------------------------------------------
--	Micro Operações
------------------------------------------------------------
-- TODO: modulo de ciclo de instrução
--	NOP
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity op_nop is
	port (
		ci : in std_logic_vector(2 downto 0);
		instr : out std_logic_vector(10 downto 0)
	);
end entity op_nop;
architecture op of op_nop is
begin
	instr(10) <= 1; -- barr_inc;
	instr(9)  <= 1; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= not(ci(2)) and not(ci(1)) and ci(0); -- pc_rw;
	instr(4)  <= 0; -- ac_rw;
	instr(3)  <= 0; -- mem_rw;
	instr(2)  <= not(ci(2)) and not(ci(1)) and not(ci(0)); -- rem_rw;
	instr(1)  <= not(ci(2)) and not(ci(1)) and ci(0); -- rdm_rw;
	instr(0)  <= not(ci(2)) and ci(1) and not(ci(0)); -- ri_rw;
end architecture op;
--	STA TODO:
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity op_sta is
	port (
		ci : in std_logic_vector(2 downto 0);
		instr : out std_logic_vector(10 downto 0)
	);
end entity op_sta;
architecture op of op_sta is
begin
	instr(10) <= 0; -- barr_inc;
	instr(9)  <= 0; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= 0; -- pc_rw;
	instr(4)  <= 0; -- ac_rw;
	instr(3)  <= 0; -- mem_rw;
	instr(2)  <= 0; -- rem_rw;
	instr(1)  <= 0; -- rdm_rw;
	instr(0)  <= 0; -- ri_rw;
end architecture op;
--	LDA
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity op_lda is
	port (
		ci : in std_logic_vector(2 downto 0);
		instr : out std_logic_vector(10 downto 0)
	);
end entity op_lda;
architecture op of op_lda is
begin
	instr(10) <= 1; -- barr_inc;
	instr(9)  <= not(ci(2)) and ci(1) and not(ci(0)); -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= not(ci(1)) and (ci(2) xor ci(0)); -- pc_rw;
	instr(4)  <= ci(2) and ci(1) and ci(0); -- ac_rw;
	instr(3)  <= 0; -- mem_rw;
	instr(2)  <= (ci(1) and (ci(2) xnor ci(0))) or 
	             (not(ci(2)) and ci(1) and ci(0)); -- rem_rw;
	instr(1)  <= (ci(2) and not(ci(0))) or
	             (not(ci(2)) and not(ci(1) and ci(0))); -- rdm_rw;
	instr(0)  <= 0; -- ri_rw;
end architecture op;
--	ADD TODO:
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity op_add is
	port (
		ci : in std_logic_vector(2 downto 0);
		instr : out std_logic_vector(10 downto 0)
	);
end entity op_add;
architecture op of op_add is
begin
	instr(10) <= 0; -- barr_inc;
	instr(9)  <= 0; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= 0; -- pc_rw;
	instr(4)  <= 0; -- ac_rw;
	instr(3)  <= 0; -- mem_rw;
	instr(2)  <= 0; -- rem_rw;
	instr(1)  <= 0; -- rdm_rw;
	instr(0)  <= 0; -- ri_rw;
end architecture op;
--	AND TODO:
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity op_and is
	port (
		ci : in std_logic_vector(2 downto 0);
		instr : out std_logic_vector(10 downto 0)
	);
end entity op_and;
architecture op of op_and is
begin
	instr(10) <= 0; -- barr_inc;
	instr(9)  <= 0; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= 0; -- pc_rw;
	instr(4)  <= 0; -- ac_rw;
	instr(3)  <= 0; -- mem_rw;
	instr(2)  <= 0; -- rem_rw;
	instr(1)  <= 0; -- rdm_rw;
	instr(0)  <= 0; -- ri_rw;
end architecture op;
--	OR  TODO:
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity op_or is
	port (
		ci : in std_logic_vector(2 downto 0);
		instr : out std_logic_vector(10 downto 0)
	);
end entity op_or;
architecture op of op_or is
begin
	instr(10) <= 0; -- barr_inc;
	instr(9)  <= 0; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= 0; -- pc_rw;
	instr(4)  <= 0; -- ac_rw;
	instr(3)  <= 0; -- mem_rw;
	instr(2)  <= 0; -- rem_rw;
	instr(1)  <= 0; -- rdm_rw;
	instr(0)  <= 0; -- ri_rw;
end architecture op;
--	NOT TODO:
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity op_not is
	port (
		ci : in std_logic_vector(2 downto 0);
		instr : out std_logic_vector(10 downto 0)
	);
end entity op_not;
architecture op of op_not is
begin
	instr(10) <= 0; -- barr_inc;
	instr(9)  <= 0; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= 0; -- pc_rw;
	instr(4)  <= 0; -- ac_rw;
	instr(3)  <= 0; -- mem_rw;
	instr(2)  <= 0; -- rem_rw;
	instr(1)  <= 0; -- rdm_rw;
	instr(0)  <= 0; -- ri_rw;
end architecture op;
--	JMP TODO:
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity op_jmp is
	port (
		ci : in std_logic_vector(2 downto 0);
		instr : out std_logic_vector(10 downto 0)
	);
end entity op_jmp;
architecture op of op_jmp is
begin
	instr(10) <= 0; -- barr_inc;
	instr(9)  <= 0; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= 0; -- pc_rw;
	instr(4)  <= 0; -- ac_rw;
	instr(3)  <= 0; -- mem_rw;
	instr(2)  <= 0; -- rem_rw;
	instr(1)  <= 0; -- rdm_rw;
	instr(0)  <= 0; -- ri_rw;
end architecture op;
--	JN  TODO:
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity op_jn is
	port (
		ci : in std_logic_vector(2 downto 0);
		n  : in std_logic;
		instr : out std_logic_vector(10 downto 0)
	);
end entity op_jn;
architecture op of op_jn is
begin
	instr(10) <= 0; -- barr_inc;
	instr(9)  <= 0; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= 0; -- pc_rw;
	instr(4)  <= 0; -- ac_rw;
	instr(3)  <= 0; -- mem_rw;
	instr(2)  <= 0; -- rem_rw;
	instr(1)  <= 0; -- rdm_rw;
	instr(0)  <= 0; -- ri_rw;
end architecture op;
--	JZ  TODO:
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity op_jz is
	port (
		ci : in std_logic_vector(2 downto 0);
		z  : in std_logic;
		instr : out std_logic_vector(10 downto 0)
	);
end entity op_jz;
architecture op of op_jz is
begin
	instr(10) <= 0; -- barr_inc;
	instr(9)  <= 0; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= 0; -- pc_rw;
	instr(4)  <= 0; -- ac_rw;
	instr(3)  <= 0; -- mem_rw;
	instr(2)  <= 0; -- rem_rw;
	instr(1)  <= 0; -- rdm_rw;
	instr(0)  <= 0; -- ri_rw;
end architecture op;
--	HLT
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity op_hlt is
	port (
		ci : in std_logic_vector(2 downto 0);
		instr : out std_logic_vector(10 downto 0)
	);
end entity op_hlt;
architecture op of op_hlt is
begin
	instr(10) <= 0; -- barr_inc;
	instr(9)  <= 0; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= 0; -- pc_rw;
	instr(4)  <= 0; -- ac_rw;
	instr(3)  <= 0; -- mem_rw;
	instr(2)  <= 0; -- rem_rw;
	instr(1)  <= 0; -- rdm_rw;
	instr(0)  <= 0; -- ri_rw;
end architecture op;
------------------------------------------------------------
