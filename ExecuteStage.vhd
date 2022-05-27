Library ieee;
Use ieee.std_logic_1164.all;

entity ExecuteStage is
  port (
    Rst, Clk : IN STD_LOGIC;
    ExeSrc:IN std_logic;
    SETC:IN std_logic;
    AluOpCode:IN std_logic_vector(2 downto 0);
    Rsrc1:IN std_logic_vector(31 downto 0);
    Rsrc2:IN std_logic_vector(31 downto 0);
    Immediate:IN std_logic_vector(31 downto 0);
    PCin:IN std_logic_vector(31 downto 0);
    CCR_o:OUT std_logic_vector(2 downto 0);
    PCout:OUT std_logic_vector(31 downto 0);
    F:OUT std_logic_vector(31 downto 0)
  ) ;
end ExecuteStage;

architecture archEx of ExecuteStage is

  signal exeSrcSig:std_logic_vector(31 downto 0);
  -- CCR register signals --
  signal ccrIn:std_logic_vector(2 downto 0);
  signal ccrOut:std_logic_vector(2 downto 0);
  -- ALU signals to flag control --
  signal cToflag:std_logic;
  signal aluResult:std_logic_vector(31 downto 0);

begin
  -- choosing the source of the instruction is it immediate or register -- 
  srcMux: entity work.mux2_nbit GENERIC map(32) port map(Rsrc2, Immediate, ExeSrc, exeSrcSig);
  -- pass the instruction to the ALU --
  alu: entity work.ALU GENERIC map(32) port map(Rsrc1, exeSrcSig, AluOpCode,ccrIn,aluResult,cToflag);
  -- wire alu with flag control --
  flagCU: entity work.flagControl port map(aluResult, cToflag, SETC, ccrIn,ccrOut,F);
  -- wire CCR register with flag control --
  ccr: entity work.Reg GENERIC map(3) port map(Rst, Clk, '1',ccrOut, ccrIn);
  CCR_o <= ccrIn;
  -- add PCin with immediate --
  PCadder: entity work.my_nadder GENERIC map(32) port map(PCin, Immediate,'0', PCout,open);

end archEx ; -- archEx