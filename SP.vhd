LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY SP_Module IS

    PORT (
        Clk, Rst, Enable : IN STD_LOGIC;
        SP_In : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
        SP_Out : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE SPArch OF SP_Module IS
BEGIN
    PROCESS (Rst, Clk)
    BEGIN
        IF Rst = '1' THEN
            SP_Out <= x"FFFFF";
        ELSIF falling_edge(Clk) AND Enable = '1' THEN
            SP_Out <= SP_In;
        END IF;
    END PROCESS;
END SPArch;