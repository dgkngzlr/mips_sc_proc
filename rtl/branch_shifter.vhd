----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2022 00:19:27
-- Design Name: 
-- Module Name: branch_shifter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity branch_shifter is
	port(
		i_data : in std_logic_vector(31 downto 0);
		o_shifted : out std_logic_vector(31 downto 0)
	);
end branch_shifter;

architecture Behavioral of branch_shifter is

begin

	o_shifted <= i_data(29 downto 0) & "00";

end Behavioral;
