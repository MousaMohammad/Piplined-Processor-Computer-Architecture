LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ExecuteStage IS
  PORT (
    Rst, Clk : IN STD_LOGIC;
    ExeSrc : IN STD_LOGIC;
    SETC : IN STD_LOGIC;
    AluOpCode : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    Rsrc1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Rsrc2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Immediate : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    PCin : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    CCR_en : IN STD_LOGIC;
    CCR_o : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    PCout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    F : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    WriteData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    FU_ALU_Rs1_Sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- 00:From decode, 01: From ALU, 10: From Memory 
    FU_ALU_Rs2_Sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- 00:From decode, 01: From ALU, 10: From Memory 
    ALU_Output : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    Memory_Output : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END ExecuteStage;

ARCHITECTURE archEx OF ExecuteStage IS

  SIGNAL exeSrcSig : STD_LOGIC_VECTOR(31 DOWNTO 0);
  -- CCR register signals --
  SIGNAL ccrIn : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL ccrOut : STD_LOGIC_VECTOR(2 DOWNTO 0);
  -- ALU signals to flag control --
  SIGNAL cToflag : STD_LOGIC;
  SIGNAL aluResult : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL Operand1, Operand2 : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

  Operand1 <= Rsrc1 WHEN FU_ALU_Rs1_Sel = "00"
    ELSE
    ALU_Output WHEN FU_ALU_Rs1_Sel = "01"
    ELSE
    Memory_Output WHEN FU_ALU_Rs1_Sel = "10";

  Operand2 <= Rsrc2 WHEN FU_ALU_Rs2_Sel = "00"
    ELSE
    ALU_Output WHEN FU_ALU_Rs2_Sel = "01"
    ELSE
    Memory_Output WHEN FU_ALU_Rs2_Sel = "10";

  -- choosing the source of the instruction is it immediate or register -- 
  srcMux : ENTITY work.mux2_nbit GENERIC MAP(32) PORT MAP(Operand2, Immediate, ExeSrc, exeSrcSig);
  -- pass the instruction to the ALU --
  alu : ENTITY work.ALU GENERIC MAP(32) PORT MAP(Operand1, exeSrcSig, AluOpCode, ccrIn, aluResult, cToflag);
  -- wire alu with flag control --
  flagCU : ENTITY work.flagControl PORT MAP(aluResult, cToflag, SETC, ccrIn, ccrOut, F);
  -- wire CCR register with flag control --
  ccr : ENTITY work.Reg GENERIC MAP(3) PORT MAP(Rst, Clk, CCR_en, ccrOut, ccrIn);
  CCR_o <= ccrIn;
  -- add PCin with immediate --
  PCadder : ENTITY work.my_nadder GENERIC MAP(32) PORT MAP(PCin, Immediate, '0', PCout, OPEN);
  --- Rscr2 to WriteData --
  WriteData <= Operand2;

END archEx; -- archEx