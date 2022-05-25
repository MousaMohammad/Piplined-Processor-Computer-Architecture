LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RegFile IS

    PORT (
        Rst, Clk : IN STD_LOGIC;
        writeAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        readAddress1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        readAddress2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        writeData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        readData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        readData2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        readEnable : IN STD_LOGIC;
        writeEnable : IN STD_LOGIC
    );

END ENTITY;

ARCHITECTURE RegFileArch OF RegFile IS

    COMPONENT Decoder IS
        PORT (
            S : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            enable : IN STD_LOGIC;
            oupt : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
    END COMPONENT;

    SIGNAL write_enable_internal : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL read_enable_internal1 : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL read_enable_internal2 : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL RegOutput0, RegOutput1, RegOutput2, RegOutput3, RegOutput4,
    RegOutput5, RegOutput6, RegOutput7 : STD_LOGIC_VECTOR (31 DOWNTO 0);
BEGIN

    reg0 : ENTITY work.Reg GENERIC MAP(32) PORT MAP(Rst, Clk, write_enable_internal(0), writeData, RegOutput0);
    reg1 : ENTITY work.Reg GENERIC MAP(32) PORT MAP(Rst, Clk, write_enable_internal(1), writeData, RegOutput1);
    reg2 : ENTITY work.Reg GENERIC MAP(32) PORT MAP(Rst, Clk, write_enable_internal(2), writeData, RegOutput2);
    reg3 : ENTITY work.Reg GENERIC MAP(32) PORT MAP(Rst, Clk, write_enable_internal(3), writeData, RegOutput3);
    reg4 : ENTITY work.Reg GENERIC MAP(32) PORT MAP(Rst, Clk, write_enable_internal(4), writeData, RegOutput4);
    reg5 : ENTITY work.Reg GENERIC MAP(32) PORT MAP(Rst, Clk, write_enable_internal(5), writeData, RegOutput5);
    reg6 : ENTITY work.Reg GENERIC MAP(32) PORT MAP(Rst, Clk, write_enable_internal(6), writeData, RegOutput6);
    reg7 : ENTITY work.Reg GENERIC MAP(32) PORT MAP(Rst, Clk, write_enable_internal(7), writeData, RegOutput7);

    writeDecoder : Decoder PORT MAP(S => writeAddress, enable => writeEnable, oupt => write_enable_internal);
    readDecoder1 : Decoder PORT MAP(S => readAddress1, enable => readEnable, oupt => read_enable_internal1);
    readDecoder2 : Decoder PORT MAP(S => readAddress2, enable => readEnable, oupt => read_enable_internal2);

    --tri 01 means: 0 -> Reg 0, 1 -> read 1
    tri01 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal1(0), RegOutput0, readData1);
    tri11 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal1(1), RegOutput1, readData1);
    tri21 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal1(2), RegOutput2, readData1);
    tri31 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal1(3), RegOutput3, readData1);
    tri41 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal1(4), RegOutput4, readData1);
    tri51 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal1(5), RegOutput5, readData1);
    tri61 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal1(6), RegOutput6, readData1);
    tri71 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal1(7), RegOutput7, readData1);

    tri02 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal2(0), RegOutput0, readData2);
    tri12 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal2(1), RegOutput1, readData2);
    tri22 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal2(2), RegOutput2, readData2);
    tri32 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal2(3), RegOutput3, readData2);
    tri42 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal2(4), RegOutput4, readData2);
    tri52 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal2(5), RegOutput5, readData2);
    tri62 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal2(6), RegOutput6, readData2);
    tri72 : ENTITY work.TriState GENERIC MAP(32) PORT MAP(read_enable_internal2(7), RegOutput7, readData2);

END ARCHITECTURE;