Library ieee;
Use ieee.std_logic_1164.all;

Entity ALU IS
GENERIC (n : integer := 8);
	PORT(A,B:IN std_logic_vector (n-1 DOWNTO 0);
	     Cin:IN std_logic;
	     sel:IN std_logic_vector (3 DOWNTO 0);
	     Cout:OUT std_logic;
	     F:OUT std_logic_vector (n-1 DOWNTO 0));
END Entity;
