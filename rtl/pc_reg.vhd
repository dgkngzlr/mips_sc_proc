----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:17:57 04/21/2022 
-- Design Name: 
-- Module Name:    pc_reg - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pc_reg is
port(
	i_clk : in std_logic;
	i_rst : in std_logic;
	i_addr : in std_logic_vector(31 downto 0);
	o_addr : out std_logic_vector(31 downto 0)
);
end pc_reg;

architecture Behavioral of pc_reg is
	
begin

process(i_clk, i_rst)
begin
	-- Async. reset
	-- Reset state can be 0x00400000
	if i_rst = '1' then
		o_addr <= (others => '0');
		
	elsif rising_edge(i_clk) then
		o_addr <= i_addr;
		
	end if;
		
end process;

end Behavioral;
