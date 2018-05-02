library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    port (
        MUX_sel:in std_logic_vector(1 downto 0);

        --HRESP_1:in std_logic;
        --HRESP_2:in std_logic;
        --HRESP_3:in std_logic;

        HRDATA_1:in std_logic_vector(31 downto 0);
        HRDATA_2:in std_logic_vector(31 downto 0);
        HRDATA_3:in std_logic_vector(31 downto 0);

        HREADYOUT_1:in std_logic;
        HREADYOUT_2:in std_logic;
        HREADYOUT_3:in std_logic;

        HRDATA:out std_logic_vector(31 downto 0);
        HRESP:out std_logic;
        HREADY:out std_logic
    );
end entity MUX;

architecture MUX_arc of MUX is
begin
    process (MUX_sel) begin
        if MUX_sel = "00" then
            --HRESP <= HRESP_1;
            HRDATA <= HRDATA_1;
            HREADYOUT <= HREADYOUT_1;
        elsif MUX_sel = "01" then
            --HRESP <= HRESP_2;
            HRDATA <= HRDATA_2;
            HREADYOUT <= HREADYOUT_2;
        elsif MUX_sel = "10" then
            --HRESP <= HRESP_3;
            HRDATA <= HRDATA_3;
            HREADYOUT <= HREADYOUT_3;
        else
            HRDATA <= (others => '0');
            HREADYOUT <= '0';
        end if;
    end process;
end architecture;
