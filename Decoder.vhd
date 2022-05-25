LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY Decoder IS
    --3x8
    PORT (
        S : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        enable : IN STD_LOGIC;
        oupt : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END Decoder;

ARCHITECTURE DecoderArch OF Decoder IS
BEGIN

    oupt <= "00000001" WHEN enable = '1' AND S = "000"
        ELSE
        "00000010" WHEN enable = '1' AND S = "001"
        ELSE
        "00000100" WHEN enable = '1' AND S = "010"
        ELSE
        "00001000" WHEN enable = '1' AND S = "011"
        ELSE
        "00010000" WHEN enable = '1' AND S = "100"
        ELSE
        "00100000" WHEN enable = '1' AND S = "101"
        ELSE
        "01000000" WHEN enable = '1' AND S = "110"
        ELSE
        "10000000" WHEN enable = '1' AND S = "111"
        ELSE
        "00000000" WHEN enable = '0';

END DecoderArch;