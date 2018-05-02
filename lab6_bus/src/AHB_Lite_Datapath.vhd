lbrary IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AHB_Lite_Datapath is
end entity AHB_Lite_Datapath;

architecture behavioural of AHB_Lite_Datapath is
    signal hwdata:std_logic_vector(31 downto 0);
    signal haddr:std_logic_vector(11 downto 0);

    signal hsel_1:std_logic;
    signal hsel_2:std_logic;
    signal hsel_3:std_logic;

    signal hrdata_1:std_logic_vector(31 downto 0);
    signal hrdata_2:std_logic_vector(31 downto 0);
    signal hrdata_3:std_logic_vector(31 downto 0);

    signal hrdata:std_logic_vector(31 downto 0);

    signal hresp:std_logic;
    signal hresp_1:std_logic;
    signal hresp_2:std_logic;
    signal hresp_3:std_logic;

    signal hreadyout_1:std_logic;
    signal hreadyout_2:std_logic;
    signal hreadyout_3:std_logic;

    signal hready:std_logic;
begin
    Master:
    entity WORK.AHB_Lite_master port map (
        HRSETn=>,
        HCLK=>,
        HRDATA=>hrdata,
        HREADY=>hready,
        --HRESP=>hresp,
        HADDR=>haddr,
        HWRITE=>,
        HSIZE=>,
        --HBURST=>,
        --HPORT=>,
        HTRANS=>,
        --HMASTERLOCK=>,
        HWDATA=>hwdata
    );
end architecture;
