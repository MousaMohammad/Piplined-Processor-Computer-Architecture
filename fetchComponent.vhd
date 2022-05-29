LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fetchComponent IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        PC_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PC_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END ENTITY fetchComponent;

ARCHITECTURE fetchComponentArch OF fetchComponent IS

    
BEGIN

    process( clk )
    begin
        if rising_edge( clk ) then
            if rst = '1' then
                PC_out <= (others => '0');
            else
                PC_out <= PC_in;
            end if;
        end if;
    end process; 


end architecture;