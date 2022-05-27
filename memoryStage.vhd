LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY memoryStage IS

    PORT (
        Clk : IN STD_LOGIC;
        Rst : IN STD_LOGIC;
        CCR : IN STD_LOGIC_VECTOR(2 downto 0);
        jumpControlSignal: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        memWriteRead: IN STD_LOGIC;
        SPControlSignal: IN STD_LOGIC_VECTOR(2 downto 0)
    );
END ENTITY;