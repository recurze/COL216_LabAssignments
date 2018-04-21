library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_unsigned.ALL;

use WORK.mytypes.all;

entity memory is
    port (
        clk: in std_logic;
        rst: in std_logic;

        MR: in std_logic;
        MW: in std_logic;
        ad: in std_logic_vector(31 downto 0);
        wd: in std_logic_vector(31 downto 0);
        rd: out std_logic_vector(31 downto 0)
    );
end entity;

architecture memory_arc of memory is
    signal mem_arr: memory_array;
begin
    process(MR, MW, wd, ad, clk) begin
        -- instructions

        -- mov r0, #4
        mem_arr(0)<="11110011101000000000000000000100";

        -- ldr r1, [r0, #40]
        mem_arr(4)<="11110110100100000001000000101000";

        -- add r2, r1, r0
        mem_arr(8)<="11110000100000010010000000000000";

        --str r2, [r0, #44]
        mem_arr(12)<="11110110100000000010000000101100";

        --cmp r2, #6
        mem_arr(16)<="11110011010000100010000000000110";

        --beq 28
        mem_arr(20)<="00001010000000000000000000000001";

        --mov r3, r1, lsl #1
        mem_arr(24)<="11110001101000000011000010000001";

        --mov r3, r1, lsl #2
        mem_arr(28)<="11110001101000000011000100000001";

        --mem_arr(12)<=std_logic_vector(to_unsigned(109060140,32));
        --mem_arr(16)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(20)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(24)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(28)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(32)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(36)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(40)<=std_logic_vector(to_unsigned(,32));

        -- data
        mem_arr(44)<=std_logic_vector(to_unsigned(2,32));
        --mem_arr(48)<=std_logic_vector(to_unsigned(0,32));
        --mem_arr(52)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(56)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(60)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(64)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(68)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(72)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(76)<=std_logic_vector(to_unsigned(,32));
        --mem_arr(80)<=std_logic_vector(to_unsigned(,32));

        if rising_edge(clk) and MW='1' then
            mem_arr(to_integer(unsigned(ad)))<=wd;
        end if;

        if MR='1' then
            rd<=mem_arr(to_integer(unsigned(ad)));
        else
            rd<=(others=>'0');
        end if;
    end process;
end architecture;
