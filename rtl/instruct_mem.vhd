----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:45:10 04/18/2022 
-- Design Name: 
-- Module Name:    instruct_mem - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruct_mem is
port(
	i_addr : in std_logic_vector(5 downto 0);
	o_data : out std_logic_vector(31 downto 0)
);
end instruct_mem;

architecture Behavioral of instruct_mem is
	
	type ROM_ARRAY is array (0 to 63) of std_logic_vector(7 downto 0);
	constant ROM : ROM_ARRAY := 
	(
		x"AC",x"10",x"00",x"00", -- sw s0, 0($zero)
		x"AC",x"11",x"00",x"04", -- sw s1, 4($zero)
		x"8C",x"08",x"00",x"00", -- lw t0, 0($zero)
		x"8C",x"09",x"00",x"04", -- lw t1, 4($zero)
		x"01",x"09",x"50",x"20", -- add t2 t0 t1
		x"01",x"09",x"58",x"22", -- sub t3 t0 t1
		x"01",x"6A",x"60",x"2A", -- slt t4 t3 t2
		x"22",x"0D",x"00",x"AA", -- addi t5 s0 0x00AA
		x"12",x"11",x"FF",x"F7", -- beq s0 s1 0xFFF7
		x"16",x"11",x"FF",x"F7", -- bne s0 s1 0xFFF7
		x"00",x"00",x"00",x"00", 
		x"00",x"00",x"00",x"00", 
		x"00",x"00",x"00",x"00", 
		x"00",x"00",x"00",x"00", 
		x"00",x"00",x"00",x"00",  
		x"00",x"00",x"00",x"00" 
	);
	
begin

process(i_addr)
begin
	o_data <= ROM(to_integer(unsigned(i_addr))) & ROM(to_integer(unsigned(i_addr) + 1)) &
			  ROM(to_integer(unsigned(i_addr) + 2)) & ROM(to_integer(unsigned(i_addr) + 3));
end process;

end Behavioral;
