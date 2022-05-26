----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:48:25 05/20/2022 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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

entity alu is
	port(
		i_op_a : in std_logic_vector(31 downto 0);
		i_op_b : in std_logic_vector(31 downto 0);
		i_aluctrl : in std_logic_vector(2 downto 0);
		o_zero : out std_logic;
		o_res : out std_logic_vector(31 downto 0)
	);
end alu;

architecture Behavioral of alu is
	signal internal_res : std_logic_vector(31 downto 0) := (others => '0');
begin

process(i_op_a, i_op_b, i_aluctrl)
begin
	
	case i_aluctrl is
		
		when "000" =>
			internal_res <= i_op_a and i_op_b;
		when "001" =>
			internal_res <= i_op_a or i_op_b;
		when "010" =>
			internal_res <= std_logic_vector( signed(i_op_a) + signed(i_op_b) );
		when "100" =>
			internal_res <= ( i_op_a and (not i_op_b) );
		when "101" =>
			internal_res <= ( i_op_a or (not i_op_b) );
		when "110" =>
			internal_res <= std_logic_vector( signed(i_op_a) - signed(i_op_b) );
		when "111" =>
			if signed(i_op_a) < signed(i_op_b) then
				internal_res <= x"00000001";
			else
				internal_res <= x"00000000";
			end if;
		when others =>
			internal_res <= internal_res;
	end case;
end process;

-- Zero flag setter
o_zero <= '1' when internal_res = x"00000000" else
		  '0';
-- Result setter
o_res <= internal_res;
end Behavioral;

