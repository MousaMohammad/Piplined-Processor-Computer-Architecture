
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
        writeBackSignal : out std_logic_vector(1 downto 0);----- (00: No WB, 10: WB_ALU, 11: WB_MEM)
        MemoryWriteReadSignal : out std_logic; --(0 for write, 1 for read)
        SPcontrolSignals : out std_logic_vector(1 downto 0) ---(00: No change, 01: +1 for POP and RET, 10: -1 for PUSH and CALL)
	);
	
	     
END Entity;


architecture DecodeFunc of decoding is
	

	signal selSr1,selSr2,selDst : std_logic_vector(2 downto 0);
begin
	process(clk) is
	begin
		if rising_edge(clk) then
			if (instruction(27 downto 26) = "00") then
				selSr1 <= instruction(25 downto 23);
				selSr2 <= instruction(22 downto 20);
				selDst <= instruction(19 downto 17);
                ALUcontrolSignals <= instruction(30 downto 28);
                exSrc <= '0';
                memoryWriteReadSignal <= '1';
                if (instruction(31 downto 28) = "0000") then -----NOT instruction
                    selSr1 <= selDst;
                    writeBackSignal <= "10";
                elsif (instruction(31 downto 28) = "0001") then -----INC instruction
                    selSr1 <= selDst;
                    writeBackSignal <= "10";
                elsif (instruction(31 downto 28) = "0010") then -----ADD instruction
                    writeBackSignal <= "10";
                elsif (instruction(31 downto 28) = "0011") then -----SUB instruction
                    writeBackSignal <= "10";
                elsif (instruction(31 downto 28) = "0100") then ------AND instruction
                    writeBackSignal <= "10";
                -- elsif (instruction(31 downto 28) = "0101") then 
                --     jumpControlSignals <= "01";
                -- elsif (instruction(31 downto 28) = "0110") then
                --     jumpControlSignals <= "10";
                -- elsif (instruction(31 downto 28) = "0111") then
                --     jumpControlSignals <= "11";
                -- elsif (instruction(31 downto 28) = "1000") then
                --     jumpControlSignals <= "00";
                -- elsif (instruction(31 downto 28) = "1001") then
                --     jumpControlSignals <= "01";
                -- elsif (instruction(31 downto 28) = "1010") then
                --     jumpControlSignals <= "10";
                end if;

			elsif (instruction(27 downto 26) = "01") then
				selSr1 <= instruction(25 downto 23);
				selDst <= instruction(22 downto 20);
				ImmValue <= "0000000000000000" & instruction(19 downto 4);
                exSrc <= '1';
                memoryWriteReadSignal <= '1';
                if (instruction(31 downto 28) = "0000") then ------IADD instruction
                    ALUcontrolSignals <= "010";
                    writeBackSignal <= "10";
                elsif (instruction(31 downto 28) = "0001") then -----LDM instruction
                    loadStoreControlSignals <= "100";
                    writeBackSignal <= "11";
                elsif (instruction(31 downto 28) = "0010") then -----LDD instruction
                    loadStoreControlSignals <= "101";
                    writeBackSignal <= "11";
                elsif (instruction(31 downto 28) = "0011") then -----STD instruction
                    loadStoreControlSignals <= "110";
                    writeBackSignal <= "11";
                    memoryWriteReadSignal <= '0';
                -- elsif (instruction(31 downto 28) = "0100") then -----PUSH instruction
                --     jumpControlSignals <= "000";
                -- elsif (instruction(31 downto 28) = "0101") then -----POP instruction
                --     jumpControlSignals <= "001";
                -- elsif (instruction(31 downto 28) = "0110") then
                --     jumpControlSignals <= "010";
                -- elsif (instruction(31 downto 28) = "0111") then
                --     jumpControlSignals <= "011";
                end if;

			elsif (instruction(27 downto 26) = "10") then
				selSr1 <= instruction(25 downto 23);
				selSr2 <= instruction(22 downto 20);
				selDst <= instruction(19 downto 17);
                jumpControlSignals <= instruction(30 downto 28);
                memoryWriteReadSignal <= '1';
                exSrc <= '0';
                if (instruction(31 downto 28) = "0000") then
                    jumpControlSignals <= "100";
                elsif (instruction(31 downto 28) = "0001") then
                    jumpControlSignals <= "101";
                elsif (instruction(31 downto 28) = "0010") then
                    jumpControlSignals <= "110";
                elsif (instruction(31 downto 28) = "0011") then
                    jumpControlSignals <= "111";
                end if;	
			end if;
		end if;
	end process;

    -- selDst <= instruction(19 downto 17) when  instruction(31 downto 26) = "000000"
    -- else instruction(22 downto 20) when  instruction(31 downto 26) = "000001"
    -- else instruction(19 downto 17) when  instruction(31 downto 26) = "000010";

    -- selSr1 <= instruction(25 downto 23); -- when  instruction(31 downto 26) = "000000"
    -- -- else instruction(22 downto 20) when  instruction(31 downto 26) = "000001"
    -- -- else instruction(25 downto 23) when  instruction(31 downto 26) = "000010";

    -- selSr2 <= instruction(22 downto 20) when  instruction(31 downto 26) = "000000"
    -- else instruction(22 downto 20) when  instruction(31 downto 26) = "000010";

    -- ImmValue <= "0000000000000000" & instruction(19 downto 4) when  instruction(31 downto 26) = "000001";
    

    RF: ENTITY work.RegFile port map(clk=>clk,rst=>rst,readEnable=>readEnable,writeEnable=>writeEnable,readAddress1=>selSr1,readAddress2=>selSr2,writeAddress=>selDst,writeData=>writeData,readData1=>readData1,readData2=>readData2);
	
	
end DecodeFunc;
