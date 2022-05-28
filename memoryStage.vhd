LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY memoryStage IS
    PORT (
        Clk : IN STD_LOGIC;
        Rst : IN STD_LOGIC;
        CCR : IN STD_LOGIC_VECTOR(2 DOWNTO 0); --ZNC   -   Comes from EX/MEM buff
        jumpControlSignal : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- Comes from EX/MEM buff
        memWriteControlSignal_In : IN STD_LOGIC; -- Comes from EX/MEM buff
        memReadControlSignal_In : IN STD_LOGIC; -- Comes from EX/MEM buff
        SPControlSignal : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Comes from EX/MEM buff
        ALU_Output_In : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Comes from EX/MEM buff
        writeBackControlSignal_In : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Comes from EX/MEM buff
        writeDataBuff_In : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Comes from EX/MEM buff
        PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Comes from EX/MEM buff
        RegFileAddressWB_In : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- Comes from EX/MEM buff
        Memory_Output : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Comes from memory
        memWriteControlSignal_Out : OUT STD_LOGIC; -- To be sent to memory
        memReadControlSignal_Out : OUT STD_LOGIC; -- To be sent to memory
        writeData_Mem : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- To be sent to memory
        address_Out : OUT STD_LOGIC_VECTOR(19 DOWNTO 0); -- To be sent to memory
        writeBackControlSignal_Out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- To be sent to MEM/WB buff
        ALU_Output_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- To be sent to MEM/WB buff
        readData_Mem : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- To be sent to MEM/WB buff
        RegFileAddressWB_Out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- To be sent to MEM/WB buff
        PC_Mux_Selector : OUT STD_LOGIC -- To be sent to Fetch
    );
END ENTITY;

ARCHITECTURE memArch OF memoryStage IS
    SIGNAL SP_After, SP_Before : STD_LOGIC_VECTOR(19 DOWNTO 0);

BEGIN

    memWriteControlSignal_Out <= memWriteControlSignal_In;
    memReadControlSignal_Out <= memReadControlSignal_In;

    writeData_Mem <= (OTHERS => '0') WHEN Rst = '1'
        ELSE
        ALU_Output_In WHEN SPControlSignal = "1010" -- PUSH Only
        ELSE
        PC WHEN SPControlSignal = "1011" -- CALL Only
        ELSE
        STD_LOGIC_VECTOR(UNSIGNED(PC) + 1) WHEN SPControlSignal = "1100" --INT ONLY
        ELSE
        writeDataBuff_In WHEN SPControlSignal(3) = '0' AND memWriteControlSignal_In = '1'
        ELSE
        (OTHERS => '0');

    address_Out <= (OTHERS => '0') WHEN Rst = '1' ELSE
        ALU_Output_In(19 DOWNTO 0) WHEN SPControlSignal(3) = '0' -- LOAD and STORE
        ELSE
        SP_Before WHEN SPControlSignal = "1010" OR SPControlSignal = "1011"
        OR SPControlSignal = "1100" --PUSH/CALL/INT/ 
        ELSE
        SP_After WHEN SPControlSignal = "1000" OR SPControlSignal = "1001"
        OR SPControlSignal = "1101"; --POP/RET/RTI

        SP_After <= x"FFFFF" WHEN Rst = '1' ELSE
        SP_Before WHEN SPControlSignal(3) = '0'
        ELSE
        STD_LOGIC_VECTOR(UNSIGNED(SP_Before) - 1) WHEN SPControlSignal = "1010"
        OR SPControlSignal = "1011" OR SPControlSignal = "1100" --PUSH/CALL/INT
        ELSE
        STD_LOGIC_VECTOR(UNSIGNED(SP_Before) + 1) WHEN SPControlSignal = "1000"
        OR SPControlSignal = "1001" OR SPControlSignal = "1101"; --POP/RET/RTI

    spReg : ENTITY work.sp_module PORT MAP(Clk => Clk, Rst => Rst, Enable => SPControlSignal(3),
        SP_In => SP_After, SP_Out => SP_Before);
    writeBackControlSignal_Out <= writeBackControlSignal_In;

    ALU_Output_Out <= ALU_Output_In;

    readData_Mem <= (OTHERS => '0') WHEN Rst = '1' ELSE
        Memory_Output;

    RegFileAddressWB_Out <= RegFileAddressWB_In;
    PC_Mux_Selector <= '0' WHEN Rst = '1' ELSE
        '0' WHEN jumpControlSignal(2) = '0'
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

END memArch;