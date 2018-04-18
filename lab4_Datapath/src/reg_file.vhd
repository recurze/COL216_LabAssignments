library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use WORK.mytypes.all;

entity reg_file is
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
end reg_file;

architecture reg_file_arc of reg_file is
    signal reg_array: register_array;
begin
    rd1<=reg_arr(to_integer(unsigned(rad1)));
    rd2<=reg_arr(to_integer(unsigned(rad2)));

    process(clk) begin
        if rising_edge(clk) and RW='1' then
            reg_arr(to_integer(unsigned(wad)))<=wd;
        end if;
    end process;
end architecture;
