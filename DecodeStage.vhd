
Library ieee;
Use ieee.std_logic_1164.all;

ENTITY DECODING IS
    PORT (
        instruction : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        IN_PORT : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
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
        jumpControlSignals : out std_logic_vector(2 downto 0);
        ALUcontrolSignals : out std_logic_vector(2 downto 0);
        exSrc : out std_logic; --immediate value bit
        Set_C : out std_logic; --set carry bit
        LoadStoreControlSignals : out std_logic_vector(2 downto 0);
        --------------document signals---------------------------
        writeBackSignal : out std_logic_vector(1 downto 0); ----- (00: No WB, 10: WB_ALU, 
                                                            ----- 11: WB_MEM, 01: OUT_PORT)
        --MemoryWriteReadSignal, : out std_logic; --(0 for write, 1 for read)
        MemoryReadEnableSignal : OUT STD_LOGIC;
        MemoryWriteEnableSignal : OUT STD_LOGIC;
        SPcontrolSignals : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); ---(00: No change, 01: +1 for POP and RET, 10: -1 for PUSH and CALL)
        CCR_ENABLE : OUT STD_LOGIC
        --Interrupt_Index : out std_logic_vector(1 downto 0)
    );
END ENTITY;
ARCHITECTURE DecodeFunc OF decoding IS

    SIGNAL selSr1, selSr2, selDst : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL readEnable_LDM_In : STD_LOGIC;
    SIGNAL registerFileReadData1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

    ------------------------------select the right register for read and write-------------------------------
    dstAddress <= instruction(19 downto 17) when  instruction(27 downto 26) = "00"
    else instruction(22 downto 20) when  instruction(27 downto 26) = "01";

    --dstAddress <= selDst;

    selSr1 <= instruction(19 downto 17) when  instruction(31 downto 26)  = "000000" or instruction(31 downto 26)  = "000100" or instruction(31 downto 26)  = "010001"----NOT/INC/PUSH instruction
    else instruction(25 downto 23);
    

    selSr2 <= instruction(22 downto 20) when  instruction(27 downto 26) = "00" or instruction(31 downto 26) = "001101";--(001101-STD)
    ---------------------------------------------------------------------------------------------------------
    readEnable_LDM_In <= '0' WHEN instruction(31 DOWNTO 26) = "000101"  --LDM case
    OR instruction(31 DOWNTO 26) = "100100"                             --IN PORT
        ELSE
        readEnable;

    readData1 <= IN_PORT WHEN instruction(31 DOWNTO 26) = "100100" -- IN
        ELSE
        "0000000000000000" & instruction(15 DOWNTO 0) WHEN instruction(31 DOWNTO 26) = "000101"
        ELSE
        registerFileReadData1; --LDM case
    ------------------------------if I type-----------------------------------------------------------------
    ImmValue <= "0000000000000000" & instruction(15 DOWNTO 0);
    --Interrupt_Index <= '1' & instruction(0) when instruction(31 downto 26) = "011010" else "00"; --inturrpt
    exSrc <= '1' WHEN instruction(27 DOWNTO 26) = "01" ELSE
        '0';
    ---------------------------------------------------------------------------------------------------------
    RF : ENTITY work.RegFile PORT MAP(clk => clk, rst => rst, readEnable => readEnable_LDM_In, writeEnable => writeEnable, readAddress1 => selSr1, readAddress2 => selSr2, writeAddress => writeAddress, writeData => writeData, readData1 => registerFileReadData1, readData2 => readData2);

    CU : ENTITY work.ControlUnit PORT MAP(Rst => rst, instruction => instruction, jumpControlSignals => jumpControlSignals, ALUcontrolSignals => ALUcontrolSignals, Set_C => Set_C, LoadStoreControlSignals => LoadStoreControlSignals,
        writeBackSignal => writeBackSignal, MemoryReadEnableSignal => MemoryReadEnableSignal, MemoryWriteEnableSignal => MemoryWriteEnableSignal, SPcontrolSignals => SPcontrolSignals, CCR_ENABLE => CCR_ENABLE);
END DecodeFunc;
