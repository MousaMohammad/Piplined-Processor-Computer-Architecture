LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fetchStage IS
    PORT (
        freezePC : IN STD_LOGIC;
        jumpPC : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
        usejumpPC : IN STD_LOGIC;
        PC : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
        memData : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        memAddr : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
        instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        readEnable : OUT STD_LOGIC
    );

END ENTITY fetchStage;

ARCHITECTURE fetchArch OF fetchStage IS
    COMPONENT mux2_nbit IS
        GENERIC (n : INTEGER := 32);
        PORT (
            in0, in1 : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
            sel : IN STD_LOGIC;
            out1 : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0));
    END COMPONENT;

    COMPONENT my_nadder IS
        GENERIC (n : INTEGER := 8);
        PORT (
            a, b : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            cin : IN STD_LOGIC;
            s : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            cout : OUT STD_LOGIC);

    END COMPONENT;

    SIGNAL PC_next : STD_LOGIC_VECTOR(19 DOWNTO 0);
    SIGNAL PC_next_next : STD_LOGIC_VECTOR(19 DOWNTO 0);
BEGIN
    PCADD : my_nadder GENERIC MAP (20) PORT MAP (PC, (OTHERS => '0'), '1', PC_next,OPEN);
    PCMUX : mux2_nbit GENERIC MAP(20) PORT MAP(PC, jumpPC, usejumpPC, PC_next_next);
    memAddr <= PC_next_next WHEN freezePC = '0' ;

    instruction <= memData;
    readEnable <= '1';

end architecture;