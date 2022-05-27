@@ -0,0 +1,27 @@
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MemWB_buf IS
    PORT (
        Rst, Clk : IN STD_LOGIC;
        writeBackSignal_In : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        writeBackSignal_Out : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        Memory_Output_In : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Memory_Output_Out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALU_Output_In: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALU_Output_Out: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        writeAddressRegFile_In: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        writeAddressRegFile_Out: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        
    );
END ENTITY;

ARCHITECTURE archMemWB_buf OF MemWB_buf IS
BEGIN
    PROCESS (Rst, Clk) IS
    BEGIN
        IF Rst = '1' THEN
            writeBackSignal_Out <= (others => '0');
            Memory_Output_Out <= (others => '0');
            ALU_Output_Out <= (others => '0');
            writeAddressRegFile_Out <= (others => '0');
        ELSIF rising_edge(Clk) THEN
            writeBackSignal_Out <= writeBackSignal_In;
            Memory_Output_Out <= Memory_Output_In;
            ALU_Output_Out <= ALU_Output_In;
            writeAddressRegFile_Out <= writeAddressRegFile_In;
        END IF;
        END IF;
    END PROCESS;
END archMemWB_buf;