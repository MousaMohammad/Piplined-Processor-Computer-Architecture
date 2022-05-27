LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY memoryStage IS

    PORT (
        Clk : IN std_logic;
        Rst : IN std_logic;
        mem_read : IN std_logic;
        mem_write : IN std_logic;
        mem_address : IN std_logic_vector(31 downto 0);
        mem_data_in : IN std_logic_vector(31 downto 0);
        mem_data_out : OUT std_logic_vector(31 downto 0)
    );
END ENTITY;