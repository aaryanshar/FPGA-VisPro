library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use std.textio.all;

-- Entity definition with modified generic names
entity Imagepro is
  generic (
    ADDR_WIDTH_PARAM : integer := 4;        
    DATA_WIDTH_PARAM : integer := 8;
    IMAGE_SIZE_PARAM : integer := 15;
    IMAGE_FILE_NAME_PARAM : string := "IMAGE_FILE.MIF"  -- image file name
  );
  port(
    clock    : IN STD_LOGIC;
    data     : IN std_logic_vector((DATA_WIDTH_PARAM-1) DOWNTO 0);
    rdaddress: IN STD_LOGIC_VECTOR((ADDR_WIDTH_PARAM-1) DOWNTO 0);
    wraddress: IN STD_LOGIC_VECTOR((ADDR_WIDTH_PARAM-1) DOWNTO 0);
    we       : IN STD_LOGIC;
    re       : IN STD_LOGIC;
    q        : OUT std_logic_vector((DATA_WIDTH_PARAM-1) DOWNTO 0)
  );
end Imagepro;

-- Architecture definition
architecture behavioral of Imagepro is
  TYPE memory_type IS ARRAY(0 TO IMAGE_SIZE_PARAM) OF std_logic_vector((DATA_WIDTH_PARAM-1) DOWNTO 0);

  impure function init_memory(mif_filename : in string) return memory_type is
    file mif_file   : text open read_mode is mif_filename;
    variable mif_line: line;
    variable temp_bv : bit_vector(DATA_WIDTH_PARAM-1 downto 0);
    variable temp_mem: memory_type;
  begin
    for i in memory_type'range loop
      readline(mif_file, mif_line);
      read(mif_line, temp_bv);
      temp_mem(i) := to_stdlogicvector(temp_bv);
    end loop;
    return temp_mem;
  end function;

  signal ram_memory      : memory_type := init_memory(IMAGE_FILE_NAME_PARAM);
  signal read_address_reg: std_logic_vector((ADDR_WIDTH_PARAM-1) downto 0) := (others => '0');
  
begin
  process (clock)
  begin
    if (rising_edge(clock)) then
      if (we = '1') then
        ram_memory(to_integer(unsigned(wraddress))) <= data;
      end if;
      if (re = '1') then
        q <= ram_memory(to_integer(unsigned(rdaddress)));
      end if;
    end if;
  end process;

end behavioral;
