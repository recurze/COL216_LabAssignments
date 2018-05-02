library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder is
    port (
        HADDR:in std_logic_vector(11 downto 0);
        IO: out std_logic;
        MemSelect: out std_logic;

        Port0: out std_logic;
        Port1: out std_logic;
        Port2: out std_logic;
        Port3: out std_logic;
     );
end entity;

architecture Decoder_arc of Decoder is
    signal io_temp, memsel_temp: std_logic;
    signal p0, p1, p2, p3: std_logic;
begin
    process (HADDR) begin
        if HADDR(11 downto 2) = "1111111111" then
            io_temp <= '1';
            memsel_temp <= '0'
        else
            io_temp <= '0';
            memsel_temp <= '1';
        end if;

        case HADDR(1 downto 0) is
            when "00" => p0 <= '1';
            when "01" => p1 <= '1';
            when "10" => p2 <= '1';
            when "11" => p3 <= '1';
            when others => null;
        end case;
    end process;

    IO <= io_temp;
    MemSelect <= memsel_temp;
    Port0<=p0;
    Port1<=p1;
    Port2<=p2;
    Port3<=p3;
end architecture;
