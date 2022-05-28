
Library ieee;
Use ieee.std_logic_1164.all;

Entity ControlUnit IS
	PORT(
		instruction:IN std_logic_vector (31 DOWNTO 0);
        -------------control signals---------------------
        jumpControlSignals : out std_logic_vector(2 downto 0);
        ALUcontrolSignals : out std_logic_vector(2 downto 0);
        --exSrc : out std_logic; --immediate value bit
        Set_C : out std_logic; --set carry bit
        LoadStoreControlSignals : out std_logic_vector(2 downto 0);
        --------------document signals---------------------------
        writeBackSignal : out std_logic_vector(1 downto 0);----- (00: No WB, 10: WB_ALU, 11: WB_MEM)
        MemoryReadEnableSignal : out std_logic; 
        MemoryWriteEnableSignal : out std_logic;
        SPcontrolSignals : out std_logic_vector(3 downto 0); ---(00: No change, 01: +1 for POP and RET, 10: -1 for PUSH and CALL)
        CCR_ENABLE : out std_logic
	);
	
END Entity;

architecture ControlUnitArch of ControlUnit IS

begin
    ------------------------------------------ALU CONTROL SIGNALS------------------------------------------------------
    ALUcontrolSignals <= instruction(30 downto 28) when  instruction(27 downto 26) = "00" ---------ALU OPERATION-------
    else "010"  when instruction(31 downto 26) = "000001"---------MEMORY OPERATION-------
    else "101" when instruction(31 downto 26) = "000101" ------LDM
    else "010" when instruction(31 downto 26) = "001001" -------LDD
    else "010" when instruction(31 downto 26) = "001101"; ----------STD
    ------------------------------------------WB CONTROL SIGNALS------------------------------------------------------
    writeBackSignal <= "10" when instruction(27 downto 26) = "00" or instruction(31 downto 26) = "000001" ---------ALU OPERATION-------
    else "11" when instruction(27 downto 26) = "01" else "00"; ---------MEMORY OPERATION-------
    
    ------------------------------------------Memory_w_r CONTROL SIGNALS------------------------------------------------------
    MemoryReadEnableSignal <= '1' when instruction(31 downto 26) = "000101" or instruction(31 downto 26) = "001001"
    else '0';
    MemoryWriteEnableSignal <= '1' when instruction(31 downto 26) = "001101" else '0';
    ------------------------------------------Load/Store CONTROL SIGNALS------------------------------------------------------
    loadStoreControlSignals <= "100" when instruction(31 downto 26) = "000101" ------LDM
    else "101" when instruction(31 downto 26) = "001001" -------LDD
    else "110" when instruction(31 downto 26) = "001101" ----------STD
    else "000";



    
    ------------------------------------------JUMP CONTROL SIGNALS------------------------------------------------------
    jumpControlSignals <= "100" when instruction(31 downto 26) = "000010" ----------JMP
    else "101" when instruction(31 downto 26) = "000110" -------JZ
    else "110" when instruction(31 downto 26) = "001010" ----------JN
    else "111" when instruction(31 downto 26) = "001110" -------JC
    else "000";

    ------------------------------------------SP CONTROL SIGNALS------------------------------------------------------
    SPcontrolSignals <= "1000" when instruction(31 downto 26) = "010101"  ----------POP
    else "1001" when instruction(31 downto 26) = "010110" ----RET
    else "1010" when instruction(31 downto 26) = "010001" ----------PUSH
    Else "1011" when instruction(31 downto 26) = "010010" ---CALL
    else "1100" when instruction(31 downto 26) = "011010" --INT
    else "1101" when instruction(31 downto 26) = "011110" --RTI
    else "0000";----------NO SP

    ------------------------------------------SETC CONTROL SIGNALS------------------------------------------------------
    Set_C <= '1' when instruction(31 downto 26) = "011100" 
    else '0';
  
    ------------------------------------------CCR CONTROL SIGNALS------------------------------------------------------
    CCR_ENABLE <= '1' when instruction(31) = '0' and instruction(27 downto 26) = "00"
    else '1' when instruction(31 downto 26) = "000001" or instruction(31 downto 26) = "011110"
    else '0';
    
end ControlUnitArch;

