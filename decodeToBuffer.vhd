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
    ExeSrc_o, SETC_o : OUT STD_LOGIC;
    AluOpCode_o : OUT std_logic_vector(2 downto 0);
    Rsrc1_o, Rsrc2_o, Immediate_o : OUT std_logic_vector(31 downto 0);
    PC_o : OUT std_logic_vector(31 downto 0);
    loadStoreControlSignals_o : OUT std_logic_vector(2 downto 0)
  ) ;
end entity;

architecture arch of exBufsInteg is
 --- singals from decode stage to IDEx buf --
 signal ExeSrc_dec_IDEX, SETC_dec_IDEX : STD_LOGIC;
 signal AluOpCode_dec_IDEX : std_logic_vector(2 downto 0);
 signal Rsrc1_dec_IDEX, Rsrc2_dec_IDEX, Immediate_dec_IDEX :  std_logic_vector(31 downto 0);
 signal PC_dec_IDEX : std_logic_vector(31 downto 0);
 signal LDSTControlSig_dec_IDEX :  std_logic_vector(2 downto 0);
 --- Mem flying ports ---
 signal  MemRead_dec_IDEX, MemWrite_dec_IDEX :  STD_LOGIC;
 signal dstAddress_dec_IDEX : STD_LOGIC_VECTOR(2 downto 0);
 signal jumpControlSignals_dec_IDEX : STD_LOGIC_VECTOR(2 downto 0);
 signal writeBackSignal_dec_IDEX : STD_LOGIC_VECTOR(1 downto 0);
 signal SPcontrolSignals_dec_IDEX : STD_LOGIC_VECTOR(3 DOWNTO 0);
 signal CCR_ENABLE_dec_IDEX :  STD_LOGIC;
 ---------------------------------------------
 --- signals from IDEx buf to execute stage ---
signal ExeSrc_IDEX_EX, SETC_IDEX_EX :  STD_LOGIC;
signal AluOpCode_IDEX_EX :  std_logic_vector(2 downto 0);
signal Rsrc1_IDEX_EX, Rsrc2_IDEX_EX, Immediate_IDEX_EX :  std_logic_vector(31 downto 0);
signal PC_IDEX_EX : std_logic_vector(31 downto 0);
signal CCR_ENABLE_IDEX_EX :  STD_LOGIC;
--- signals from execute stage to EX Mem buffer ---
signal CCR_Ex_EXMEM : std_logic_vector(2 downto 0);
signal Alu_Ex_EXMEM : std_logic_vector(31 downto 0);
signal PC_Ex_EXMEM : std_logic_vector(31 downto 0);
signal WriteData_Ex_EXMEM : std_logic_vector(31 downto 0);
--- Flowing signals from ID EX to EX Mem buffer ---
signal MemRead_IDEX_EXMEM, MemWrite_IDEX_EXMEM :  STD_LOGIC;
signal LDSTControlSig_IDEX_EXMEM :  std_logic_vector(2 downto 0);
signal jumpControlSignals_IDEX_EXMEM : STD_LOGIC_VECTOR(2 downto 0);
signal dstAddress_IDEX_EXMEM : STD_LOGIC_VECTOR(2 downto 0);
signal writeBackSignal_IDEX_EXMEM : STD_LOGIC_VECTOR(1 downto 0);
signal SPcontrolSignals_IDEX_EXMEM :  STD_LOGIC_VECTOR(3 DOWNTO 0);

begin

    ------from decode stage to ID/EX buffer------
    decodeSTG : entity work.DECODING port map(  
      instruction => instruction,
      clk => clk,
      rst => rst,
      readEnable => readEnable,
      writeEnable => writeEnable,
      writeData => writeData_ToDecode,
      -- ouputs from decode stage to ID/EX buffer --
      ImmValue => Immediate_dec_IDEX,
      readData1 => Rsrc1_dec_IDEX,
      readData2 => Rsrc2_dec_IDEX,
      dstAddress => dstAddress_dec_IDEX,
      jumpControlSignals => jumpControlSignals_dec_IDEX,
      ALUcontrolSignals => AluOpCode_dec_IDEX,
      exSrc => ExeSrc_dec_IDEX,
      Set_C => SETC_dec_IDEX,
      LoadStoreControlSignals => LDSTControlSig_dec_IDEX,
      writeBackSignal => writeBackSignal_dec_IDEX,
      MemoryReadEnableSignal => MemRead_dec_IDEX,
      MemoryWriteEnableSignal => MemWrite_dec_IDEX,
      SPcontrolSignals => SPcontrolSignals_dec_IDEX,
      CCR_ENABLE => CCR_ENABLE_dec_IDEX
                                                );
    -- IDEx buf to execute stage --
     ID_Ex_buf: entity work.IDEx_buf port map(Rst  => Rst,
     Clk => Clk,
     --- inputs --- 
    ExeSrc_i => ExeSrc_dec_IDEX,
    SETC_i => SETC_dec_IDEX,
    AluOpCode_i => AluOpCode_dec_IDEX,
    Rsrc1_i => Rsrc1_dec_IDEX, 
    Rsrc2_i => Rsrc2_dec_IDEX,
    Immediate_i => Immediate_dec_IDEX,
    PC_i => PC_dec_IDEX,
    LoadStoreControlSignals_i => LDSTControlSig_dec_IDEX,
    MemRead_i => MemRead_dec_IDEX,
    MemWrite_i => MemWrite_dec_IDEX,
    dstAddress_i => dstAddress_dec_IDEX,
    jumpControlSignals_i => jumpControlSignals_dec_IDEX,
    writeBackSignal_i => writeBackSignal_dec_IDEX,
    SPcontrolSignals_i => SPcontrolSignals_dec_IDEX,
    CCR_ENABLE_i => CCR_ENABLE_dec_IDEX,
    --- Ex ports outs ---
    ExeSrc_o => ExeSrc_IDEX_EX,
    SETC_o => SETC_IDEX_EX,
    AluOpCode_o => AluOpCode_IDEX_EX,
    Rsrc1_o => Rsrc1_IDEX_EX, 
    Rsrc2_o => Rsrc2_IDEX_EX,
    Immediate_o => Immediate_IDEX_EX,
    PC_o => PC_IDEX_EX,
    CCR_ENABLE_o => CCR_ENABLE_IDEX_EX,
    -- flowing signals from IDEx buf to EX Mem buffer --
    loadStoreControlSignals_o => LDSTControlSig_IDEX_EXMEM,
    MemRead_o => MemRead_IDEX_EXMEM,
    MemWrite_o => MemWrite_IDEX_EXMEM,
    dstAddress_o => dstAddress_IDEX_EXMEM,
    jumpControlSignals_o => jumpControlSignals_IDEX_EXMEM,
    writeBackSignal_o => writeBackSignal_IDEX_EXMEM,
    SPcontrolSignals_o => SPcontrolSignals_IDEX_EXMEM);

end architecture ; -- arch
