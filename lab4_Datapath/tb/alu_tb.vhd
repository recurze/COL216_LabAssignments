library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu_tb is
end alu_tb;

architecture alu_tb_arc of alu_tb is
    signal clk : std_logic := '0';

    signal carry: std_logic;
    signal opcode: std_logic_vector(3 downto 0);
    signal in1, in2: std_logic_vector(31 downto 0);

    signal result: std_logic_vector(32 downto 0);

    signal err_cnt_signal : integer := 1;
    constant clk_period : time := 10 ns;
begin
    uut:
    entity WORK.ALu port map(
        carry=>carry,
        opcode=>opcode,
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
        -- checking for and, teq, sub, add, rsb, adc, orr, mov, bic, mvn

        ------------------------------------------------------------
        --------------------- pre-case and -------------------------
        ------------------------------------------------------------
        wait for clk_period;
        in1<=std_logic_vector(to_unsigned(42,32));
        in2<=std_logic_vector(to_unsigned(24,32));
        opcode<="0000";
        wait for clk_period;
        -------------------------------------------------------------
        ---------------------  case and -------------------------------
        -------------------------------------------------------------
        assert (result = 8) report "Error: result of and is wrong";
        if (result /= 8) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case xor ---------------------------
        ------------------------------------------------------------
        in1<=std_logic_vector(to_unsigned(43,32));
        in2<=std_logic_vector(to_unsigned(26,32));
        opcode<="1001";
        wait for clk_period;
        -------------------------------------------------------------
        ---------------------  case xor -------------------------------
        -------------------------------------------------------------
        assert (result = 49) report "Error: result of teq is wrong";
        if (result /= 49) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case sub ---------------------------
        ------------------------------------------------------------
        in1<=std_logic_vector(to_unsigned(31,32));
        in2<=std_logic_vector(to_unsigned(16,32));
        opcode<="0010";
        wait for clk_period;
        -------------------------------------------------------------
        ---------------------  case sub -------------------------------
        -------------------------------------------------------------
        assert (result = 15) report "Error: result of sub is wrong";
        if (result /= 15) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case add ---------------------------
        ------------------------------------------------------------
        in1<=std_logic_vector(to_unsigned(13,32));
        in2<=std_logic_vector(to_unsigned(50,32));
        opcode<="0100";
        wait for clk_period;
        -------------------------------------------------------------
        ---------------------  case add -------------------------------
        -------------------------------------------------------------
        assert (result = 63) report "Error: result of add is wrong";
        if (result /= 63) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case rsb ---------------------------
        ------------------------------------------------------------
        in1<=std_logic_vector(to_unsigned(20,32));
        in2<=std_logic_vector(to_unsigned(32,32));
        opcode<="0011";
        wait for clk_period;
        -------------------------------------------------------------
        ---------------------  case rsb -------------------------------
        -------------------------------------------------------------
        assert (result = 12) report "Error: result of rsb is wrong";
        if (result /= 12) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case adc ---------------------------
        ------------------------------------------------------------
        in1<=std_logic_vector(to_unsigned(22,32));
        in2<=std_logic_vector(to_unsigned(29,32));
        carry<='1';
        opcode<="0101";
        wait for clk_period;
        -------------------------------------------------------------
        ---------------------  case adc -------------------------------
        -------------------------------------------------------------
        assert (result = 52) report "Error: result of adc is wrong";
        if (result /= 52) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case or ---------------------------
        ------------------------------------------------------------
        in1<=std_logic_vector(to_unsigned(45,32));
        in2<=std_logic_vector(to_unsigned(41,32));
        opcode<="1100";
        wait for clk_period;
        -------------------------------------------------------------
        ---------------------  case or -------------------------------
        -------------------------------------------------------------
        assert (result = 45) report "Error: result of orr is wrong";
        if (result /= 45) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case mov ---------------------------
        ------------------------------------------------------------
        in1<=std_logic_vector(to_unsigned(456,32));
        in2<=std_logic_vector(to_unsigned(55,32));
        opcode<="1101";
        wait for clk_period;
        -------------------------------------------------------------
        ---------------------  case mov -------------------------------
        -------------------------------------------------------------
        assert (result = 55) report "Error: result of mov is wrong";
        if (result /= 55) then
            err_cnt:=err_cnt+1;
        end if;

        ------------------------------------------------------------
        --------------------- pre-case bic ---------------------------
        ------------------------------------------------------------
        in1<=std_logic_vector(to_unsigned(2,32));
        in2<=std_logic_vector(to_unsigned(9,32));
        opcode<="1110";
        wait for clk_period;
        -------------------------------------------------------------
        ---------------------  case bic -------------------------------
        -------------------------------------------------------------
        assert (result = 2) report "Error: result of bic is wrong";
        if (result /= 2) then
            err_cnt:=err_cnt+1;
        end if;

        --------------------------------------------------------------
        ----------------------- pre-case mvn ---------------------------
        --------------------------------------------------------------
        in1<=std_logic_vector(to_unsigned(18,32));
        in2<="01010100101100100101010101100101";

        opcode<="1111";
        wait for clk_period;
        ---------------------------------------------------------------
        -----------------------  case mvn -------------------------------
        ---------------------------------------------------------------
        assert (result = "110101011010011011010101010011010") report "Error: result of mvn is wrong";
        if (result /= "110101011010011011010101010011010") then
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
end alu_tb_arc;
