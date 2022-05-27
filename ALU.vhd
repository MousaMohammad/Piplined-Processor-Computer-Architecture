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
-- INC signals --
signal incRes: std_logic_vector(31 DOWNTO 0);
signal incCout: std_logic;
-- Add signals --
signal addRes: std_logic_vector(31 DOWNTO 0);
signal addCout: std_logic;
-- Sub signals --
signal subRes: std_logic_vector(31 DOWNTO 0);
signal subSrc: std_logic_vector(31 DOWNTO 0);
signal subCout: std_logic;

BEGIN
    -- NOT --
    F <= NOT A WHEN opCode = "000"
    -- INC --
    ELSE incRes WHEN opCode = "001"
    -- ADD --
    ElSE addRes WHEN opCode = "010"
    -- SUB --
    ELSE subRes WHEN opCode = "011"
    -- AND --
    ELSE A AND B WHEN opCode = "100"
    -- MOV -- 
    ELSE A WHEN opCode = "101";
    

    INC :entity work.my_nadder GENERIC map(32) port map(A, "00000000000000000000000000000001",'0', incRes, incCout);
    ADD :entity work.my_nadder GENERIC map(32) port map(A, B, '0', addRes, addCout);
    subSrc <= NOT B WHEN opCode = "011";
    SUB :entity work.my_nadder GENERIC map(32) port map(A, subSrc, '1', subRes, subCout);
    -- carry out --
Cout <= incCout WHEN opCode = "001"
        ELSE addCout WHEN opCode = "010"
        ELSE subCout WHEN opCode = "011";

END ARCHITECTURE;

