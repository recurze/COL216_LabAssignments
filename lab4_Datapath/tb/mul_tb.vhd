library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mul_tb is
end mul_tb;

architecture mul_tb_arc of mul_tb is
    signal clk : std_logic := '0';

    signal in1, in2: std_logic_vector(31 downto 0);
    signal result: std_logic_vector(31  downto 0);

    signal err_cnt_signal : integer := 1;
    constant clk_period : time := 10 ns;
begin
    uut:
    entity WORK.multiplier port map(
        input1=>in1,
        input2=>in2,
        result=>result
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

        ------------------------------------------------------------
        --------------------- pre-case 0 ---------------------------
        ------------------------------------------------------------
        in1<=std_logic_vector(to_unsigned(43,32));
        in2<=std_logic_vector(to_unsigned(26,32));
        wait for clk_period;

        -------------------------------------------------------------
        ---------------------  case 0 -------------------------------
        -------------------------------------------------------------

        assert (result = 1118) report "Error: result of case 0 is wrong";
        if (result /= 1118) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case 1 ---------------------------
        ------------------------------------------------------------        
        in1<=std_logic_vector(to_unsigned(21,32));
        in2<=std_logic_vector(to_unsigned(17,32));
        wait for clk_period;

        -------------------------------------------------------------
        ---------------------  case 1 -------------------------------
        -------------------------------------------------------------

        assert (result = 357) report "Error: result of case 1 is wrong";
        if (result /= 357) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case 2 ---------------------------
        ------------------------------------------------------------        
        in1<=std_logic_vector(to_unsigned(45,32));
        in2<=std_logic_vector(to_unsigned(16,32));
        wait for clk_period;

        -------------------------------------------------------------
        ---------------------  case 2 -------------------------------
        -------------------------------------------------------------

        assert (result = 720) report "Error: result of case 2 is wrong";
        if (result /= 720) then
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
end architecture;
