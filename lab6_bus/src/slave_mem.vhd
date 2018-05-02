entity slave_mem is
    port (
        HTRANS: in std_logic_vector(1 downto 0)
        MemSel: in std_logic;
        HWRITE: in std_logic;

        W: out std_logic;
        HREADY: out std_logic;

        HADDR: in std_logic_vector(11 downto 0)
        addr: in std_logic_vector(11 downto 0)

        HRDATA: out std_logic_vector(31 downto 0)
        mem_out: in std_logic_vector(31 downto 0)

        we: out std_logic;
    );
end entity;

architecture slave_mem_arc of slave_mem is
    signal cs, ns: std_logic_vector(3 downto 0):= "0000";
    signal addr_sig: std_logic_vector(11 downto 0);
    signal w_sig, we_sig, hready_sig: std_logic;
begin
    -- change state
    process(clk) begin
        if rising_edge(clk) then
            cs <= ns;
        end if;
    end process;

    -- next state logic
    process(rst, cs) begin
        case cs is
            when "0000" =>
                ns <= "0001";
            when "0001" =>
                if HTRANS = "00" then
                    ns <= "0000";
                else
                    ns <= "0010";
                end if;
            when "0010" =>
                if MemSel = '1' then
                    ns <= "0011";
                else
                    ns <= "0000";
                end if;
            when "0011" =>
                ns <= "0100";
            when "0100" =>
                ns <= "0101";
            when "0101" =>
                ns <= "0110";
            when "0110" =>
                ns <= "0111";
            when "0111" =>
                if w_sig = '1' then
                    ns <= "1000";
                else
                    ns <= "1001";
                end if;
            when "1000" | "1001" =>
                ns <="0000";
            when others =>
                null;
        end case;

        if rst = '1' then
            ns <="000";
        end if;
    end process;

    -- state signals
    process(cs) begin
        if cs = "0011" then
            addr_sig <= HADDR;
            w_sig <= HWRITE;
            hready_sig <= '0';
        elsif cs = "0100" or cs = "0101" then
            hready_sig <= '0';
        elsif cs = "0110" then
            hready_sig <= '1';
        elsif cs = "1000" then
            hrdata_sig <= mem_out;
        elsif cs = "1001" then
            we_sig <= '1';
        end if;
    end process;

    --assign the real ports
    HREADY <= hready_sig;
    addr <= addr_sig;
    W <= w_sig;
    WE <= we_sig;

end architecture;
