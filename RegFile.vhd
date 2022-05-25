LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegFile IS

    PORT (
        Rst, Clk : IN STD_LOGIC;
        WriteAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ReadAddress1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ReadAddress2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        WriteData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ReadData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        ReadData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        readEnable : IN STD_LOGIC;
        writeEnable : IN STD_LOGIC
    );

END ENTITY;

ARCHITECTURE RegFileArch OF RegFile IS

  
BEGIN
  
    
END ARCHITECTURE;