Library ieee;
Use ieee.std_logic_1164.all;

entity IDEx_buf is
  port (
    Rst, Clk, LowActiveEnable : IN STD_LOGIC;
    --- Ex ports --- 
    ExeSrc_i, SETC_i : IN STD_LOGIC;
    AluOpCode_i :IN std_logic_vector(2 downto 0);
    Rsrc1_i, Rsrc2_i, Immediate_i : IN std_logic_vector(31 downto 0);
    PC_i : IN std_logic_vector(31 downto 0);
    LoadStoreControlSignals_i : IN std_logic_vector(2 downto 0);
    --- Ex ports outs ---
    ExeSrc_o, SETC_o : OUT STD_LOGIC;
    AluOpCode_o : OUT std_logic_vector(2 downto 0);
    Rsrc1_o, Rsrc2_o, Immediate_o : OUT std_logic_vector(31 downto 0);
    PC_o : OUT std_logic_vector(31 downto 0);
    loadStoreControlSignals_o : OUT std_logic_vector(2 downto 0);
    --- Mem flying ports ---
    MemRead_i, MemWrite_i : IN STD_LOGIC;
    MemRead_o, MemWrite_o : OUT STD_LOGIC;
    dstAddress_i :in STD_LOGIC_VECTOR(2 downto 0);
    dstAddress_o :out STD_LOGIC_VECTOR(2 downto 0);
    jumpControlSignals_i :in STD_LOGIC_VECTOR(2 downto 0);
    jumpControlSignals_o :out STD_LOGIC_VECTOR(2 downto 0);
    writeBackSignal_i :in STD_LOGIC_VECTOR(1 downto 0);
    writeBackSignal_o :out STD_LOGIC_VECTOR(1 downto 0);
    SPcontrolSignals_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    SPcontrolSignals_o : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    CCR_ENABLE_i : IN STD_LOGIC;
    CCR_ENABLE_o : OUT STD_LOGIC;
    Rs1_address_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    Rs2_address_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    Rs1_address_o : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    Rs2_address_o : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
  ) ;
end entity;


architecture archbuf of IDEx_buf is 

begin
  Process(Rst, Clk)
  begin
  if (Rst = '1') then
    ExeSrc_o <= '0';
    SETC_o <= '0';
    AluOpCode_o <= (others => '0');
    Rsrc1_o <= (others => '0');
    Rsrc2_o <= (others => '0');
    Immediate_o <= (others => '0');
    PC_o <= (others => '0');
    loadStoreControlSignals_o <= (others => '0');
    MemRead_o <= '0';
    MemWrite_o <= '0';
    dstAddress_o <= (others => '0');
    jumpControlSignals_o <= (others => '0');
    writeBackSignal_o <= (others => '0');
    SPcontrolSignals_o <= (others => '0');
    CCR_ENABLE_o <= '0';
    Rs1_address_o <= (Others => '0');
    Rs2_address_o <= (Others => '0');

  elsif rising_edge(Clk) AND LowActiveEnable = '0' then
    ExeSrc_o <= ExeSrc_i;
    SETC_o <= SETC_i;
    AluOpCode_o <= AluOpCode_i;
    Rsrc1_o <= Rsrc1_i;
    Rsrc2_o <= Rsrc2_i;
    Immediate_o <= Immediate_i;
    PC_o <= PC_i;
    loadStoreControlSignals_o <= LoadStoreControlSignals_i;
    MemRead_o <= MemRead_i;
    MemWrite_o <= MemWrite_i;
    dstAddress_o <= dstAddress_i;
    jumpControlSignals_o <= jumpControlSignals_i;
    writeBackSignal_o <= writeBackSignal_i;
    SPcontrolSignals_o <= SPcontrolSignals_i;
    CCR_ENABLE_o <= CCR_ENABLE_i;
    Rs1_address_o <= Rs1_address_i;
    Rs2_address_o <= Rs2_address_i;

  end if;
  end Process;
end architecture ; -- archbuf


