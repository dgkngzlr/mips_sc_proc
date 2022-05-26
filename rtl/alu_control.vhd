----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:49:01 05/21/2022 
-- Design Name: 
-- Module Name:    alu_control - Behavioral 
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

entity alu_control is
	port(
		i_funct : in std_logic_vector(5 downto 0);
		i_aluop : in std_logic_vector(1 downto 0);
		o_aluctrl : out std_logic_vector(2 downto 0)
	);
end alu_control;

architecture Behavioral of alu_control is

begin

process(i_funct, i_aluop)
begin
	o_aluctrl <= "000";
	
	case i_aluop is
		
		when "00" =>
			o_aluctrl <= "010";
		when "01" =>
			o_aluctrl <= "110";
		when "10" =>
		
			-- ADD
			if i_funct = "100000" then
				o_aluctrl <= "010";
			-- SUB
			elsif i_funct = "100010" then
				o_aluctrl <= "110";
			-- AND
			elsif i_funct = "100100" then
				o_aluctrl <= "000";
			-- OR
			elsif i_funct = "100101" then
				o_aluctrl <= "001";
			-- SLT
			elsif i_funct = "101010" then
				o_aluctrl <= "111";
			else
				o_aluctrl <= "000";
			end if;
			
		when others =>
		
	end case;
end process;

end Behavioral;

