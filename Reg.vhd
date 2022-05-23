LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg IS

    PORT (
        Rst, Clk : IN STD_LOGIC;
        RegInput : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        RegOutput : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));

END ENTITY;

ARCHITECTURE RegArch OF Reg IS
BEGIN
    PROCESS (Rst, Clk)
    BEGIN
        IF (Rst = '1') THEN
            RegOutput <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            RegOutput <= RegInput;
        END IF;
    END PROCESS;
END ARCHITECTURE;
