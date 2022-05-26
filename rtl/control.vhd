----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:08:53 05/21/2022 
-- Design Name: 
-- Module Name:    control - Behavioral 
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

entity control is
	port (
		i_opcode_m : in std_logic_vector(5 downto 0);
		i_funct_m : in std_logic_vector(5 downto 0);
		o_memwrite_m : out std_logic;
		o_memtoreg_m : out std_logic;
		o_branch_m : out std_logic;
		o_alusrc_m : out std_logic;
		o_regdst_m : out std_logic;
		o_regwrite_m : out std_logic;
		o_aluctrl_m : out std_logic_vector(2 downto 0)
	);
end control;

architecture Behavioral of control is

component main_control is
	port(
		i_opcode : in std_logic_vector(5 downto 0);
		o_memwrite : out std_logic;
		o_memtoreg : out std_logic;
		o_branch : out std_logic;
		o_alusrc : out std_logic;
		o_regdst : out std_logic;
		o_regwrite : out std_logic;
		o_aluop : out std_logic_vector(1 downto 0)
	);
end component;

component alu_control is
	port(
		i_funct : in std_logic_vector(5 downto 0);
		i_aluop : in std_logic_vector(1 downto 0);
		o_aluctrl : out std_logic_vector(2 downto 0)
	);
end component;

signal alu_operation : std_logic_vector(1 downto 0);

begin

MAIN_CTRL : main_control port map(i_opcode => i_opcode_m,
								  o_memwrite => o_memwrite_m,
								  o_memtoreg => o_memtoreg_m,
								  o_branch => o_branch_m,
								  o_alusrc => o_alusrc_m,
								  o_regdst => o_regdst_m,
								  o_regwrite => o_regwrite_m,
								  o_aluop => alu_operation);

ALU_CTRL : alu_control port map(i_funct => i_funct_m,
								i_aluop => alu_operation,
								o_aluctrl => o_aluctrl_m);

end Behavioral;

