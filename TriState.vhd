LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY TriState IS
        GENERIC (n : INTEGER := 32);
        PORT (
                enable : IN STD_LOGIC;
                inpt : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
                outpt : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0));
END TriState;

ARCHITECTURE TriArch OF TriState IS
BEGIN

        outpt <= inpt WHEN enable = '1'
                ELSE
                (OTHERS => 'Z') WHEN enable = '0';
END TriArch;