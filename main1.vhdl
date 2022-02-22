--------------------------------------------------------------------------------
-- Project :
-- File    :
-- Autor   :
-- Date    :
--
--------------------------------------------------------------------------------
-- Description :
--
--------------------------------------------------------------------------------

LIBRARY ieee ;
use ieee.std_logic_1164.all ;

ENTITY main1 IS
  PORT (
  ------------------------------------------------------------------------------
  --Insert input ports below
    SW: in std_logic_vector(17 downto 0) ;  -- input bit example -- input vector example
  ------------------------------------------------------------------------------
  --Insert output ports below                    -- output bit example
    G_HEX6, G_HEX4, G_HEX3,G_HEX2,G_HEX1: out std_logic_vector(6 downto 0);
    G_LEDG: out std_logic_vector(8 downto 0);
    G_LED: out std_logic_vector(17 downto 0)
-- output vector example
    );
END main1;

--------------------------------------------------------------------------------
--Complete your VHDL description below
--------------------------------------------------------------------------------

ARCHITECTURE TypeArchitecture OF main1 IS
    component control IS
        PORT ( CLI,NCLI,SENHAADD,SENSOR,FRONT,INSIRA,BACK,NOTA1,NOTA2: IN STD_LOGIC;
        RE,CO: IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
        SENHAREGISTER, REGISTERRESET, ABRIR, CLK, RFLP, D1 : OUT STD_LOGIC;
        FALTA,PAGAR     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) 
        ) ;
    END component;
    COMPONENT data IS
        PORT ( SENHA,D, CLK, RFLP  : IN STD_LOGIC ;
        resetR,resetC, Insira: IN STD_LOGIC ;
        FP : OUT STD_LOGIC;
        Q, Count      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) 
        ) ;
    END COMPONENT ;
SIGNAL SENHAREG, REGISTERRESET, ABRIR, CLK, RFPL, D1, FP : STD_LOGIC;
SIGNAL FALTA, PAGAR, COUNT, COUNT1, Q, SENHANDO : STD_LOGIC_VECTOR(3 DOWNTO 0) ;
BEGIN
c1: data port map(SENHAREG,D1,CLK,RFPL,REGISTERRESET,ABRIR,SW(6),FP,Q,COUNT);
COUNT1(1 DOWNTO 0) <= NOT COUNT(1 DOWNTO 0) ;
COUNT1(3 DOWNTO 2) <= COUNT(3 DOWNTO 2) ; 
g1: control port map(SW(0),SW(1),SW(2),SW(5),FP,SW(7),SW(8),SW(3),SW(4),Q,COUNT1,SENHAREG, REGISTERRESET, ABRIR, CLK, RFPL, D1, FALTA, PAGAR);
PROCESS(PAGAR)
BEGIN
    IF (((SW(0) OR SW(1)) AND FP) = '1') AND PAGAR = "0000" then
    SENHANDO <= "1111";
    else
    SENHANDO <= PAGAR;
    END IF;
    case PAGAR is
        when "0000"=> G_HEX6 <="1111111";
        when "0101"=> G_HEX6 <="0010010";
        when "0111"=> G_HEX6 <="1111000";
        when others=> G_HEX6 <="1111111";
    end case;
END PROCESS;
PROCESS(FALTA)
    BEGIN
    case FALTA is 
        when "0000"=> G_HEX4 <="1111111";
        when "0001"=> G_HEX4 <="1111001";
        when "0010"=> G_HEX4 <="0100100";
        when "0011"=> G_HEX4 <="0110000";
        when "0100"=> G_HEX4 <="0011001";
        when "0101"=> G_HEX4 <="0010010";
        when "0110"=> G_HEX4 <="0000010";
        when "0111"=> G_HEX4 <="1111000";
        when others=> G_HEX4 <="1111111";
    END CASE;
END PROCESS;
PROCESS(SENHANDO)
    BEGIN
    case SENHANDO is 
        when "0000"=> G_HEX2 <="0010010";
        when "0101"=> G_HEX2 <="1000111";
        when "0111"=> G_HEX2 <="1111001";
        when "1111"=> G_HEX2 <="0000110";
        when others=> G_HEX2 <="0000000";
    END CASE;
END PROCESS;
PROCESS(SENHANDO)
    BEGIN
    case SENHANDO is 
        when "0000"=> G_HEX3 <="0000110";
        when "0101"=> G_HEX3 <="1000110";
        when "0111"=> G_HEX3 <="1000001";
        when "1111"=> G_HEX3 <="0010010";
        when others=> G_HEX3 <="0000000";
    END CASE;
END PROCESS;
PROCESS(SENHANDO)
    BEGIN
    case SENHANDO is 
        when "0000"=> G_HEX1 <="0001100";
        when "0101"=> G_HEX1 <="1111001";
        when "0111"=> G_HEX1 <="0010010";
        when "1111"=> G_HEX1 <="1001000";
        when others=> G_HEX1 <="0000000";
    END CASE;
END PROCESS;
G_LEDG(0) <= ABRIR;
G_LEDG(1) <= ABRIR;
G_LEDG(2) <= ABRIR;
G_LEDG(3) <= ABRIR;
G_LEDG(4) <= ABRIR;
G_LEDG(5) <= ABRIR;
G_LEDG(6) <= ABRIR;
G_LEDG(7) <= ABRIR;
G_LEDG(8) <= ABRIR;
G_LED(0) <= NOT ABRIR;
G_LED(1) <= NOT ABRIR;
G_LED(2) <= NOT ABRIR;
G_LED(3) <= NOT ABRIR;
G_LED(4) <= NOT ABRIR;
G_LED(5) <= NOT ABRIR;
G_LED(6) <= NOT ABRIR;
G_LED(7) <= NOT ABRIR;
G_LED(8) <= NOT ABRIR;
G_LED(9) <= NOT ABRIR;
G_LED(10) <= NOT ABRIR;

END TypeArchitecture;