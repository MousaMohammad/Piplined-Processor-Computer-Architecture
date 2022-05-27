
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
        SPcontrolSignals : out std_logic_vector(2 downto 0) ---(00: No change, 01: +1 for POP and RET, 10: -1 for PUSH and CALL)
	);
	
END Entity;

architecture ControlUnitArch of ControlUnit IS

begin
    ------------------------------------------ALU CONTROL SIGNALS------------------------------------------------------
    ALUcontrolSignals <= instruction(30 downto 28) when  instruction(27 downto 26) = "00" ---------ALU OPERATION-------
    else "010"  when instruction(27 downto 26) = "01";---------MEMORY OPERATION-------

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
    SPcontrolSignals <= "100" when instruction(31 downto 26) = "010101"  ----------POP
    else "101" when instruction(31 downto 26) = "010110" ----RET
    else "110" when instruction(31 downto 26) = "010001" ----------PUSH
    Else "111" when instruction(31 downto 26) = "010010" ---CALL
    else "000";----------NO SP

    ------------------------------------------SETC CONTROL SIGNALS------------------------------------------------------
    Set_C <= '1' when instruction(31 downto 26) = "011100" 
    else '0';
    
end ControlUnitArch;

