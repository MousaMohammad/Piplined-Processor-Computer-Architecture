
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DECODING IS
    PORT (
        instruction : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        readEnable, writeEnable : IN STD_LOGIC;
        writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        writeAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ImmValue : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        readData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        dstAddress : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        -------------control signals---------------------
        jumpControlSignals : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        ALUcontrolSignals : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        exSrc : OUT STD_LOGIC; --immediate value bit
        Set_C : OUT STD_LOGIC; --set carry bit
        LoadStoreControlSignals : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        --------------document signals---------------------------
        writeBackSignal : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); ----- (00: No WB, 10: WB_ALU, 11: WB_MEM)
        --MemoryWriteReadSignal, : out std_logic; --(0 for write, 1 for read)
        MemoryReadEnableSignal : OUT STD_LOGIC;
        MemoryWriteEnableSignal : OUT STD_LOGIC;
        SPcontrolSignals : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); ---(00: No change, 01: +1 for POP and RET, 10: -1 for PUSH and CALL)
        CCR_ENABLE : OUT STD_LOGIC
    );
END ENTITY;
ARCHITECTURE DecodeFunc OF decoding IS

    SIGNAL selSr1, selSr2, selDst : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL readEnable_LDM : STD_LOGIC;
    SIGNAL registerFileReadData1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

    ------------------------------select the right register for read and write-------------------------------
    dstAddress <= instruction(19 DOWNTO 17) WHEN instruction(27 DOWNTO 26) = "00"
        ELSE
        instruction(22 DOWNTO 20) WHEN instruction(27 DOWNTO 26) = "01";

    --dstAddress <= selDst;

    selSr1 <= instruction(19 DOWNTO 17) WHEN instruction(31 DOWNTO 26) = "000000" OR instruction(31 DOWNTO 26) = "000100" OR instruction(31 DOWNTO 26) = "010001"----NOT/INC/PUSH instruction
        ELSE
        instruction(25 DOWNTO 23);
    selSr2 <= instruction(22 DOWNTO 20) WHEN instruction(27 DOWNTO 26) = "00" OR instruction(31 DOWNTO 26) = "001101";--(001101-STD)
    ---------------------------------------------------------------------------------------------------------
    readEnable_LDM <= '0' WHEN instruction(31 DOWNTO 26) = "000101" --LDM case
        ELSE
        readEnable;

    readData1 <= "0000000000000000" & instruction(15 DOWNTO 0) WHEN instruction(31 DOWNTO 26) = "000101"
        ELSE
        registerFileReadData1; --LDM case
    ------------------------------if I type-----------------------------------------------------------------
    ImmValue <= "0000000000000000" & instruction(15 DOWNTO 0) WHEN instruction(27 DOWNTO 26) = "01";
    
    
    exSrc <= '1' WHEN instruction(27 DOWNTO 26) = "01" ELSE
        '0';
    ---------------------------------------------------------------------------------------------------------
    RF : ENTITY work.RegFile PORT MAP(clk => clk, rst => rst, readEnable => readEnable_LDM, writeEnable => writeEnable, readAddress1 => selSr1, readAddress2 => selSr2, writeAddress => writeAddress, writeData => writeData, readData1 => registerFileReadData1, readData2 => readData2);

    CU : ENTITY work.ControlUnit PORT MAP(instruction => instruction, jumpControlSignals => jumpControlSignals, ALUcontrolSignals => ALUcontrolSignals, Set_C => Set_C, LoadStoreControlSignals => LoadStoreControlSignals,
        writeBackSignal => writeBackSignal, MemoryReadEnableSignal => MemoryReadEnableSignal, MemoryWriteEnableSignal => MemoryWriteEnableSignal, SPcontrolSignals => SPcontrolSignals, CCR_ENABLE => CCR_ENABLE);
END DecodeFunc;