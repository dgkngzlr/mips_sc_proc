----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:59:30 05/19/2022 
-- Design Name: 
-- Module Name:    decoder - Behavioral 
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

entity decoder is
	port(
		i_intruct : in std_logic_vector(31 downto 0);
		o_opcode : out std_logic_vector(5 downto 0);
		o_rs : out std_logic_vector(4 downto 0);
		o_rt : out std_logic_vector(4 downto 0);
		o_rd : out std_logic_vector(4 downto 0);
		o_shamt : out std_logic_vector(4 downto 0);
		o_funct : out std_logic_vector(5 downto 0)
	);
end decoder;

architecture Behavioral of decoder is

begin
	
	o_opcode <= i_intruct(31 downto 26);
	o_rs <= i_intruct(25 downto 21);
	o_rt <= i_intruct(20 downto 16);
	o_rd <= i_intruct(15 downto 11);
	o_shamt <= i_intruct(10 downto 6);
	o_funct <= i_intruct(5 downto 0);

end Behavioral;

