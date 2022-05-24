Library ieee;
Use ieee.std_logic_1164.all;

entity flagControl is
  port (
    aluRes:IN std_logic_vector (31 DOWNTO 0);
    carry:IN std_logic;
    setc:IN std_logic;
    CCR:OUT std_logic_vector (2 DOWNTO 0)
  );
end flagControl;

architecture flagarch of flagControl is
begin

    -- CCR(0) = Z flag, CCR(1) = N flag, CCR(2) = C flag --
    CCR(0) <= '1' WHEN aluRes = "00000000000000000000000000000000" ELSE '0';
    CCR(1) <= '1' WHEN aluRes < "00000000000000000000000000000000" ELSE '0';
    CCR(2) <= carry WHEN setc = '0' ELSE '1';

end flagarch ; -- flagarch
