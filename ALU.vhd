Library ieee;
Use ieee.std_logic_1164.all;

Entity ALU IS
GENERIC (n : integer := 32);
	PORT(
        A,B:IN std_logic_vector (n-1 DOWNTO 0);
	     opCode:IN std_logic_vector (2 DOWNTO 0);
	     CCR:IN std_logic_vector (2 DOWNTO 0);
	     F:OUT std_logic_vector (n-1 DOWNTO 0);
         Cout:OUT std_logic
         );
END Entity;

ARCHITECTURE archB OF ALU IS
signal incRes: std_logic_vector(31 DOWNTO 0);
signal incCout: std_logic;
BEGIN

    -- NOT --
    F <= NOT A WHEN opCode = "000"
    -- INC --
    ELSE incRes WHEN opCode = "001";

    INC :entity work.my_nadder GENERIC map(32) port map(A, "00000000000000000000000000000001",CCR(2), incRes, incCout);
Cout <= incCout WHEN opCode = "001";
 
END ARCHITECTURE;
