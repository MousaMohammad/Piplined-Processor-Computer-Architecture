LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY IFID_buf IS

  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    instruction_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    readEnable_i : IN STD_LOGIC;
    PC_i : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    readEnable_o : OUT STD_LOGIC;
    instruction_o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    PC_o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

  );

END ENTITY;

ARCHITECTURE IFID_BUF_ARCH OF IFID_buf IS

BEGIN

  PROCESS (Rst, Clk)
  BEGIN
    IF (Rst = '1') THEN
      readEnable_o <= '0';
      instruction_o <= (OTHERS => '0');
      PC_o <= (OTHERS => '0');
    ELSIF rising_edge(Clk) THEN
      instruction_o <= instruction_i;
      readEnable_o <= readEnable_i;
      PC_o <= PC_i;
    END IF;
  END PROCESS;

END IFID_BUF_ARCH;