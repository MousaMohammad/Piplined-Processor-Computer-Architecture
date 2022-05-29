LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity Integration is
  port (
		clk : in std_logic;
		rst : in std_logic
  );
END ENTITY;

architecture arch of Integration is

 --- singals from decode stage to IDEx buf --
 signal ExeSrc_dec_IDEX, SETC_dec_IDEX : STD_LOGIC;
 signal AluOpCode_dec_IDEX : std_logic_vector(2 downto 0);
 signal Rsrc1_dec_IDEX, Rsrc2_dec_IDEX, Immediate_dec_IDEX :  std_logic_vector(31 downto 0);
 --signal PC_dec_IDEX : std_logic_vector(31 downto 0);
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

-- this signal is used for structural hazard
signal freezePC_MEM_IF : STD_LOGIC;
-- the pc if the instruction is a jump
signal jumpPC_EXMEM_IF : STD_LOGIC_VECTOR(31 downto 0);
-- 1 if jump, 0 if not
signal useJumpPC_MEM_IF : STD_LOGIC;
-- memory data bus
signal MemDataIn : STD_LOGIC_VECTOR(31 downto 0);
signal MemDataOut : STD_LOGIC_VECTOR(31 downto 0);
signal MemReadEnable : STD_LOGIC;
signal MemWriteEnable : STD_LOGIC;
-- memory address bus
signal MemAddress : STD_LOGIC_VECTOR(19 downto 0);

-- instruction to IF_ID buffer
signal instruction_IF_IFID : STD_LOGIC_VECTOR(31 downto 0);
-- read enable for IF_ID buffer
signal readEnable_IF_IFID : STD_LOGIC;
-- PC to be used at adding jump offset
signal PC_IF_IFID : STD_LOGIC_VECTOR(31 downto 0);

signal readEnable_IFID_ID : STD_LOGIC;
signal instruction_IFID_ID : STD_LOGIC_VECTOR(31 downto 0);
signal PC_IFID_IDEX : STD_LOGIC_VECTOR(31 downto 0);

-- CCR
signal CCR_EXMEM_MEM : STD_LOGIC_VECTOR(2 downto 0);
signal PC_EXMEM_MEM : STD_LOGIC_VECTOR(31 downto 0);
signal jumpControlSignal_EXMEM_MEM : STD_LOGIC_VECTOR(2 downto 0);
signal writeBackControlSignal_EXMEM_MEM : STD_LOGIC_VECTOR(1 downto 0);
signal SPcontrolSignal_EXMEM_MEM : STD_LOGIC_VECTOR(3 downto 0);
signal writeData_EXMEM_MEM : STD_LOGIC_VECTOR(31 downto 0);
signal ALU_EXMEM_MEM : STD_LOGIC_VECTOR(31 downto 0);
signal readEnable_EXMEM_MEM : STD_LOGIC;
signal writeEnable_EXMEM_MEM : STD_LOGIC;
signal regFileAddr_EXMEM_MEM : STD_LOGIC_VECTOR(2 downto 0);

signal writeBackControlSignal_MEM_MEMWB : STD_LOGIC_VECTOR(1 downto 0);
signal ALU_MEM_MEMWB : STD_LOGIC_VECTOR(31 downto 0);
signal readData_Mem_MEM_MEMWB : STD_LOGIC_VECTOR(31 downto 0);
signal regFileAddr_MEM_MEMWB : STD_LOGIC_VECTOR(2 downto 0);

--MEMWB_Buf WBStage
signal Memory_MEMWB_WB : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal ALU_MEMWB_WB : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal WBControlSignal_MEMWB_WB : STD_LOGIC_VECTOR(1 DOWNTO 0);

--WB DEC
signal writeEnable_WB_DEC: STD_LOGIC;
signal writeData_WB_DEC : STD_LOGIC_VECTOR (31 DOWNTO 0);
signal writeAddress_WB_DEC : STD_LOGIC_VECTOR (2 DOWNTO 0);

begin


    -- Memory (does not belong to a particular stage)
    mem : entity work.memory port map(
        clk => clk,
        readEnable => MemReadEnable,
        writeEnable => MemWriteEnable,
        address => MemAddress,
        dataIn => MemDataIn,
        dataOut => MemDataOut
    );
    --fetch stage --
    fetchSTG : entity work.fetchStage port map (
      clk => clk,
      freezePC => freezePC_MEM_IF,
      reset => rst,
      jumpPC => jumpPC_EXMEM_IF,
      useJumpPC => useJumpPC_MEM_IF,
      memData => MemDataOut,
      memReadEn => MemReadEnable,
      memAddr => MemAddress,
      instruction => instruction_IF_IFID,
      readEnable => readEnable_IF_IFID,
      PC_out => PC_IF_IFID
      );

    -- buffer between fetch stage and decode stage --
    fetchToDecodeBuffer : entity work.IFID_buf port map (
      clk => clk, 
      rst => rst,
      instruction_i => instruction_IF_IFID,
      readEnable_i => readEnable_IF_IFID,
      PC_i => PC_IF_IFID,
      instruction_o => instruction_IFID_ID,
      readEnable_o => readEnable_IFID_ID,
      PC_o => PC_IFID_IDEX
      );

    ------from decode stage to ID/EX buffer------
    decodeSTG : entity work.DECODING port map(  
      instruction => instruction_IFID_ID,
      clk => clk,
      rst => rst,
      readEnable => readEnable_IFID_ID,
      writeEnable => writeEnable_WB_DEC,
      writeData => writeData_WB_DEC,
      writeAddress => writeAddress_WB_DEC, --change to dstAddress from memBuf to test WB
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
    PC_i => PC_IFID_IDEX,
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

  -- IDEx buf to execute stage --
  executeSTG : ENTITY work.ExecuteStage PORT MAP(Rst => Rst,
    Clk => Clk,
    --- wire signals comming from IDEX to ex --
    ExeSrc => ExeSrc_IDEX_EX,
    SETC => SETC_IDEX_EX,
    AluOpCode => AluOpCode_IDEX_EX,
    Rsrc1 => Rsrc1_IDEX_EX,
    Rsrc2 => Rsrc2_IDEX_EX,
    Immediate => Immediate_IDEX_EX,
    PCin => PC_IDEX_EX,
    CCR_en => CCR_ENABLE_IDEX_EX,
    --- wire signals from execute to EX MEM buffer --
    CCR_o => CCR_Ex_EXMEM,
    PCout => PC_Ex_EXMEM,
    F => Alu_Ex_EXMEM,
    WriteData => WriteData_Ex_EXMEM);
  -- execute stage to EX Mem buffer --
  EXMEM_Buf : ENTITY work.ExMem_buf PORT MAP(Rst => Rst,
    Clk => Clk,
    CCR_i => CCR_Ex_EXMEM,
    PC_i => PC_IDEX_EX,
    PC_Branch_i => PC_Ex_EXMEM,
    Alu_i => Alu_Ex_EXMEM,
    WriteData_i => WriteData_Ex_EXMEM,
    jumpControlSignal_i => jumpControlSignals_IDEX_EXMEM,
    memWriteControlSignal_i => MemWrite_IDEX_EXMEM,
    memReadControlSignal_i => MemRead_IDEX_EXMEM,
    SPControlSignal_i => SPcontrolSignals_IDEX_EXMEM,
    writeBackControlSignal_i => writeBackSignal_IDEX_EXMEM,
    RegFileAddressWB_i => dstAddress_IDEX_EXMEM,
    PC_o => PC_EXMEM_MEM,
    PC_Branch_o => jumpPC_EXMEM_IF,
    CCR_o => CCR_EXMEM_MEM,
    Alu_o => ALU_EXMEM_MEM,
    WriteData_o => writeData_EXMEM_MEM,
    jumpControlSignal_o => jumpControlSignal_EXMEM_MEM,
    memWriteControlSignal_o => writeEnable_EXMEM_MEM,
    memReadControlSignal_o => readEnable_EXMEM_MEM,
    SPControlSignal_o => SPcontrolSignal_EXMEM_MEM,
    writeBackControlSignal_o => writeBackControlSignal_EXMEM_MEM,
    RegFileAddressWB_o => regFileAddr_EXMEM_MEM
    );

    --Mem stage
    memSTG: entity work.memoryStage port map(
      Clk                   => clk,
      Rst                   => rst,
      CCR                   => CCR_EXMEM_MEM,
      jumpControlSignal     => jumpControlSignal_EXMEM_MEM,
      memWriteControlSignal_In    => writeEnable_EXMEM_MEM,
      memReadControlSignal_In     => readEnable_EXMEM_MEM,
      SPControlSignal             => SPControlSignal_EXMEM_MEM,
      ALU_Output_In               => ALU_EXMEM_MEM,
      writeBackControlSignal_In   => writeBackControlSignal_EXMEM_MEM,
      writeDataBuff_In            => writeData_EXMEM_MEM,
      PC                          => PC_EXMEM_MEM,
      RegFileAddressWB_In         => regFileAddr_EXMEM_MEM,
      Memory_Output               => MemDataOut,
      memWriteControlSignal_Out   => MemWriteEnable,
      memReadControlSignal_Out    => MemReadEnable,
      writeData_Mem               => MemDataIn,
      address_Out                 => MemAddress,
      writeBackControlSignal_Out  => writeBackControlSignal_MEM_MEMWB,
      ALU_Output_Out              => ALU_MEM_MEMWB,
      readData_Mem                => readData_Mem_MEM_MEMWB,
      RegFileAddressWB_Out        => regFileAddr_MEM_MEMWB,
      PC_Mux_Selector             => useJumpPC_MEM_IF,
      freezePC                    => freezePC_MEM_IF
    );


    --MEMWB Buffer
    MEMWB_buf: ENTITY work.MemWB_buf PORT MAP(
      Rst => rst,
      Clk => clk,
      writeBackControlSignal_In => writeBackControlSignal_MEM_MEMWB,
      writeBackControlSignal_Out => WBControlSignal_MEMWB_WB,
      Memory_Output_In => readData_Mem_MEM_MEMWB,
      Memory_Output_Out => Memory_MEMWB_WB,
      ALU_Output_In => ALU_MEM_MEMWB,
      ALU_Output_Out => ALU_MEMWB_WB ,
      writeAddressRegFile_In => regFileAddr_MEM_MEMWB
    );


    --WB Stage
    WB: ENTITY work.WB_stage PORT MAP(
      Rst => rst,
      Clk => clk,
      writeBackSignal => WBControlSignal_MEMWB_WB,
      ALU_Output => ALU_MEMWB_WB,
      Memory_Output => Memory_MEMWB_WB,
      writeAddressIn => regFileAddr_MEM_MEMWB,
      writeAddressOut => writeAddress_WB_DEC ,
      writeData => writeData_WB_DEC,
      writeEnable => writeEnable_WB_DEC
    );

end architecture ; -- arch
