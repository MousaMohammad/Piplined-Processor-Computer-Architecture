LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY memory IS
    PORT (
        Clk : IN STD_LOGIC;
        writeEnable : IN STD_LOGIC;
        address : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
        dataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        dataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ENTITY memory;

ARCHITECTURE memArch OF memory IS

    TYPE mem_type IS ARRAY(0 TO 1048575) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ram : mem_type;

BEGIN
    PROCESS (Clk) IS
    BEGIN
        IF rising_edge(Clk) THEN
            IF writeEnable = '1' THEN
                ram(to_integer(unsigned(address))) <= dataIn;
            END IF;
        END IF;
    END PROCESS;
    dataOut <= ram(to_integer(unsigned(address)));
END memArch;