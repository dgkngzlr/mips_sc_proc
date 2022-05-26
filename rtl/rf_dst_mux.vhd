----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:37:52 05/19/2022 
-- Design Name: 
-- Module Name:    rf_dst_mux - Behavioral 
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

entity rf_dst_mux is
	port(
		i_sel : in std_logic;
		i_target : in std_logic_vector(4 downto 0);
		i_dest : in std_logic_vector(4 downto 0);
		o_dest : out std_logic_vector(4 downto 0)
	);
end rf_dst_mux;

architecture Behavioral of rf_dst_mux is

begin

	with i_sel select o_dest <=
		i_target when '0',
		i_dest when others;

end Behavioral;

