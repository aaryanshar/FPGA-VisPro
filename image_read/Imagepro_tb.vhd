LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Imagepro_tb IS
END Imagepro_tb;

ARCHITECTURE behavior OF Imagepro_tb IS 
    COMPONENT Imagepro
    PORT (
        clock     : IN  std_logic;
        data      : IN  std_logic_vector(7 DOWNTO 0);
        rdaddress : IN  std_logic_vector(3 DOWNTO 0);
        wraddress : IN  std_logic_vector(3 DOWNTO 0);
        we        : IN  std_logic;
        re        : IN  std_logic;
        q         : OUT std_logic_vector(7 DOWNTO 0)
    );
    END COMPONENT;

    -- Inputs
    signal tb_clock     : std_logic := '0';
    signal tb_data      : std_logic_vector(7 DOWNTO 0) := (others => '0');
    signal tb_rdaddress : std_logic_vector(3 DOWNTO 0) := (others => '0');
    signal tb_wraddress : std_logic_vector(3 DOWNTO 0) := (others => '0');
    signal tb_we        : std_logic := '0';
    signal tb_re        : std_logic := '0';

    -- Outputs
    signal tb_q : std_logic_vector(7 DOWNTO 0);

    -- Clock period definitions
    constant clock_period : time := 10 ns;
    signal i : integer;
BEGIN
    -- Instantiate the Imagepro module (uut: Unit Under Test)
    uut: Imagepro PORT MAP (
        clock     => tb_clock,
        data      => tb_data,
        rdaddress => tb_rdaddress,
        wraddress => tb_wraddress,
        we        => tb_we,
        re        => tb_re,
        q         => tb_q
    );

    -- Clock process definitions
    clock_process : process
    begin
        tb_clock <= '0';
        wait for clock_period/2;
        tb_clock <= '1';
        wait for clock_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin  
        tb_data      <= x"00";
        tb_rdaddress <= x"0";
        tb_wraddress <= x"0";
        tb_we        <= '0';
        tb_re        <= '0';
        wait for 100 ns;
        tb_re        <= '1';  
        for i in 0 to 15 loop
            tb_rdaddress <= std_logic_vector(to_unsigned(i, 4));
            wait for 20 ns;
        end loop;
        wait;
    end process;
END behavior;
