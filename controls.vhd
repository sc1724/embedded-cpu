library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;
entity controls is
port (
-- Timing Signals
clk , en , rst : in std_logic ;
-- Register File IO
rID1 , rID2 : out std_logic_vector (4 downto 0);
wr_enR1 , wr_enR2 : out std_logic ;
regrD1 , regrD2 : in std_logic_vector (15 downto 0);
regwD1 , regwD2 : out std_logic_vector (15 downto 0);
-- Framebuffer IO
fbRST : out std_logic ;
fbAddr1 : out std_logic_vector (11 downto 0);
fbDin1 : in std_logic_vector (15 downto 0);
fbDout1 : out std_logic_vector (15 downto 0);
-- Instruction Memory IO
irAddr : out std_logic_vector (13 downto 0);
irWord : in std_logic_vector (31 downto 0);
-- Data Memory IO
dAddr : out std_logic_vector (14 downto 0);
d_wr_en : out std_logic ;
dOut : out std_logic_vector (15 downto 0);
dIn : in std_logic_vector (15 downto 0);
-- ALU IO
aluA , aluB : out std_logic_vector (15 downto 0);
aluOp : out std_logic_vector (3 downto 0);
aluResult : in std_logic_vector (15 downto 0);
-- UART IO
ready , newChar : in std_logic ;
send : out std_logic ;
charRec : in std_logic_vector (7 downto 0);
charSend : out std_logic_vector (7 downto 0)
);
end controls;

architecture Behavioral of controls is
type state is (fetch,decode,Rops,Iops,Jops,calc,store,jr,recv,rpix,wpix,sendi,equals,nequal,ori,lw,sw,jmp,jal,clrscr,finish);
signal curr:state :=fetch;

begin
FSM:process(clk)
begin
if rising_edge(clk) then
if rst = '1' then
elsif en='1' then
case curr is
when fetch =>
curr<=decode;
when decode=>
if clk='1' then
curr<=Rops;
elsif clk='1' then
curr<=Iops;
else
curr<=Jops;
end if;
when Rops=>
curr<=decode;
when Iops=>
curr<=decode;
when Jops=>
curr<=decode;
when calc=>
curr<=store;
when store=>
curr<=finish;
when jr=>
curr<=store;
when recv=>
if newChar = '0' then
curr<=recv;
else
curr<=store;
end if;
when rpix=>
curr<=store;
when wpix=>
curr<=finish;
when sendi=>
if ready = '1' then
curr<=finish;
else
curr<=sendi;
end if;
when equals=>
curr<=store;
when nequal=>
curr<=store;
when lw=>
curr<=store;
when sw=>
curr<=store;
when jmp=>
curr<=finish;
when jal=>
curr<=finish;
when clrscr=>
fbRST<='1';
curr<=finish;
when finish=>
curr<=fetch;
end case;
end if;
end if;
end process;


end Behavioral;
