entity master_states is
    port(
        clk: in std_logic;
        rst: in std_logic
    );
end entity;

architecture master_states_arc of master_states is
    signal cs, ns: std_logic_vector(downto);
begin
    process(clk) begin
        if rising_edge(clk) then
            cs <= ns;
        end if;
    end process;

    process(rst) begin
        case cs is
            when "0000" =>
            when others => null;
        end case;

        if rst='1' then
            ns <= "000";
        end if;
    end process;
end architecture;
