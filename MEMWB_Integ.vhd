LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY MEMWB_Integ IS
    PORT (
        Rst,
        Clk : IN STD_LOGIC;
        CCR : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ALU_Output_Input : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        jumpControlSignal : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        memWriteControlSignal : IN STD_LOGIC;
        memReadControlSignal : IN STD_LOGIC;
        SPControlSignal : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        writeBackControlSignal_In : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        WriteDataBuff_In : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        RegFileAddressWB : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        writeBackControlSignal_Out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- To be sent to MEM/WB buff
        ALU_Output_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- To be sent to MEM/WB buff
        readData_Mem : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- To be sent to MEM/WB buff
        RegFileAddressWB_Out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- To be sent to MEM/WB buff
        PC_Mux_Selector : OUT STD_LOGIC -- To be sent to Fetch
    );
END MEMWB_Integ;

ARCHITECTURE MEMWB_Integ_Arch OF MEMWB_Integ IS
    SIGNAL mem_output_Mem_MemStage, writeData_MemStage_Mem : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL memWriteControlSignal_Mem, memReadControlSignal_Mem : STD_LOGIC;
    SIGNAL address_Memstage_Mem : STD_LOGIC_VECTOR(19 DOWNTO 0);
BEGIN

    memStage : ENTITY work.memoryStage PORT MAP(Clk => Clk,
        Rst => Rst, CCR => CCR,
        jumpControlSignal => jumpControlSignal,
        memWriteControlSignal_In => memWriteControlSignal,
        memReadControlSignal_In => memReadControlSignal,
        SPControlSignal => SPControlSignal,
        ALU_Output_In => ALU_Output_Input,
        writeBackControlSignal_In => writeBackControlSignal_In,
        writeDataBuff_In => writeDataBuff_In,
        PC => PC,
        RegFileAddressWB_In => RegFileAddressWB,
        Memory_Output => mem_output_mem_memStage,
        memWriteControlSignal_Out => memWriteControlSignal_Mem,
        memReadControlSignal_Out => memReadControlSignal_Mem,
        writeData_Mem => writeData_MemStage_Mem,
        address_Out => address_Memstage_Mem,
        writeBackControlSignal_Out => writeBackControlSignal_Out,
        ALU_Output_Out => ALU_Output_Out,
        readData_Mem => readData_Mem,
        RegFileAddressWB_Out => RegFileAddressWB_Out,
        PC_Mux_Selector => PC_Mux_Selector);

    mem : ENTITY work.memory PORT MAP(
        Clk => Clk,
        writeEnable => memWriteControlSignal_Mem,
        readEnable => memReadControlSignal_Mem,
        address => address_Memstage_Mem,
        dataIn => writeData_MemStage_Mem,
        dataOut => mem_output_Mem_MemStage
    );

END ARCHITECTURE;