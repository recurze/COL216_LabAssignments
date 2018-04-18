library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Actrl_tb is
end Actrl_tb;

architecture Actrl_tb_arc of Actrl_tb is
    signal clk : std_logic := '0';

    signal ins: std_logic_vector(10 downto 0);
    signal op: std_logic_vector(3 downto 0);

    signal err_cnt_signal : integer := 1;
    constant clk_period : time := 10 ns;
begin
    uut:
    entity WORK.Actrl port map(
        ins=>ins,
        op=>op,
    );

    clk_process: process begin
        clk<='0';
        wait for clk_period/2;
        clk<='1';
        wait for clk_period/2;
    end process;

    stim_process: process 
        variable err_cnt : INTEGER := 0;
    begin
        -----------------------------------------------------------
        -------------------- pre-case DP --------------------------
        -----------------------------------------------------------
        ins<="0001101001";
        wait for clk_period;
        -----------------------------------------------------------
        ------------------  case DP--------------------------------
        -----------------------------------------------------------
        assert (op = "0110") report "Error: p of eq1 is wrong";
        if (op /= "0110") then
            err_cnt:=err_cnt+1;
        end if;

        ----------------------------------------------------------
        ------------------ pre-case Mul---------------------------
        ----------------------------------------------------------
        ins<="0001100001";
        wait for clk_period;
        -----------------------------------------------------------
        ------------------  case Mul-------------------------------
        -----------------------------------------------------------
        assert (op = "1101") report "Error: p of eq2 is wrong";
        if (op /= "1101") then
            err_cnt:=err_cnt+1;
        end if;

        -----------------------------------------------------------
        ---------------  pre-case DTU------------------------------
        -----------------------------------------------------------
        ins<="0101100001";
        wait for clk_period;
        -----------------------------------------------------------
        ------------------  case DTU------------------------------
        -----------------------------------------------------------
        assert (op = "0100") report "Error: p of neq2 is wrong";
        if (op /= "0100") then
            err_cnt:=err_cnt+1;
        end if;

        -----------------------------------------------------------
        ---------------  pre-case DTD------------------------------
        -----------------------------------------------------------
        ins<="0100100001";
        wait for clk_period;
        -----------------------------------------------------------
        ------------------  case DTD------------------------------
        -----------------------------------------------------------
        assert (op = "0010") report "Error: p of neq2 is wrong";
        if (op /= "0010") then
            err_cnt:=err_cnt+1;

        -----------------------------------------------------------
        --------------------pre case Branch ---------------------
        -----------------------------------------------------------
        ins<="1000100001";
        wait for clk_period;
        -----------------------------------------------------------
        ------------------  case Branch---------------------------
        -----------------------------------------------------------
        assert (op = "0100") report "Error: p of random2 is wrong";
        if (op /= "0100") then
            err_cnt:=err_cnt+1;
        end if;

        err_cnt_signal <= err_cnt;
        -- summary of all the tests
        if (err_cnt=0) then
             assert false
             report "Testbench completed successfully!"
             severity note;
        else
             assert false
             report "Something wrong, try again"
             severity error;
        end if;
    end process;
end Actrl_tb_arc;
