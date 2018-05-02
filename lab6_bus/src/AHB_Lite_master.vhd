library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AHB_Lite_master is
    port (
        HREADY:in std_logic;

        HRESETn:in std_logic;
        HCLK:in std_logic;

        --32 bit data
        HRDATA:in std_logic_vector(31 downto 0);

        --12 bit addr
        HADDR:out std_logic_vector(11 downto 0);
        HWRITE:out std_logic;

        --byte(000); hw(001); word(010)
        HSIZE:out std_logic_vector(2 downto 0);

        --IDLE(00); NONSEQ(10)
        HTRANS:out std_logic_vector(1 downto 0);

        HWDATA:out std_logic_vector(31 downto 0)

        --omitted ports
        --HRESP:in std_logic;
        --HMASTERLOCK:out std_logic;

        --"000" no burst
        --HBURST:out std_logic_vector(2 downto 0);
        --HPROT:out std_logic_vector(3 downto 0);
    );
end AHB_Lite_master;

architecture AHB_Lite_master_arc of AHB_Lite_master is
begin
end architecture;
