----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:25:48 05/19/2022 
-- Design Name: 
-- Module Name:    pc_four_adder - Behavioral 
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

entity pc_four_adder is
	port(
		i_pc : in std_logic_vector(31 downto 0);
		o_pc : out std_logic_vector(31 downto 0)
	);
end pc_four_adder;

architecture Behavioral of pc_four_adder is
	signal addamt : unsigned(31 downto 0) := x"00000004";
begin

	o_pc <= std_logic_vector(unsigned(i_pc) + addamt);
	
end Behavioral;

