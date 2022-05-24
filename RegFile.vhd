LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegFile IS

    PORT (
        Rst, Clk : IN STD_LOGIC;
        WriteAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ReadAddress1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        ReadAddress2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        WriteData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ReadData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        ReadData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        readEnable : IN STD_LOGIC;
        writeEnable : IN STD_LOGIC
    );

END ENTITY;

ARCHITECTURE RegFileArch OF RegFile IS

    SIGNAL RegInput0, RegInput1, RegInput2, RegInput3,
    RegInput4, RegInput5, RegInput6, RegInput7 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL RegOutput0, RegOutput1, RegOutput2, RegOutput3,
    RegOutput4, RegOutput5, RegOutput6, RegOutput7 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Enable0, Enable1, Enable2, Enable3,
    Enable4, Enable5, Enable6, Enable7 : STD_LOGIC;

BEGIN
    reg0 : entity work.Reg GENERIC map(32)
    PORT MAP(
        Rst => Rst,
        Clk => Clk,
        Enable => Enable0,
        RegInput => RegInput0,
        RegOutput => RegOutput0);

    reg1 : entity work.Reg GENERIC map(32)
    PORT MAP(
        Rst => Rst,
        Clk => Clk,
        Enable => Enable1,
        RegInput => RegInput1,
        RegOutput => RegOutput1);
    reg2 : entity work.Reg GENERIC map(32)
    PORT MAP(
        Rst => Rst,
        Clk => Clk,
        Enable => Enable2,
        RegInput => RegInput2,
        RegOutput => RegOutput2);
    reg3 : entity work.Reg GENERIC map(32)
    PORT MAP(
        Rst => Rst,
        Clk => Clk,
        Enable => Enable3,
        RegInput => RegInput3,
        RegOutput => RegOutput3);
    reg4 : entity work.Reg GENERIC map(32)
    PORT MAP(
        Rst => Rst,
        Clk => Clk,
        Enable => Enable4,
        RegInput => RegInput4,
        RegOutput => RegOutput4);
    reg5 : entity work.Reg GENERIC map(32)
    PORT MAP(
        Rst => Rst,
        Clk => Clk,
        Enable => Enable5,
        RegInput => RegInput5,
        RegOutput => RegOutput5);
    reg6 : entity work.Reg GENERIC map(32)
    PORT MAP(
        Rst => Rst,
        Clk => Clk,
        Enable => Enable6,
        RegInput => RegInput6,
        RegOutput => RegOutput6);
    reg7 : entity work.Reg GENERIC map(32)
    PORT MAP(
        Rst => Rst,
        Clk => Clk,
        Enable => Enable7,
        RegInput => RegInput7,
        RegOutput => RegOutput7);

    RegInput0 <= WriteData;
    RegInput1 <= WriteData;
    RegInput2 <= WriteData;
    RegInput3 <= WriteData;
    RegInput4 <= WriteData;
    RegInput5 <= WriteData;
    RegInput6 <= WriteData;
    RegInput7 <= WriteData;

    PROCESS (Clk)
    BEGIN
        IF rising_edge(Clk) THEN

            IF writeEnable = '1' THEN

                IF WriteAddress = "000"THEN
                    Enable0 <= '1';
                    Enable1 <= '0';
                    Enable2 <= '0';
                    Enable3 <= '0';
                    Enable4 <= '0';
                    Enable5 <= '0';
                    Enable6 <= '0';
                    Enable7 <= '0';
                ELSIF WriteAddress = "001"THEN
                    Enable0 <= '0';
                    Enable1 <= '1';
                    Enable2 <= '0';
                    Enable3 <= '0';
                    Enable4 <= '0';
                    Enable5 <= '0';
                    Enable6 <= '0';
                    Enable7 <= '0';
                ELSIF WriteAddress = "010"THEN
                    Enable0 <= '0';
                    Enable1 <= '0';
                    Enable2 <= '1';
                    Enable3 <= '0';
                    Enable4 <= '0';
                    Enable5 <= '0';
                    Enable6 <= '0';
                    Enable7 <= '0';
                ELSIF WriteAddress = "011"THEN
                    Enable0 <= '0';
                    Enable1 <= '0';
                    Enable2 <= '0';
                    Enable3 <= '1';
                    Enable4 <= '0';
                    Enable5 <= '0';
                    Enable6 <= '0';
                    Enable7 <= '0';
                ELSIF WriteAddress = "100"THEN
                    Enable0 <= '0';
                    Enable1 <= '0';
                    Enable2 <= '0';
                    Enable3 <= '0';
                    Enable4 <= '1';
                    Enable5 <= '0';
                    Enable6 <= '0';
                    Enable7 <= '0';
                ELSIF WriteAddress = "101"THEN
                    Enable0 <= '0';
                    Enable1 <= '0';
                    Enable2 <= '0';
                    Enable3 <= '0';
                    Enable4 <= '0';
                    Enable5 <= '1';
                    Enable6 <= '0';
                    Enable7 <= '0';
                ELSIF WriteAddress = "110"THEN
                    Enable0 <= '0';
                    Enable1 <= '0';
                    Enable2 <= '0';
                    Enable3 <= '0';
                    Enable4 <= '0';
                    Enable5 <= '0';
                    Enable6 <= '1';
                    Enable7 <= '0';
                ELSIF WriteAddress = "111"THEN
                    Enable0 <= '0';
                    Enable1 <= '0';
                    Enable2 <= '0';
                    Enable3 <= '0';
                    Enable4 <= '0';
                    Enable5 <= '0';
                    Enable6 <= '0';
                    Enable7 <= '1';
                END IF;
                
                END IF;

            END IF;
        END PROCESS;

    END ARCHITECTURE;