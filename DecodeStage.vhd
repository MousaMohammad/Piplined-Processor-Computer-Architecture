
Library ieee;
Use ieee.std_logic_1164.all;

Entity DECODING IS
	PORT(
		instruction:IN std_logic_vector (31 DOWNTO 0);
		clk : in std_logic;
		rst : in std_logic;
		readEnable, writeEnable: in std_logic;
		writeData : in std_logic_vector(31 downto 0);
		ImmValue : out std_logic_vector(31 downto 0);
		readData1 : out std_logic_vector(31 downto 0);
		readData2 : out std_logic_vector(31 downto 0);
		dstAddress : out std_logic_vector(2 downto 0);
        -------------control signals---------------------
        jumpControlSignals : out std_logic_vector(2 downto 0);
        ALUcontrolSignals : out std_logic_vector(2 downto 0);
        exSrc : out std_logic; --immediate value bit
        LoadStoreControlSignals : out std_logic_vector(2 downto 0);
        --------------document signals---------------------------
        writeBackSignal : out std_logic_vector(1 downto 0); ----- (00: No WB, 10: WB_ALU, 11: WB_MEM)
        MemoryWriteReadSignal : out std_logic; --(0 for write, 1 for read)
        SPcontrolSignals : out std_logic_vector(1 downto 0) ---(00: No change, 01: +1 for POP and RET, 10: -1 for PUSH and CALL)
	);
	
	     
END Entity;


architecture DecodeFunc of decoding is
	
	signal selSr1,selSr2,selDst : std_logic_vector(2 downto 0);
begin

    ------------------------------select the right register for read and write-------------------------------
    selDst <= instruction(19 downto 17) when  instruction(27 downto 26) = "00"
    else instruction(22 downto 20) when  instruction(27 downto 26) = "01"
    else instruction(19 downto 17) when  instruction(27 downto 26) = "10";

    selSr1 <= instruction(19 downto 17) when  instruction(31 downto 26)  = "000000" or instruction(31 downto 26)  = "000100" ----NOT/INC instruction
    else instruction(25 downto 23);

    selSr2 <= instruction(22 downto 20) when  instruction(27 downto 26) = "00"
    else instruction(22 downto 20) when  instruction(27 downto 26) = "10";
    ---------------------------------------------------------------------------------------------------------

    ------------------------------if I type-----------------------------------------------------------------
    ImmValue <= "0000000000000000" & instruction(19 downto 4) when  instruction(27 downto 26) = "01";
    exSrc <= '1' when  instruction(27 downto 26) = "01" else '0';
    ---------------------------------------------------------------------------------------------------------

    RF: ENTITY work.RegFile port map(clk=>clk,rst=>rst,readEnable=>readEnable,writeEnable=>writeEnable,readAddress1=>selSr1,readAddress2=>selSr2,writeAddress=>selDst,writeData=>writeData,readData1=>readData1,readData2=>readData2);
	
	
end DecodeFunc;
