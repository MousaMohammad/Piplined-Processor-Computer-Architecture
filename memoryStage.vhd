LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY memoryStage IS

    PORT (
        Clk : IN STD_LOGIC;
        Rst : IN STD_LOGIC;
        CCR : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        jumpControlSignal : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        memWriteReadControlSignal : IN STD_LOGIC; -- 0 -> Write / 1 -> Read
        SPControlSignal : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- 00 -> No Change / 01 -> +1 / 10 -> -1 
        ALU_Output : IN STD_LOGIC_VECTOR(32 DOWNTO 0);
        writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Memory_Output : IN STD_LOGIC_VECTOR(32 DOWNTO 0);
        readData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        SP : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
        PC_Mux_Selector: OUT STD_LOGIC
    );
END ENTITY;
ARCHITECTURE memArch OF memoryStage IS
BEGIN

    PROCESS (Rst, Clk)
    BEGIN
        IF Rst = '1' THEN
            SP <= x"FFFFF";
            readData <= (OTHERS => '0');
            PC_Mux_Selector <= '0';
        ELSIF rising_edge(Clk) THEN

        END IF;

    END PROCESS;

END memArch;
