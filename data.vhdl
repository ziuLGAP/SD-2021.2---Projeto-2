LIBRARY ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

ENTITY data IS
PORT ( SENHA,D, CLK, RFLP  : IN STD_LOGIC ;
resetR,resetC, Insira: IN STD_LOGIC ;
FP : OUT STD_LOGIC;
Q, Count      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) 
) ;
END data ;
ARCHITECTURE Behavior OF data IS
SIGNAL R : STD_LOGIC_VECTOR(3 DOWNTO 0) ;
SIGNAL C : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    PROCESS (resetR,resetC, Insira)
        BEGIN
            IF resetC = '1' THEN 
                C <= "0000";
            ELSIF resetR = '1' THEN
                R <= "0000";
            ELSIF rising_edge(Insira) THEN 
                C <= C + 1;
                R(3) <= SENHA;
                R(2) <= R(3);
                R(1) <= R(2);
                R(0) <= R(1);
            END IF ;
    END PROCESS ;
    PROCESS (CLK, RFLP)
        BEGIN
            IF RFLP = '1' THEN 
                FP <= '0';
            ELSIF rising_edge(CLK) THEN 
                FP <= D;
            END IF ;
    END PROCESS ;
    Q <= R;
    Count <= (C);
END Behavior ;
