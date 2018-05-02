entity slave_switches is
    port (
        p: in std_logic;

        HWRITE: in std_logic;
        HTRANS: in std_logic_vector(1 downto 0)
        HRDATA: in std_logic_vector(31 downto 0)

        inp: in std_logic_vector(15 downto 0);
        HRDATA: out std_logic_vector(15 downto 0)
    );
end entity;

architecture slave_switches_arc of slave_switches is
    signal cs, ns: std_logic_vector(2 downto 0):= "000";
begin
    -- change states
    process(clk) begin
        if rising_edge(clk) then
            cs <= ns;
        end if;
    end process;

    -- next state logic
    process(rst) begin
        case cs is
            when "000" =>
                ns <= "001";
            when "001" =>
                if HTRANS = "00" then
                    ns <= "000";
                else
                    ns <= "010";
                end if;
            when "010" =>
                if p = '1' then
                    ns <= "011";
                else
                    ns <= "000";
                end if;
            when "011" =>
                if HWRITE = '1' then
                    ns <= "000";
                else
                    ns <= "100";
                end if;
            when "100" =>
                ns <= "000";
            when others =>
                null;
        end case;

        if rst = '1' then
            ns <="000";
        end if;
    end process;

    -- state signals
    process(cs) begin
        if cs = "100" then
            HRDATA <= inp;
        end if;
    end process;
end architecture;
