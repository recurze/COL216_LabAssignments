library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shifter_tb is
end shifter_tb;

architecture shifter_tb_arc of shifter_tb is
    signal clk : std_logic := '0';

    signal in1: std_logic_vector(31 downto 0);
    signal shift_type: std_logic_vector(1 downto 0);
    signal shift_amount: std_logic_vector(4 downto 0);
    signal shift_carry: std_logic;
    signal result: std_logic_vector(31  downto 0);

    signal err_cnt_signal : integer := 1;
    constant clk_period : time := 10 ns;
begin
    uut:
    entity WORK.shifter port map(
        input1=>in1,
        shift_type=>shift_type,
        shift_amount=>shift_amount,
        result=>result,
        shift_carry=>shift_carry
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
        --------------------- pre-case 0 shift ----------------------
        ------------------------------------------------------------
        in1<=std_logic_vector(to_unsigned(43,32));
        shift_type<="00";
        shift_amount<="00000";
        wait for clk_period;

        -------------------------------------------------------------
        ---------------------  case 0 shift -------------------------
        -------------------------------------------------------------

        assert (result = 43) report "Error: result of 0 shift is wrong";
        if (result /= 43) then
            err_cnt:=err_cnt+1;
        end if;


        ------------------------------------------------------------
        --------------------- pre-case lsl -------------------------
        ------------------------------------------------------------
        in1<=std_logic_vector(to_unsigned(43,32));
        shift_type<="00";
        shift_amount<="00111";
        wait for clk_period;

        -------------------------------------------------------------
        ---------------------  case lsl -----------------------------
        -------------------------------------------------------------

        assert (result = 5504) report "Error: result of lsl is wrong";
        if (result /= 5504) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case lsr -------------------------
        ------------------------------------------------------------        
        in1<=std_logic_vector(to_unsigned(21,32));
        shift_type<="01";
        shift_amount<="00011";
        wait for clk_period;

        -------------------------------------------------------------
        ---------------------  case lsr -----------------------------
        -------------------------------------------------------------

        assert (result = 2) report "Error: result of case lsr is wrong";
        if (result /= 2) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case asr ---------------------------
        ------------------------------------------------------------        
        in1<=std_logic_vector(to_unsigned(45,32));
        shift_type<="10";
        shift_amount<="00001";
        wait for clk_period;

        -------------------------------------------------------------
        ---------------------  case asl -------------------------------
        -------------------------------------------------------------

        assert (result = 22) report "Error: result of case asl is wrong";
        if (result /= 22) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case ror -------------------------
        ------------------------------------------------------------        
        in1<=std_logic_vector(to_unsigned(16,32));
        shift_type<="11";
        shift_amount<="11111";
        wait for clk_period;

        -------------------------------------------------------------
        ---------------------  case ror -----------------------------
        -------------------------------------------------------------

        assert (result = 32) report "Error: result of case ror is wrong";
        if (result /= 32) then
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
