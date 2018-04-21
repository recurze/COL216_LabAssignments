library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Alu is
    port (
        carry : in std_logic;
        opcode: in std_logic_vector(3 downto 0);
        input1: in std_logic_vector(31 downto 0);
        input2: in std_logic_vector(31 downto 0);
        result_f: out std_logic_vector(32 downto 0);
        result_r: out std_logic_vector(31 downto 0)
    );
end Alu;

architecture Alu_arc of Alu is
    signal a, b, temp_f:  std_logic_vector(32 downto 0);
    signal temp_r: std_logic_vector(31 downto 0);
begin
    a<='0'&input1;
    b<='0'&input2;
    process(a, b, opcode) begin
        case opcode is
            when "0000" => temp_f <= b and a;                 --and
            when "0001" => temp_f <= b xor a;                 --eor
            when "0010" => temp_f <= (not b) + a + 1;         --sub
            when "0011" => temp_f <= b + (not a) + 1;         --rsb
            when "0100" => temp_f <= b + a;                   --add
            when "0101" => temp_f <= b + a + carry;           --adc
            when "0110" => temp_f <= (not b) + a + carry;     --sbc
            when "0111" => temp_f <= b + (not a) + carry;     --rsc
            when "1000" => temp_f <= b and a;                 --tst;
            when "1001" => temp_f <= b xor a;                 --teq;
            when "1010" => temp_f <= (not b) + a + 1;         --cmp;
            when "1011" => temp_f <= b + a;                   --cmn;
            when "1100" => temp_f <= b or a;                  --orr
            when "1101" => temp_f <= b;                       --mov
            when "1110" => temp_f <= (not b) and  a;          --bic
            when "1111" => temp_f <= not b;                   --mvn
            when others => temp_f <= (others=>'0');
        end case;
    end process;

    result_f<=temp_f;
    process(temp_f, opcode) begin
        if (opcode="1000") or (opcode="1001") or (opcode="1010") or (opcode="1011") then
            result_r<=a(31 downto 0);
        else
            result_r<=temp_f(31 downto 0);
        end if;
    end process;
end Alu_arc;
