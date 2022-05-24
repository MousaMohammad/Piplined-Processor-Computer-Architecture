Library ieee;
Use ieee.std_logic_1164.all;

Entity ALU IS
GENERIC (n : integer := 32);
	PORT(
        A,B:IN std_logic_vector (n-1 DOWNTO 0);
	     opCode:IN std_logic_vector (3 DOWNTO 0);
	     CCR:IN std_logic_vector (2 DOWNTO 0);
	     F:OUT std_logic_vector (n-1 DOWNTO 0);
         Cout:OUT std_logic
         );
END Entity;

ARCHITECTURE archB OF ALU IS
BEGIN

    -- NOT --
    F <= NOT A WHEN opCode = "000"
    ELSE F;
    
    process( clk ) is
    begin
            -- SETC --
        if opCode = "000" then 
            CCR(2) <= '1';
            -- Not Rdst --
        elsif opCode = "001" then
            F <= NOT A;
            -- Z flag --
            if NOT A = (others => '0') then
                CCR(0) <= '1';
            else
                CCR(0) <= '0';
            end if;
            -- N flag --
            if NOT A < (others => '0') then
                CCR(1) <= '1';
            else
                CCR(1) <= '0';
            end if;
            -- incerement A --
        elsif opCose = "010" then
            F <= A + '1';
            
            
            

        end if;
            
        
    end process ;

Cout <= '0';
 
END ARCHITECTURE;
