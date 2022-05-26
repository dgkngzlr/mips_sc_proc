----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:06:21 05/19/2022 
-- Design Name: 
-- Module Name:    pc_src_mux - Behavioral 
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

entity rf_write_mux is
	port(
		i_sel : in std_logic;
		i_data_0 : in std_logic_vector(31 downto 0);
		i_data_1 : in std_logic_vector(31 downto 0);
		o_data_0 : out std_logic_vector(31 downto 0)
	);
end rf_write_mux;

architecture Behavioral of rf_write_mux is

begin
	
	with i_sel select o_data_0 <=
		i_data_0 when '0',
		i_data_1 when others; 

end Behavioral;

