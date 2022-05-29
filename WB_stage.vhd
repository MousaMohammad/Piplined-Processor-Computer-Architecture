LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY WB_stage IS

    PORT (
        Rst, Clk : IN STD_LOGIC;
        writeBackSignal : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        ALU_Output : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Memory_Output : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        writeAddressIn : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        writeAddressOut : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        writeData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        writeEnable : OUT STD_LOGIC;
        OUT_PORT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END ENTITY;

ARCHITECTURE WB_Arch OF WB_stage IS
BEGIN
    writeEnable <= 'Z' WHEN Rst = '1' ELSE
        '1' WHEN writeBackSignal(1) = '1'
        ELSE
        '0';
    writeData <= (OTHERS => 'Z') WHEN Rst = '1' ELSE
        ALU_Output WHEN writeBackSignal(0) = '0' ELSE
        Memory_Output;
    writeAddressOut <= (OTHERS => 'Z') WHEN Rst = '1'
        ELSE
        writeAddressIn;

    OUT_PORT <= (OTHERS => 'Z') WHEN Rst = '1' OR writeBackSignal /= "01"
        ELSE
        ALU_Output;
END ARCHITECTURE;