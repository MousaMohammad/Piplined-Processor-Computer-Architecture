Library ieee;
Use ieee.std_logic_1164.all;

entity exBufsInteg is
  port (
    Rst, Clk : IN STD_LOGIC;
    ExeSrc, SETC : IN STD_LOGIC;
    AluOpCode :IN std_logic_vector(2 downto 0);
    Rsrc1, Rsrc2, Immediate : IN std_logic_vector(31 downto 0);
    PC : IN std_logic_vector(31 downto 0);
    --- Outputs ---
    PC_o : OUT STD_LOGIC_VECTOR(31 downto 0);
    CCR_o : OUT STD_LOGIC_VECTOR(2 downto 0);
    Alu_o : OUT STD_LOGIC_VECTOR(31 downto 0)
  ) ;
end entity;

architecture arch of exBufsInteg is
--- signals from IDEx buf to execute stage ---
signal ExeSrc_o : std_logic;
signal SETC_o : std_logic;
signal AluOpCode_o : std_logic_vector(2 downto 0);
signal Rsrc1_o : std_logic_vector(31 downto 0);
signal Rsrc2_o : std_logic_vector(31 downto 0);
signal Immediate_o : std_logic_vector(31 downto 0);
signal PC_IDbuf : std_logic_vector(31 downto 0);
--- signals from execute stage to EX Mem buffer ---
signal CCR_Ex : std_logic_vector(2 downto 0);
signal Alu_Ex : std_logic_vector(31 downto 0);
signal PC_Ex : std_logic_vector(31 downto 0);
signal WriteData : std_logic_vector(31 downto 0);

begin

    ------from decode stage to ID/EX buffer------
    
    -- IDEx buf to execute stage --
    ID_Ex_buf: entity work.IDEx_buf port map(Rst,Clk,ExeSrc, SETC,AluOpCode,Rsrc1, Rsrc2, Immediate,PC,
        ExeSrc_o,SETC_o,AluOpCode_o,Rsrc1_o, Rsrc2_o, Immediate_o, PC_IDbuf,'0','0',open,open);
        
    executeSTG: entity work.ExecuteStage port map(Rst,Clk,ExeSrc_o,SETC_o,AluOpCode_o,Rsrc1_o, Rsrc2_o, Immediate_o, PC_IDbuf,
            CCR_Ex,PC_Ex,Alu_Ex,WriteData);
    -- execute stage to EX Mem buffer --
    memBuf: entity work.ExMem_buf port map(Rst,Clk, CCR_Ex, PC_Ex, Alu_Ex,WriteData
        PC_o, CCR_o, Alu_o);

end architecture ; -- arch
