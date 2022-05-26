LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY PC IS
    PORT (
        rst, en : IN STD_LOGIC;
        newPC, mem0 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        pc : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
END ENTITY PC;

ARCHITECTURE PCArch OF PC IS

    SIGNAL currentPC : STD_LOGIC_VECTOR (31 DOWNTO 0);
BEGIN

    currentPC <= mem0 WHEN rst = '1'
        ELSE
        newPC WHEN en = '1'
        ELSE
        currentPC;

    pc <= currentPC;
END ARCHITECTURE;