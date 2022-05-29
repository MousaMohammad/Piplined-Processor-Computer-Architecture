LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fetchStage IS
    PORT (
        clk : IN STD_LOGIC;
        freezePC : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        jumpPC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        usejumpPC : IN STD_LOGIC;
        --PC : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
        memData : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        memAddr : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
        memReadEn : OUT STD_LOGIC;
        instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        readEnable : OUT STD_LOGIC;
        PC_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END ENTITY fetchStage;

ARCHITECTURE fetchArch OF fetchStage IS

    SIGNAL PC_before : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    SIGNAL PC_after : STD_LOGIC_VECTOR(31 DOWNTO 0):= (others => '0');
BEGIN
    PCComp : ENTITY work.fetchComponent PORT MAP (clk, reset, PC_after, PC_before);
    PC_after <= std_logic_vector(unsigned(PC_before) + 1) WHEN freezePC='0' AND usejumpPC='0' 
    ELSE PC_before WHEN freezePC='1' AND usejumpPC='0' 
    ELSE jumpPC WHEN freezePC='0' AND usejumpPC='1';

    memAddr <= PC_before(19 DOWNTO 0) WHEN freezePC = '0'
    ELSE (others => 'Z') WHEN freezePC = '1';

    instruction <= memData;
    readEnable <= '1';

    memReadEn <= '1' WHEN freezePC='0'
    ELSE 'Z' WHEN freezePC = '1';

    PC_out <= PC_before;


end architecture;