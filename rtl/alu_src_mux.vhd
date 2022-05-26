----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2022 00:05:03
-- Design Name: 
-- Module Name: alu_src_mux - Behavioral
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

entity alu_src_mux is
	port(
		i_sel : in std_logic;
		i_reg : in std_logic_vector(31 downto 0);
		i_imm : in std_logic_vector(31 downto 0);
		o_data : out std_logic_vector(31 downto 0)
	);
end alu_src_mux;

architecture Behavioral of alu_src_mux is

begin

	with i_sel select o_data <=
		i_reg when '0',
		i_imm when others;

end Behavioral;
