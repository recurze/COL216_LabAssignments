library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Bctrl_tb is
end Bctrl_tb;

architecture Bctrl_tb_arc of Bctrl_tb is
    signal clk : std_logic := '0';

    signal cond: std_logic_vector(3 downto 0);
    signal NCZV: std_logic_vector(3 downto 0);
    signal p : std_logic;

    signal err_cnt_signal : integer := 1;
    constant clk_period : time := 10 ns;
begin
    uut:
    entity WORK.Bctrl port map(
        cond=>cond,
        NCZV=>NCZV,
        p=>p
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
        -------------------- pre-case eq --------------------------
        -----------------------------------------------------------
        cond<="0000";
        -----------------------------------------------------------
        ------------------  case eq1-------------------------------
        -----------------------------------------------------------
        NCZV<="0000";
        wait for clk_period/2;
        assert (p = '0') report "Error: p of eq1 is wrong";
        if (p /= '0') then
            err_cnt:=err_cnt+1;
        end if;
        wait for clk_period/2;
        -----------------------------------------------------------
        ------------------  case eq2-------------------------------
        -----------------------------------------------------------
        NCZV<="0010";
        wait for clk_period/2;
        assert (p = '1') report "Error: p of eq2 is wrong";
        if (p /= '1') then
            err_cnt:=err_cnt+1;
        end if;
        wait for clk_period/2;
        ----------------------------------------------------------
        ------------------ pre-case neq ---------------------------
        ----------------------------------------------------------
        cond<="0001";
        -----------------------------------------------------------
        ------------------  case neq1------------------------------
        -----------------------------------------------------------
        NCZV<="0000";
        wait for clk_period/2;
        assert (p = '1') report "Error: p of neq1 is wrong";
        if (p /= '1') then
            err_cnt:=err_cnt+1;
        end if;
        wait for clk_period/2;
        -----------------------------------------------------------
        ------------------  case neq2------------------------------
        -----------------------------------------------------------
        NCZV<="0010";
        wait for clk_period/2;
        assert (p = '0') report "Error: p of neq2 is wrong";
        if (p /= '0') then
            err_cnt:=err_cnt+1;
        end if;
        wait for clk_period/2;
        -----------------------------------------------------------
        --------------------pre case random1 ---------------------
        -----------------------------------------------------------
        cond<="1101";
        -----------------------------------------------------------
        ------------------  case random1---------------------------
        -----------------------------------------------------------
        NCZV<="0010";
        wait for clk_period/2;
        assert (p = '1') report "Error: p of random1 is wrong";
        if (p /= '1') then
            err_cnt:=err_cnt+1;
        end if;
        wait for clk_period/2;
        -----------------------------------------------------------
        --------------------pre case random2 ---------------------
        -----------------------------------------------------------
        cond<="0010";
        -----------------------------------------------------------
        ------------------  case random2---------------------------
        -----------------------------------------------------------
        NCZV<="0110";
        wait for clk_period/2;
        assert (p = '1') report "Error: p of random2 is wrong";
        if (p /= '1') then
            err_cnt:=err_cnt+1;
        end if;
        wait for clk_period/2;
        ----------------------------------------------------------
        --------------------pre case random3 ---------------------
        -----------------------------------------------------------
        cond<="0110";
        -----------------------------------------------------------
        ------------------  case random3---------------------------
        -----------------------------------------------------------
        NCZV<="0010";
        wait for clk_period/2;
        assert (p = '0') report "Error: p of random3 is wrong";
        if (p /= '0') then
            err_cnt:=err_cnt+1;
        end if;
        wait for clk_period/2;
        -----------------------------------------------------------
        --------------------pre case random4 ---------------------
        -----------------------------------------------------------
        cond<="1000";
        -----------------------------------------------------------
        ------------------  case random4---------------------------
        -----------------------------------------------------------
        NCZV<="0010";
        wait for clk_period/2;
        assert (p = '0') report "Error: p of random4 is wrong";
        if (p /= '0') then
            err_cnt:=err_cnt+1;
        end if;
        wait for clk_period/2;
        -----------------------------------------------------------
        --------------------pre case random5 ---------------------
        -----------------------------------------------------------
        cond<="0011";
        -----------------------------------------------------------
        ------------------  case random5---------------------------
        -----------------------------------------------------------
        NCZV<="0010";
        wait for clk_period/2;
        assert (p = '1') report "Error: p of random5 is wrong";
        if (p /= '1') then
            err_cnt:=err_cnt+1;
        end if;
        wait for clk_period/2;

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
end Bctrl_tb_arc;
