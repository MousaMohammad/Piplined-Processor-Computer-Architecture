LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Reg IS
generic (n : integer := 32);
    PORT (
        Rst, Clk, Enable : IN STD_LOGIC;

        RegInput : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
        RegOutput : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));

END ENTITY;

ARCHITECTURE RegArch OF Reg IS
BEGIN
    PROCESS (Rst, Clk)
    BEGIN
        IF (Rst = '1') THEN
            RegOutput <= (OTHERS => '0');
        ELSIF rising_edge(Clk) THEN
            IF (ENABLE = '1') THEN
                RegOutput <= RegInput;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;