library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use WORK.mytypes.all;

entity Main_Controller is
    port (
        p: in std_logic;
        -- 25, 7-4
        ins: in std_logic_vector(4 downto 0);
        current_state: in state;

        PW: out std_logic;
        IW: out std_logic;
        DW: out std_logic;
        AW: out std_logic;
        BW: out std_logic;
        resW: out std_logic;
        RW: out std_logic;
        MR: out std_logic;
        MW: out std_logic;
        IorD: out std_logic;
        Asrc1: out std_logic;
        Asrc2: out std_logic_vector(1 downto 0);
        Rsrc: out std_logic_vector(1 downto 0);
        M2R: out std_logic;

        I: out std_logic; -- Immediate
        M: out std_logic -- Multiplication
    );
end entity;

architecture Main_Controller_arc of Main_Controller is
    signal cs: state;
begin
    cs<=current_state;
    process(cs, p)
    begin
        case cs is
            when fetch =>
                PW<='1';
                IW<='1';
                MR<='1';
                IorD<='0';
                Asrc1<='0';
                Asrc2<="01";
            when rdAB=>
                AW<='1';
                BW<='1';
                Rsrc<="00";
                -- new additions.
                if ins(3 downto 0)="1001" then
                    M<='1';
                else
                    M<='0';
                end if;
            when arith=>
                resW<='1';
                Asrc1<='1';
                Asrc2<="00";
                -- new additions.
                if ins(3 downto 0)="1001" then
                    M<='1';
                else
                    M<='0';
                end if;
                I<=ins(4);
            when wrRF=>
                RW<=p;
                M2R<='0';
            when addr=>
                resW<='1';
                Asrc1<='1';
                Asrc2<="10";
                Rsrc<="10";
                -- new additions.
                I<=ins(4);
            when wrM=>
                MW<=p;
                IorD<='1';
            when rdM=>
                DW<='1';
                MR<='1';
                IorD<='1';
            when M2RF=>
                RW<=p;
                M2R<='1';
            when brn=>
                PW<=p;
                Asrc1<='0';
                Asrc2<="11";
            when others =>
                null;
        end case;
    end process;
end Main_Controller_arc;
