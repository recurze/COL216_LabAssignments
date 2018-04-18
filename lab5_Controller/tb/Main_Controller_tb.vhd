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
    entity WORK.Main_Controller port map (
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
            M=>M
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
        wait for clk_period/2;
        assert ((PW = '1') and (IW='1') and (MR='1') and (IorD='0') and (Asrc1='0') and (Asrc2="01")) report "Error: control signal for fetch is wrong";
        wait for clk_period/2;

        ----------------------------------------------------------
        ------------------- pre-case rdAB ------------------------
        ----------------------------------------------------------
        current_state<=rdAb;
        ins(3 downto 0)<="1101";
        -----------------------------------------------------------
        ---------------------  case rdAB--------------------------
        -----------------------------------------------------------
        wait for clk_period/2;
        assert (BW = '1' and AW = '1' and Rsrc="00" and ((ins(3 downto 0)="1001" and M='1') or (ins(3 downto 0)/="1001" and M='0'))) report "Error: control signal of rdAB is wrong";
        wait for clk_period/2;

        ----------------------------------------------------------
        ------------------- pre-case arith------------------------
        ----------------------------------------------------------
        current_state<=arith;
        ins(3 downto 0)<="1001";
        ins(4)<='0';
        -----------------------------------------------------------
        ---------------------  case arith--------------------------
        -----------------------------------------------------------
        wait for clk_period/2;
        assert (I=ins(4) and resw = '1' and Asrc1 = '1' and Asrc2 = "00" and ((ins(3 downto 0)="1001" and M='1') or (ins(3 downto 0)/="1001" and M='0'))) report "Error: control signal of arith is wrong";
        wait for clk_period/2;

        ----------------------------------------------------------
        ------------------- pre-case wrRF ------------------------
        ----------------------------------------------------------
        current_state<=wrRF;
        p<='1';
        -----------------------------------------------------------
        ---------------------  case wrRF--------------------------
        -----------------------------------------------------------
        wait for clk_period/2;
        assert (M2R = '0' and RW = p) report "Error: control signal of wrRF is wrong";
        wait for clk_period/2;

        ----------------------------------------------------------
        ------------------- pre-case addr ------------------------
        ----------------------------------------------------------
        current_state<=addr;
        ins(4)<='1';
        -----------------------------------------------------------
        ---------------------  case addr--------------------------
        -----------------------------------------------------------
        wait for clk_period/2;
        assert (resW='1' and Asrc1='1' and Asrc2="10" and Rsrc="10" and I=ins(4)) report "Error: control signal of addr is wrong";
        wait for clk_period/2;

        ----------------------------------------------------------
        ------------------- pre-case wrM ------------------------
        ----------------------------------------------------------
        current_state<=wrM;
        p<='0';
        -----------------------------------------------------------
        ---------------------  case wrM--------------------------
        -----------------------------------------------------------
        wait for clk_period/2;
        assert (MW=p and IorD='1') report "Error: control signal of wrM is wrong";
        wait for clk_period/2;

        ----------------------------------------------------------
        ------------------- pre-case rdM ------------------------
        ----------------------------------------------------------
        current_state<=rdM;
        -----------------------------------------------------------
        ---------------------  case rdM--------------------------
        -----------------------------------------------------------
        wait for clk_period/2;
        assert (DW='1' and MR='1' and IorD='1') report "Error: control signal of rdM is wrong";
        wait for clk_period/2;

        ----------------------------------------------------------
        ------------------- pre-case M2RF ------------------------
        ----------------------------------------------------------
        current_state<=M2RF;
        p<='1';
        -----------------------------------------------------------
        ---------------------  case M2RF--------------------------
        -----------------------------------------------------------
        wait for clk_period/2;
        assert (RW=p and M2R='1') report "Error: control signal of M2RF is wrong";
        wait for clk_period/2;

        ----------------------------------------------------------
        ------------------- pre-case brn ------------------------
        ----------------------------------------------------------
        current_state<=brn;
        p<='1';
        -----------------------------------------------------------
        ---------------------  case brn--------------------------
        -----------------------------------------------------------
        wait for clk_period/2;
        assert (PW=p and Asrc1='0' and Asrc2="11") report "Error: control signal of brn is wrong";
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
    
end architecture;
