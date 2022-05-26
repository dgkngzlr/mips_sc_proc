----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:07:37 04/29/2022 
-- Design Name: 
-- Module Name:    data_mem - Behavioral 
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

entity data_mem is
	port(
		i_clk : in std_logic;
		i_wen : in std_logic;
		i_addr : in std_logic_vector(31 downto 0);
		i_wdata : in std_logic_vector(31 downto 0);
		o_rdata : out std_logic_vector(31 downto 0)
	);
end data_mem;

architecture Behavioral of data_mem is

	-- 256 Byte (64 Word) 256x8 big endian memory implementation for data memory
	type array_t is array (2**8-1 downto 0) of std_logic_vector(7 downto 0);
	signal mem : array_t := ( others =>x"00" );
	
	signal addr_resized : std_logic_vector(8 downto 0) := (others => '0');
begin

process(i_clk)
begin
	if rising_edge(i_clk) then
		if i_wen = '1' then
			mem(to_integer(unsigned(addr_resized))) <= i_wdata(31 downto 24);
			mem(to_integer(unsigned(addr_resized))+1) <= i_wdata(23 downto 16);
			mem(to_integer(unsigned(addr_resized))+2) <= i_wdata(15 downto 8);
			mem(to_integer(unsigned(addr_resized))+3) <= i_wdata(7 downto 0);
		end if;
	end if;
end process;

addr_resized <= '0' & i_addr(7 downto 0); 	
o_rdata <= mem(to_integer(unsigned(addr_resized))) &
		   mem(to_integer(unsigned(addr_resized))+1) &
		   mem(to_integer(unsigned(addr_resized))+2) &
		   mem(to_integer(unsigned(addr_resized))+3);

end Behavioral;