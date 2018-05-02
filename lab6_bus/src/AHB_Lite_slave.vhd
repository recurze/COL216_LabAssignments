library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AHB_Lite_slave is
    port (
        HSELx:in std_logic;

        --12 bit addr
        HADDR:in std_logic_vector(11 downto 0);
        HWRITE:std_logic;

        -- byte(000); hw(001); w(010)
        HSIZE:in std_logic_vector(2 downto 0);

        -- IDLE(00); NONSEQ(10)
        HTRANS:in std_logic_vector(1 downto 0);
        HREADY:in std_logic;
        HWDATA:in std_logic_vector(31 downto 0);

        --global
        HRESETn:in std_logic;
        HCLK:in std_logic;

        HREADYOUT:out std_logic;

        HRDATA:out std_logic_vector(31 downto 0)

        --HRESP:out std_logic;
        --HMASTERLOCK:in std_logic;

        --HBURST:in std_logic_vector(2 downto 0);
        --HPROT:in std_logic_vector(3 downto 0);
    );
end AHB_Lite_slave;
