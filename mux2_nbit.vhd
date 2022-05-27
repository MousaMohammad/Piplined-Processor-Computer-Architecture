LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux2_nbit IS
    GENERIC (n : INTEGER := 32);
    PORT (
        in0, in1 : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
        sel : IN STD_LOGIC;
        out1 : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0));
END ENTITY;

ARCHITECTURE arch1 OF mux2_nbit IS
BEGIN

    out1 <= in0 WHEN sel = '0' ELSE
        in1;

END ARCHITECTURE;