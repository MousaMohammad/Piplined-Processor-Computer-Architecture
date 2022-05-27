Library ieee;
Use ieee.std_logic_1164.all;

entity IDEx_buf is
  port (
    Rst, Clk : IN STD_LOGIC;
    --- Ex ports --- 
    ExeSrc_i, SETC_i : IN STD_LOGIC;
    AluOpCode_i :IN std_logic_vector(2 downto 0);
    Rsrc1_i, Rsrc2_i, Immediate_i : IN std_logic_vector(31 downto 0);
    PC_i : IN std_logic_vector(31 downto 0);
    --- Ex ports outs ---
    ExeSrc_o, SETC_o : OUT STD_LOGIC;
    AluOpCode_o : OUT std_logic_vector(2 downto 0);
    Rsrc1_o, Rsrc2_o, Immediate_o : OUT std_logic_vector(31 downto 0);
    PC_o : OUT std_logic_vector(31 downto 0);
    --- Mem flying ports ---
    MemRead_i, MemWrite_i : IN STD_LOGIC;
    MemRead_o, MemWrite_o : OUT STD_LOGIC

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
    MemRead_o <= '0';
    MemWrite_o <= '0';
  elsif rising_edge(Clk) then
    ExeSrc_o <= ExeSrc_i;
    SETC_o <= SETC_i;
    AluOpCode_o <= AluOpCode_i;
    Rsrc1_o <= Rsrc1_i;
    Rsrc2_o <= Rsrc2_i;
    Immediate_o <= Immediate_i;
    PC_o <= PC_i;
    MemRead_o <= MemRead_i;
    MemWrite_o <= MemWrite_i;
  end if;
  end Process;
end architecture ; -- archbuf


