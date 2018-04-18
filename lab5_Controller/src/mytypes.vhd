package mytypes is
    type state is (fetch, rdAB, arith, wrRF, addr, wrM, rdM, M2RF, brn, nope);
    type arr is array(0 to 1024) of std_logic_vector(31 downto 0)
end package;
package body mytypes is
end mytypes;
