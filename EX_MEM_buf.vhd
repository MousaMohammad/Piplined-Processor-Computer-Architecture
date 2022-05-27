Library ieee;
Use ieee.std_logic_1164.all;

entity ExMem_buf is
  port (
    Rst, Clk : IN STD_LOGIC;
    -- Ex ports --
    CCR_i : IN STD_LOGIC_VECTOR(2 downto 0);
    PC_i : IN STD_LOGIC_VECTOR(31 downto 0);
    Alu_i : IN STD_LOGIC_VECTOR(31 downto 0);
    WriteData_i : OUT STD_LOGIC_VECTOR(31 downto 0);
    PC_o : OUT STD_LOGIC_VECTOR(31 downto 0);
    CCR_o : OUT STD_LOGIC_VECTOR(2 downto 0);
    Alu_o : OUT STD_LOGIC_VECTOR(31 downto 0);
    WriteData_o : OUT STD_LOGIC_VECTOR(31 downto 0);
  );
end entity;

architecture arch of ExMem_buf is
begin
    process(Rst, Clk) is
        begin
            if Rst = '1' then
                PC_o <= (others => '0');
                CCR_o <= (others => '0');
                Alu_o <= (others => '0');
                WriteData_o <= (others => '0');
            elsif rising_edge(Clk) then
                PC_o <= PC_i;
                CCR_o <= CCR_i;
                Alu_o <= Alu_i;
                WriteData_o <= WriteData_i;
            end if;
        end process;
end arch ; -- arch
