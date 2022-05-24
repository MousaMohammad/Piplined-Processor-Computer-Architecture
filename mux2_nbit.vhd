Library ieee;
Use ieee.std_logic_1164.all;

ENTITY mux2_nbit IS
GENERIC (n : integer := 8);
PORT( in0,in1: IN std_logic_vector (n-1 DOWNTO 0);
sel : IN std_logic;
out1: OUT std_logic_vector (n-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE arch1 OF mux2_nbit IS
BEGIN

out1 <= in0 WHEN sel = '0' ELSE in1;

END ARCHITECTURE;
