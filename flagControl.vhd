Library ieee;
Use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity flagControl is
  port (
    aluRes:IN std_logic_vector (31 DOWNTO 0);
    carry:IN std_logic;
    setc:IN std_logic;
    CCRin:IN std_logic_vector (2 DOWNTO 0);
    CCR:OUT std_logic_vector (2 DOWNTO 0);
    F:OUT std_logic_vector (31 DOWNTO 0)
  );
end flagControl;

architecture flagarch of flagControl is
begin

    -- CCR(0) = Z flag, CCR(1) = N flag, CCR(2) = C flag --
    CCR(0) <= '1' WHEN aluRes /= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" and aluRes = "00000000000000000000000000000000" ELSE '0';
    CCR(1) <= '1' WHEN aluRes /= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" and (signed(aluRes) < 0) ELSE '0';
    CCR(2) <= carry WHEN (setc = '0' or setc = 'U') and (carry = '1' or carry =  '0')
    ELSE '1' WHEN setc = '1'
    ELSE CCRin(2);

    F <= aluRes;

end flagarch ; -- flagarch


