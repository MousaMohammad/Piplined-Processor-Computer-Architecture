LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY memoryStage IS

    PORT (
        Clk : IN STD_LOGIC;
        Rst : IN STD_LOGIC;
        CCR : IN STD_LOGIC_VECTOR(2 DOWNTO 0); --ZNC
        jumpControlSignal : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        memWriteReadControlSignal : IN STD_LOGIC; -- 0 -> Write / 1 -> Read
        SPControlSignal : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ALU_Output : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Memory_Output : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        readData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        SP : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
        PC_Mux_Selector : OUT STD_LOGIC;
        address_In : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        address_Out : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
    );
END ENTITY;
ARCHITECTURE memArch OF memoryStage IS
BEGIN

    PROCESS (Rst)
    BEGIN
        IF Rst = '1' THEN
            SP <= x"FFFFF";
            readData <= (OTHERS => '0');
            PC_Mux_Selector <= '0';
        END IF;
    END PROCESS;

    PC_Mux_Selector <= '0' WHEN jumpControlSignal(2) = '0'
        ELSE
        '1' WHEN jumpControlSignal = "100" --JMP
        ELSE
        '1' WHEN jumpControlSignal = "101" AND CCR(2) = '1'
        ELSE
        '0' WHEN jumpControlSignal = "101" AND CCR(2) = '0'
        ELSE
        '1' WHEN jumpControlSignal = "110" AND CCR(1) = '1'
        ELSE
        '0' WHEN jumpControlSignal = "110" AND CCR(1) = '0'
        ELSE
        '1' WHEN jumpControlSignal = "111" AND CCR(0) = '1'
        ELSE
        '0' WHEN jumpControlSignal = "111" AND CCR(0) = '0';

    address_Out <= address_In(19 DOWNTO 0) WHEN SPControlSignal(2) = '0';
    -- ELSE  WHEN SPControlSignal(2) = '1' AND SPControlSignal(1) = '0';
   

END memArch;