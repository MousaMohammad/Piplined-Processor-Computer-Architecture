LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY MEMWB_Integ IS
    PORT (
        Rst, Clk : IN STD_LOGIC;
        CCR_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        PC_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALU_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        WriteData_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        jumpControlSignal_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        memWriteControlSignal_i : IN STD_LOGIC;
        memReadControlSignal_i : IN STD_LOGIC;
        SPControlSignal_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        writeBackControlSignal_i : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        RegFileAddressWB_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END MEMWB_Integ;

ARCHITECTURE MEMWB_Integ_Arch OF MEMWB_Integ IS
    SIGNAL CCR, jumpControlSignal, RegFileAddressWB : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL PC, ALU, ALU_Mem_WB, writeData : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL memWriteControlSignal, memReadControlSignal, PC_MUX_Selector : STD_LOGIC;
    SIGNAL SPControlSignal : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL writeBackControlSignal : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL mem_output, writeData_Mem : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL memWriteControlSignal_Mem, memReadControlSignal_Mem : STD_LOGIC;
    SIGNAL memAddress : STD_LOGIC_VECTOR(19 DOWNTO 0);
BEGIN

    EXMEM_buf : ENTITY work.EXMEM_buf PORT MAP(Rst => Rst, Clk => Clk,
        CCR_i => CCR_i,
        PC_i => PC_i,
        ALU_i => ALU_i,
        WriteData_i => WriteData_i,
        jumpControlSignal_i => jumpControlSignal_i,
        memWriteControlSignal_i => memWriteControlSignal_i,
        memReadControlSignal_i => memReadControlSignal_i,
        SPControlSignal_i => SPControlSignal_i,
        writeBackControlSignal_i => writeBackControlSignal_i,
        RegFileAddressWB_i => RegFileAddressWB_i,
        CCR_o => CCR,
        PC_o => PC,
        ALU_o => ALU,
        WriteData_o => writeData,
        jumpControlSignal_o => jumpControlSignal,
        memWriteControlSignal_o => memWriteControlSignal,
        memReadControlSignal_o => memReadControlSignal,
        SPControlSignal_o => SPControlSignal,
        writeBackControlSignal_o => writeBackControlSignal,
        RegFileAddressWB_o => RegFileAddressWB);

    memStage : ENTITY work.memoryStage PORT MAP(Clk => Clk,
        Rst => Rst, CCR => CCR,
        jumpControlSignal => jumpControlSignal,
        memWriteControlSignal_In => memWriteControlSignal,
        memReadControlSignal_In => memReadControlSignal,
        SPControlSignal => SPControlSignal,
        ALU_Output_In => ALU,
        writeBackControlSignal_In => writeBackControlSignal,
        writeDataBuff_In => writeData,
        PC => PC,
        RegFileAddressWB_In => RegFileAddressWB,
        Memory_Output => mem_output,
        memWriteControlSignal_Out => memWriteControlSignal_Mem,
        memReadControlSignal_Out => memReadControlSignal_Mem,
        writeData_Mem => writeData_Mem,
        address_Out => memAddress,
        writeBackControlSignal_Out => writeBackControlSignal,
        ALU_Output_Out => ALU_Mem_WB,
        readData_Mem => mem_output,
        RegFileAddressWB_Out => RegFileAddressWB,
        PC_Mux_Selector => PC_MUX_Selector);
    mem : ENTITY work.memory PORT MAP(
        Clk => Clk,
        writeEnable => memWriteControlSignal_Mem,
        readEnable => memReadControlSignal_Mem,
        address => memAddress,
        dataIn => writeData_Mem,
        dataOut => mem_output
    );

END ARCHITECTURE;