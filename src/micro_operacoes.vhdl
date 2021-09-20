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
	instr(10) <= '1'; -- barr_inc;
	instr(9)  <= '1'; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= not(ci(2)) and not(ci(1)) and ci(0); -- pc_rw;
	instr(4)  <= '0'; -- ac_rw;
	instr(3)  <= '0'; -- mem_rw;
	instr(2)  <= not(ci(2)) and not(ci(1)) and not(ci(0)); -- rem_rw;
	instr(1)  <= not(ci(2)) and not(ci(1)) and ci(0); -- rdm_rw;
	instr(0)  <= not(ci(2)) and ci(1) and not(ci(0)); -- ri_rw;
end architecture op;
--	STA
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
	instr(10) <= '1'; -- barr_inc;
	instr(9)  <= not(ci(2)) or ci(1) or not(ci(0)); -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= not(ci(1)) and (ci(2) xor ci(0)); -- pc_rw;
	instr(4)  <= '0'; -- ac_rw;
	instr(3)  <= ci(2) and ci(1) and not(ci(0)); -- mem_rw;
	instr(2)  <= (not(ci(1)) and (ci(2) xnor ci(0))) or
				 (not(ci(2)) and ci(1) and ci(0)); -- rem_rw;
	instr(1)  <= ci(2) and ci(1) and not(ci(0)); -- rdm_rw;
	instr(0)  <= not(ci(2)) and ci(1) and not(ci(0)); -- ri_rw;
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
	instr(10) <= '1'; -- barr_inc;
	instr(9)  <= not(ci(2)) or ci(1) or not(ci(0)); -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= not(ci(1)) and (ci(2) xor ci(0)); -- pc_rw;
	instr(4)  <= ci(2) and ci(1) and ci(0); -- ac_rw;
	instr(3)  <= '0'; -- mem_rw;
	instr(2)  <= (not(ci(1)) and (ci(2) xnor ci(0))) or 
	             (not(ci(2)) and ci(1) and ci(0)); -- rem_rw;
	instr(1)  <= (ci(2) and not(ci(0))) or
	             (not(ci(2)) and not(ci(1) and ci(0))); -- rdm_rw;
	instr(0)  <= not(ci(2)) and ci(1) and not(ci(0)); -- ri_rw;
end architecture op;
--	ADD
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
	instr(10) <= '1'; -- barr_inc;
	instr(9)  <= not(ci(2)) or ci(1) or not(ci(0)); -- barrPC;
	instr(8 downto 6) <= "001"; -- ula_op;
	instr(5)  <= not(ci(1)) and (ci(2) xor ci(0)); -- pc_rw;
	instr(4)  <= ci(2) and ci(1) and ci(0) ; -- ac_rw;
	instr(3)  <= '0'; -- mem_rw;
	instr(2)  <= (not(ci(1)) and (ci(2) xnor ci(0))) or
				 (not(ci(2)) and ci(1) and ci(0)); -- rem_rw;
	instr(1)  <= (ci(2) and not(ci(0))) or
	             (not(ci(2)) and not(ci(1)) and ci(0)); -- rdm_rw;
	instr(0)  <= not(ci(2)) and ci(1) and not(ci(0)); -- ri_rw;
end architecture op;
--	AND
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
	instr(10) <= '1'; -- barr_inc;
	instr(9)  <= not(ci(2)) or ci(1) or not(ci(0)); -- barrPC;
	instr(8 downto 6) <= "011"; -- ula_op;
	instr(5)  <= not(ci(1)) and (ci(2) xor ci(0)); -- pc_rw;
	instr(4)  <= ci(2) and ci(1) and ci(0) ; -- ac_rw;
	instr(3)  <= '0'; -- mem_rw;
	instr(2)  <= (not(ci(1)) and (ci(2) xnor ci(0))) or
				 (not(ci(2)) and ci(1) and ci(0)); -- rem_rw;
	instr(1)  <= (ci(2) and not(ci(0))) or
	             (not(ci(2)) and not(ci(1)) and ci(0)); -- rdm_rw;
	instr(0)  <= not(ci(2)) and ci(1) and not(ci(0)); -- ri_rw;
end architecture op;
--	OR
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
	instr(10) <= '1'; -- barr_inc;
	instr(9)  <= not(ci(2)) or ci(1) or not(ci(0)); -- barrPC;
	instr(8 downto 6) <= "010"; -- ula_op;
	instr(5)  <= not(ci(1)) and (ci(2) xor ci(0)); -- pc_rw;
	instr(4)  <= ci(2) and ci(1) and ci(0) ; -- ac_rw;
	instr(3)  <= '0'; -- mem_rw;
	instr(2)  <= (not(ci(1)) and (ci(2) xnor ci(0))) or
				 (not(ci(2)) and ci(1) and ci(0)); -- rem_rw;
	instr(1)  <= (ci(2) and not(ci(0))) or
	             (not(ci(2)) and not(ci(1)) and ci(0)); -- rdm_rw;
	instr(0)  <= not(ci(2)) and ci(1) and not(ci(0)); -- ri_rw;
end architecture op;
--	NOT
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
	instr(10) <= '1'; -- barr_inc;
	instr(9)  <= '1'; -- barrPC;
	instr(8 downto 6) <= "100"; -- ula_op;
	instr(5)  <= not(ci(2)) and not(ci(1)) and ci(0); -- pc_rw;
	instr(4)  <= ci(2) and ci(1) and ci(0); -- ac_rw;
	instr(3)  <= '0'; -- mem_rw;
	instr(2)  <= not(ci(2)) and not(ci(1)) and not(ci(0)); -- rem_rw;
	instr(1)  <= not(ci(2)) and not(ci(1)) and ci(0); -- rdm_rw;
	instr(0)  <= not(ci(2)) and ci(1) and not(ci(0)); -- ri_rw;
end architecture op;
--	JMP
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
	instr(10) <= not(ci(2)) or not(ci(0)); -- barr_inc;
	instr(9)  <= '1'; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= not(ci(1)) and ci(0); -- pc_rw;
	instr(4)  <= '0'; -- ac_rw;
	instr(3)  <= '0'; -- mem_rw;
	instr(2)  <= not(ci(2)) and (ci(1) xnor ci(0)); -- rem_rw;
	instr(1)  <= not(ci(1)) and (ci(2) xor ci(0)); -- rdm_rw;
	instr(0)  <= not(ci(2)) and ci(1) and not(ci(0)); -- ri_rw;
end architecture op;
--	JN and JZ
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity op_jnz is
	port (
		ci : in std_logic_vector(2 downto 0);
		flag  : in std_logic;
		instr : out std_logic_vector(10 downto 0)
	);
end entity op_jnz;
architecture op of op_jnz is
begin
	instr(10) <= not(ci(2)) or not(ci(0)) when flag = '1' else
		'1'; -- barr_inc;
	instr(9)  <= '1' when flag = '1' else
		'1'; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= not(ci(1)) and ci(0) when flag = '1' else
		not(ci(2)) and ci(0); -- pc_rw;
	instr(4)  <= '0'; -- ac_rw;
	instr(3)  <= '0'; -- mem_rw;
	instr(2)  <= not(ci(2)) and (ci(1) xnor ci(0)) when flag = '1' else
		not(ci(2)) and not(ci(1)) and not(ci(0)); -- rem_rw;
	instr(1)  <= not(ci(1)) and (ci(2) xor ci(0)) when flag = '1' else
		not(ci(2)) and not(ci(1)) and ci(0); -- rdm_rw;
	instr(0)  <= not(ci(2)) and ci(1) and not(ci(0)); -- ri_rw;
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
	instr(10) <= '0'; -- barr_inc;
	instr(9)  <= '0'; -- barrPC;
	instr(8 downto 6) <= "000"; -- ula_op;
	instr(5)  <= '0'; -- pc_rw;
	instr(4)  <= '0'; -- ac_rw;
	instr(3)  <= '0'; -- mem_rw;
	instr(2)  <= '0'; -- rem_rw;
	instr(1)  <= '0'; -- rdm_rw;
	instr(0)  <= '0'; -- ri_rw;
end architecture op;
------------------------------------------------------------
