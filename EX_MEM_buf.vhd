LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ExMem_buf IS
  PORT (
    Rst, Clk : IN STD_LOGIC;
    -- Ex ports --
    CCR_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    PC_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Alu_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    WriteData_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    PC_o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    CCR_o : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    Alu_o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    WriteData_o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    jumpControlSignal_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    jumpControlSignal_o : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    memWriteControlSignal_i : IN STD_LOGIC;
    memWriteControlSignal_o : OUT STD_LOGIC;
    memReadControlSignal_i : IN STD_LOGIC;
    memReadControlSignal_o : OUT STD_LOGIC;
    SPControlSignal_i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    SPControlSignal_o : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    writeBackControlSignal_i : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    writeBackControlSignal_o : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    RegFileAddressWB_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    RegFileAddressWB_o : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE arch OF ExMem_buf IS
BEGIN
  PROCESS (Rst, Clk) IS
  BEGIN
    IF Rst = '1' THEN
      PC_o <= (OTHERS => '0');
      CCR_o <= (OTHERS => '0');
      Alu_o <= (OTHERS => '0');
      WriteData_o <= (OTHERS => '0');
      jumpControlSignal_o <= (OTHERS => '0');
      memWriteControlSignal_o <= '0';
      memReadControlSignal_o <= '0';
      SPControlSignal_o <= (OTHERS => '0');
      writeBackControlSignal_o <= (OTHERS => '0');
      RegFileAddressWB_o <= (OTHERS => '0');
    ELSIF rising_edge(Clk) THEN
      PC_o <= PC_i;
      CCR_o <= CCR_i;
      Alu_o <= Alu_i;
      WriteData_o <= WriteData_i;
      jumpControlSignal_o <= jumpControlSignal_i;
      memWriteControlSignal_o <= memWriteControlSignal_i;
      memReadControlSignal_o <= memReadControlSignal_i;
      SPControlSignal_o <= SPControlSignal_i;
      writeBackControlSignal_o <= writeBackControlSignal_i;
      RegFileAddressWB_o <= RegFileAddressWB_i;
    END IF;
  END PROCESS;
END arch; -- arch