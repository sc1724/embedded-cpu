
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity my_alu is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Opcode : in STD_LOGIC_VECTOR (3 downto 0);
           Output : out STD_LOGIC_VECTOR (3 downto 0);
           en : in STD_LOGIC);
end my_alu;

architecture Behavioral of my_alu is

begin
proc:process(A,B,Opcode,en)
begin
if en='1' then
case(Opcode)is
when x"0"=>
Output<=std_logic_vector(unsigned(A)+unsigned(B));
when x"1"=>
Output<=std_logic_vector(unsigned(A)-unsigned(B));
when x"2"=>
Output<=std_logic_vector(unsigned(A)+1);
when x"3"=>
Output<=std_logic_vector(unsigned(A)-1);
when x"4"=>
Output<=std_logic_vector(0-unsigned(A));
when x"5"=>
Output<=std_logic_vector(unsigned(A)sll 1);
when x"6"=>
Output<=std_logic_vector(unsigned(A)srl 1);
when x"7"=>
Output<=A(15)&A(15)&A(14)&A(13)&A(12)&A(11)&A(10)&A(9)&A(8)&A(7)&A(6)&A(5)&A(4)&A(3)&A(2)&A(1);
when x"8"=>
Output<=std_logic_vector(unsigned(A)AND unsigned(B));
when x"9"=>
Output<=std_logic_vector(unsigned(A)OR unsigned(B));
when x"A"=>
Output<=std_logic_vector(unsigned(A)XOR unsigned(B));
when x"B"=>
if (signed(A)<signed(B)) then
Output<=x"1";
else
Output<=x"0";
end if;
when x"C"=>
if (signed(A)>signed(B)) then
Output<=x"1";
else
Output<=x"0";
end if;
when x"D"=>
if (unsigned(A)=unsigned(B)) then
Output<=x"1";
else
Output<=x"0";
end if;
when x"E"=>
if (unsigned(A)<unsigned(B)) then
Output<=x"1";
else
Output<=x"0";
end if;
when x"F"=>
if (unsigned(A)>unsigned(B)) then
Output<=x"1";
else
Output<=x"0";
end if;
end case;
end if;
end process proc;
end Behavioral;
