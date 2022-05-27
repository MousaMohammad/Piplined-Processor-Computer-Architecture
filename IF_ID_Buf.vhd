Library ieee;
Use ieee.std_logic_1164.all;

Entity IFID_buf is

port (
clk : in std_logic;
rst : in std_logic;
instruction_i : in std_logic_vector(31 downto 0);
readEnable_i : in std_logic;

readEnable_o : out std_logic;
instruction_o : out std_logic_vector(31 downto 0)


);

end entity;

architecture IFID_BUF_ARCH of IFID_buf IS

begin

    Process(Rst, Clk)
  begin
  if (Rst = '1') then
    readEnable_o <= '0';
    instruction_o <= (others => '0');
  elsif rising_edge(Clk) then
    instruction_o <= instruction_i;
    readEnable_o <= readEnable_i;
  end if;
  end Process;

end IFID_BUF_ARCH;

