----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:30:11 05/19/2022 
-- Design Name: 
-- Module Name:    pc_branch_adder - Behavioral 
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

entity pc_branch_adder is
	port(
		i_offset : in std_logic_vector(31 downto 0); -- a
		i_base : in std_logic_vector(31 downto 0); -- b
		o_sum : out std_logic_vector(31 downto 0)
	);
end pc_branch_adder;

architecture Behavioral of pc_branch_adder is

begin

	o_sum <= std_logic_vector( unsigned(i_base)+unsigned(i_offset) );

end Behavioral;

