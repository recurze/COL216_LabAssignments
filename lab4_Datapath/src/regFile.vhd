library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FF is
    port(
        clk: in std_logic;
        D: in std_logic;
        Q: out std_logic
    );
end D_FF;

architecture D_FF_arc of D_FF is
begin
    process(clk)
    begin
       if clk='1' and clk'EVENT  then
           Q <= D;
       end if;
    end process;
end architecture;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register32 is
    port(
        clk:in std_logic;
        a:in std_logic_vector(31 downto 0);
        k:out std_logic_vector(31 downto 0)
    );
end register32;

architecture register32_arc of register32 is
begin
  D_FF32:
  for i in 0 to 31 generate
      R:
      entity WORK.D_FF port map(
          clk=>clk,
          D=>a(i),
          Q=> k(i)
      );
  end generate;
end architecture;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity regFile is
  port (
    clk : in std_logic;
    rst : in std_logic;
    RW  : in std_logic;
    rad1: in std_logic_vector(3 downto 0);
    rad2: in std_logic_vector(3 downto 0);
    wad : in std_logic_vector(3 downto 0);
    wd  : in std_logic_vector(31 downto 0);
    rd1 : out std_logic_vector(31 downto 0);
    rd2 : out std_logic_vector(31 downto 0)
  );
end regFile;

architecture regFile_arc of regFile is
    signal a: std_logic_vector(31 downto 0);
    type register_array is array (0 to 15) of std_logic_vector(31 downto 0);
    signal in_data : register_array;
    signal out_data : register_array;
begin
    a<=wd;

    REG_FILE16:
    for i in 0 to 15 generate
        r:
        entity WORK.register32 port map (
          clk=>clk,
          a=>in_data(i),
          k=>out_data(i)
        );
    end generate;

    process(clk)
    begin
        if rising_edge(clk) then
            if(RW='1') then
                in_data(to_integer(unsigned(wad)))<=a;
            end if;
        end if;
    end process;

    rd1<=out_data(to_integer(unsigned(rad1)));
    rd2<=out_data(to_integer(unsigned(rad2)));
end architecture;
