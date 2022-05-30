LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FU IS
    PORT (
        Rst : IN STD_LOGIC;
        Rs1_IDEX : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rs2_IDEX : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rdst_ALU : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rdst_Mem : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        writeBack_ALU : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        writeBack_Memory : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        FU_ALU_Rs1_Sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- 00:From decode, 01: From ALU, 10: From Memory 
        FU_ALU_Rs2_Sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) -- 00:From decode, 01: From ALU, 10: From Memory 
    );

END ENTITY;

ARCHITECTURE FU_Arch OF FU IS
BEGIN

    FU_ALU_Rs1_Sel <= "00" WHEN Rst = '1'
        ELSE
        "01" WHEN Rs1_IDEX = Rdst_ALU AND writeBack_ALU(1) = '1'
        ELSE
        "10" WHEN Rs1_IDEX = Rdst_Mem AND writeBack_Memory(1) = '1'
        ELSE
        "00";

    FU_ALU_Rs2_Sel <= "00" WHEN Rst = '1'
        ELSE
        "01" WHEN Rs2_IDEX = Rdst_ALU AND writeBack_ALU(1) = '1'
        ELSE
        "10" WHEN Rs2_IDEX = Rdst_Mem AND writeBack_Memory(1) = '1'
        ELSE
        "00";
END ARCHITECTURE;