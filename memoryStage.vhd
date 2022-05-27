LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY memoryStage IS

    PORT (
        Clk : IN STD_LOGIC;
        Rst : IN STD_LOGIC;
        CCR : IN STD_LOGIC_VECTOR(2 downto 0);
        jumpControlSignal: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        memWriteReadControlSignal: IN STD_LOGIC;        -- 0 -> Write / 1 -> Read
        SPControlSignal: IN STD_LOGIC_VECTOR(2 downto 0)    -- 00 -> No Change / 01 -> +1 / 10 -> -1 
    );
END ENTITY;


ARCHITECTURE memArch OF memoryStage IS
BEGIN
