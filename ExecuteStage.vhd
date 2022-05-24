Library ieee;
Use ieee.std_logic_1164.all;

entity ExecuteStage is
  port (
    ExeSrc:IN std_logic;
    SETC:IN std_logic;
    AluOpCode:IN std_logic_vector(2 downto 0);
    Rsrc1:IN std_logic_vector(31 downto 0);
    Rsrc2:IN std_logic_vector(31 downto 0);
    Immediate:IN std_logic_vector(31 downto 0);

    F:OUT std_logic_vector(31 downto 0);
  ) ;
end ExecuteStage;

architecture archEx of ExecuteStage is

  signal exeSrc:std_logic_vector(31 downto 0);
  -- CCR register signals --
  signal ccrIn:std_logic_vector(2 downto 0);
  signal ccrOut:std_logic_vector(2 downto 0);
  -- ALU signals to flag control --
  signal cToflag:std_logic;
  signal aluResult:std_logic_vector(31 downto 0);

begin
  -- choosing the source of the instruction is it immediate or register -- 
  srcMux: entity work.mux2_nbit GENERIC map(32) port map(Rsrc2, Immediate, ExeSrc, exeSrc);
  -- pass the instruction to the ALU --
  alu: entity work.alu_nbit GENERIC map(32) port map(Rsrc1, exeSrc, AluOpCode,ccrIn,aluResult,cToflag);
  F <= aluResult;
  -- wire alu with flag control --
  flagCU: entity work.flagControl port map(aluResult, cToflag, SETC, ccrOut);
  -- wire CCR register with flag control --
  

end archEx ; -- archEx