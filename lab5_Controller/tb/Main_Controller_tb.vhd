library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use WORK.mytypes.all;

entity Main_Controller_tb is
end Main_Controller_tb;

architecture Main_Controller_tb_arc of Main_Controller_tb is
    signal clk : std_logic := '0';
    signal rst: std_logic :='0';
    signal err_cnt_signal : integer := 1;
    constant clk_period : time := 10 ns;

    signal p: std_logic;
    signal ins: std_logic_vector(4 downto 0); --20,27,26,7,6,5,4
    signal current_state: state;

    signal PW: std_logic;
    signal IW: std_logic;
    signal DW: std_logic;
    signal AW: std_logic;
    signal BW: std_logic;
    signal resW: std_logic;
    signal RW: std_logic;
    signal MR: std_logic;
    signal MW: std_logic;
    signal IorD: std_logic;
    signal Asrc1: std_logic;
    signal Asrc2: std_logic_vector(1 downto 0);
    signal Rsrc: std_logic_vector(1 downto 0);
    signal M2R: std_logic;

    signal I: std_logic;
    signal M: std_logic;
    --signal not_implemented: std_logic;
    --signal undefined: std_logic;
begin
    uut:
    entity WORK.Main_Main_Controller port map (
            p=>p,
            ins => ins,
            current_state=>current_state,

            PW=>PW,
            IW=>IW,
            DW=>DW,
            AW=>AW,
            BW=>BW,
            resW=>resW,
            RW=>RW,
            MR=>MR,
            MW=>MW,
            IorD=>IorD,
            Asrc1=>Asrc1,
            Asrc2=>Asrc2,
            Rsrc=>Rsrc,
            M2R=>M2R,

            I=>I,
            M=>M,
    );

    clk_process: process begin
        clk<='1';
        wait for clk_period/2;
        clk<='0';
        wait for clk_period/2;
    end process;

    stim_process: process 
        variable err_cnt : INTEGER := 0;
    begin

        ----------------------------------------------------------
        ------------------- pre-case fetch ------------------------
        ----------------------------------------------------------
        current_state<=fetch;
        -----------------------------------------------------------
        ---------------------  case fetch--------------------------
        -----------------------------------------------------------
        assert ((PW = '1') and (IW='1') and (MR='1') and (IorD='0') and (Asrc1='0') and (Asrc2="01")) report "Error: control signal for fetch is wrong";
        wait for clk_period;

        ----------------------------------------------------------
        ------------------- pre-case rdAB ------------------------
        ----------------------------------------------------------
        current_state<=rdAb;
        -----------------------------------------------------------
        ---------------------  case rdAB--------------------------
        -----------------------------------------------------------
        assert (BW = '1' and AW = '1' and Rsrc="00" and ((ins(3 downto 0)="1001" and M='1') or (ins(3 downto 0)="1001" and M='0')) report "Error: control signal of rdAB is wrong";
        wait for clk_period;

        ----------------------------------------------------------
        ------------------- pre-case arith------------------------
        ----------------------------------------------------------
        current_state<=arith;
        -----------------------------------------------------------
        ---------------------  case arith--------------------------
        -----------------------------------------------------------
        assert (resw = '1' and Fset = p and Asrc1 = '1' and Asrc2 = "00" and ((ins(3 downto 0)="1001" and M='1') or (ins(3 downto 0)="1001" and M='0'))) report "Error: control signal of arith is wrong";
        wait for clk_period;

        ----------------------------------------------------------
        ------------------- pre-case wrRF ------------------------
        ----------------------------------------------------------
        current_state<=wrRF;
        -----------------------------------------------------------
        ---------------------  case wrRF--------------------------
        -----------------------------------------------------------
        assert (M2R = '0' and RW = p) report "Error: control signal of wrRF is wrong";
        wait for clk_period;

        ----------------------------------------------------------
        ------------------- pre-case addr ------------------------
        ----------------------------------------------------------
        current_state<=addr;
        -----------------------------------------------------------
        ---------------------  case addr--------------------------
        -----------------------------------------------------------
        assert (resW='1' and Asrc1='1' and Asrc2="10" and Rsrc="10" and I=ins(4)) "Error: control signal of addr is wrong";
        wait for clk_period;

        ----------------------------------------------------------
        ------------------- pre-case wrM ------------------------
        ----------------------------------------------------------
        current_state<=wrM;
        -----------------------------------------------------------
        ---------------------  case wrM--------------------------
        -----------------------------------------------------------
        assert (MW=p and IorD='1') "Error: control signal of wrM is wrong";
        wait for clk_period;

        ----------------------------------------------------------
        ------------------- pre-case rdM ------------------------
        ----------------------------------------------------------
        current_state<=rdM;
        -----------------------------------------------------------
        ---------------------  case rdM--------------------------
        -----------------------------------------------------------
        assert (DW='1' and MR='1' and IorD='1') "Error: control signal of rdM is wrong";
        wait for clk_period;

        ----------------------------------------------------------
        ------------------- pre-case M2RF ------------------------
        ----------------------------------------------------------
        current_state<=M2RF;
        -----------------------------------------------------------
        ---------------------  case M2RF--------------------------
        -----------------------------------------------------------
        assert (RW='1' M2R='1')) "Error: control signal of M2RF is wrong";
        wait for clk_period;

        ----------------------------------------------------------
        ------------------- pre-case brn ------------------------
        ----------------------------------------------------------
        current_state<=brn;
        -----------------------------------------------------------
        ---------------------  case brn--------------------------
        -----------------------------------------------------------
        assert (PW=p and Asr1='0' and Asrc2="11") "Error: control signal of brn is wrong";
        wait for clk_period;

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
