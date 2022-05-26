----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2022 23:52:07
-- Design Name: 
-- Module Name: extender - Behavioral
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

entity extender is
  port (
	i_data : in std_logic_vector(15 downto 0);
	o_extended : out std_logic_vector(31 downto 0)
  );
end extender;

architecture Behavioral of extender is
	signal sign : std_logic;
begin
	
	sign <= i_data(15);
	
	with sign select o_extended <=
		x"0000" & i_data when '0',
		x"FFFF" & i_data when others;

end Behavioral;
