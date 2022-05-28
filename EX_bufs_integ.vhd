Library ieee;
Use ieee.std_logic_1164.all;

entity exBufsInteg is
  port (
    instruction:IN std_logic_vector (31 DOWNTO 0);
		clk : in std_logic;
		rst : in std_logic;
		readEnable, writeEnable: in std_logic;
		writeData_ToDecode : in std_logic_vector(31 downto 0);
    --- Outputs ---
    PC_o : OUT STD_LOGIC_VECTOR(31 downto 0);
    CCR_o : OUT STD_LOGIC_VECTOR(2 downto 0);
    Alu_o : OUT STD_LOGIC_VECTOR(31 downto 0)
  ) ;
end entity;

architecture arch of exBufsInteg is

--   COMPONENT DECODING IS
-- 	PORT(
-- 		instruction:IN std_logic_vector (31 DOWNTO 0);
-- 		clk : in std_logic;
-- 		rst : in std_logic;
-- 		readEnable, writeEnable: in std_logic;
-- 		writeData : in std_logic_vector(31 downto 0);
-- 		ImmValue : out std_logic_vector(31 downto 0);
-- 		readData1 : out std_logic_vector(31 downto 0);
-- 		readData2 : out std_logic_vector(31 downto 0);
-- 		dstAddress : out std_logic_vector(2 downto 0);
--     -------------control signals---------------------
--     jumpControlSignals : out std_logic_vector(2 downto 0);
--     ALUcontrolSignals : out std_logic_vector(2 downto 0);
--     exSrc : out std_logic; --immediate value bit
--     Set_C : out std_logic; --set carry bit
--     LoadStoreControlSignals : out std_logic_vector(2 downto 0);
--     --------------document signals---------------------------
--     writeBackSignal : out std_logic_vector(1 downto 0); ----- (00: No WB, 10: WB_ALU, 11: WB_MEM)
--     --MemoryWriteReadSignal, : out std_logic; --(0 for write, 1 for read)
--     MemoryReadEnableSignal : out std_logic; 
--     MemoryWriteEnableSignal : out std_logic;
--     SPcontrolSignals : out std_logic_vector(2 downto 0); ---(00: No change, 01: +1 for POP and RET, 10: -1 for PUSH and CALL)
--     CCR_ENABLE : out std_logic
-- 	);
	
	     
-- END COMPONENT;
 --- singals from decode stage to IDEx buf --
 signal ExeSrc_i, SETC_i : STD_LOGIC;
 signal AluOpCode_i : std_logic_vector(2 downto 0);
 signal Rsrc1_i, Rsrc2_i, Immediate_i :  std_logic_vector(31 downto 0);
 signal PC_i : std_logic_vector(31 downto 0);
 signal LoadStoreControlSignals_i :  std_logic_vector(2 downto 0);
 --- Ex ports outs ---
 signal ExeSrc_o, SETC_o :  STD_LOGIC;
 signal AluOpCode_o :  std_logic_vector(2 downto 0);
 signal Rsrc1_o, Rsrc2_o, Immediate_o :  std_logic_vector(31 downto 0);
 --signal PC_o :  std_logic_vector(31 downto 0);
 signal loadStoreControlSignals_o :  std_logic_vector(2 downto 0);
 --- Mem flying ports ---
 signal  MemRead_i, MemWrite_i :  STD_LOGIC;
 signal MemRead_o, MemWrite_o :  STD_LOGIC;
 signal dstAddress_i : STD_LOGIC_VECTOR(2 downto 0);
 signal dstAddress_o : STD_LOGIC_VECTOR(2 downto 0);
 signal jumpControlSignals_i : STD_LOGIC_VECTOR(2 downto 0);
 signal jumpControlSignals_o : STD_LOGIC_VECTOR(2 downto 0);
 signal Set_C_i : STD_LOGIC;
 signal Set_C_o : STD_LOGIC;
 signal writeBackSignal_i : STD_LOGIC_VECTOR(1 downto 0);
 signal writeBackSignal_o : STD_LOGIC_VECTOR(1 downto 0);
--  signal writeBackControlSignal_i :  STD_LOGIC_VECTOR(1 DOWNTO 0);
--  signal writeBackControlSignal_o :  STD_LOGIC_VECTOR(1 DOWNTO 0);
 signal SPcontrolSignals_i : STD_LOGIC_VECTOR(3 DOWNTO 0);
 signal SPcontrolSignals_o :  STD_LOGIC_VECTOR(3 DOWNTO 0);
 signal CCR_ENABLE_i :  STD_LOGIC;
 signal CCR_ENABLE_o :  STD_LOGIC;


--- signals from IDEx buf to execute stage ---
-- signal ExeSrc_o : std_logic;
-- signal SETC_o : std_logic;
-- signal AluOpCode_o : std_logic_vector(2 downto 0);
-- signal Rsrc1_o : std_logic_vector(31 downto 0);
-- signal Rsrc2_o : std_logic_vector(31 downto 0);
-- signal Immediate_o : std_logic_vector(31 downto 0);
signal PC_IDbuf : std_logic_vector(31 downto 0);
--- signals from execute stage to EX Mem buffer ---
signal CCR_Ex : std_logic_vector(2 downto 0);
signal Alu_Ex : std_logic_vector(31 downto 0);
signal PC_Ex : std_logic_vector(31 downto 0);
signal WriteData : std_logic_vector(31 downto 0);

begin

    ------from decode stage to ID/EX buffer------
    decodeSTG : entity work.DECODING port map(  
      instruction => instruction,
      clk => clk,
      rst => rst,
      readEnable => readEnable,
      writeEnable => writeEnable,
      writeData => writeData_ToDecode,
      ImmValue => Immediate_i,
      readData1 => Rsrc1_i,
      readData2 => Rsrc2_i,
      dstAddress => dstAddress_i,
      jumpControlSignals => jumpControlSignals_i,
      ALUcontrolSignals => AluOpCode_i,
      exSrc => ExeSrc_i,
      Set_C => SETC_i,
      LoadStoreControlSignals => LoadStoreControlSignals_i,
      writeBackSignal => writeBackSignal_i,
      MemoryReadEnableSignal => MemRead_i,
      MemoryWriteEnableSignal => MemWrite_i,
      SPcontrolSignals => SPcontrolSignals_i,
      CCR_ENABLE => CCR_ENABLE_i
                                                );
    -- IDEx buf to execute stage --
    --ID_Ex_buf: entity work.IDEx_buf port map();
    -- ID_Ex_buf: entity work.IDEx_buf port map(Rst,Clk,ExeSrc, SETC,AluOpCode,Rsrc1, Rsrc2, Immediate,PC,
    --     ExeSrc_o,SETC_o,AluOpCode_o,Rsrc1_o, Rsrc2_o, Immediate_o, PC_IDbuf,'0','0',open,open);
        
    executeSTG: entity work.ExecuteStage port map(Rst,Clk,ExeSrc_o,SETC_o,AluOpCode_o,Rsrc1_o, Rsrc2_o, Immediate_o, PC_IDbuf,
            CCR_Ex,PC_Ex,Alu_Ex,WriteData);
    -- execute stage to EX Mem buffer --
    memBuf: entity work.ExMem_buf port map(Rst,Clk, CCR_Ex, PC_Ex, Alu_Ex,WriteData,
        PC_o, CCR_o, Alu_o);

end architecture ; -- arch
