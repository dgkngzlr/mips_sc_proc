----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2022 16:44:09
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
	port(
		i_clk : in std_logic;
		i_rst : in std_logic
	);
end top;

architecture Behavioral of top is

component control is
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
end component;

component datapath is
	port(
		i_clk : in std_logic;
		i_rst : in std_logic;
		i_memwrite : in std_logic;
		i_memtoreg : in std_logic;
		i_alusrc : in std_logic;
		i_regdst : in std_logic;
		i_regwrite : in std_logic;
		i_branch : in std_logic;
		i_aluctrl_d : in std_logic_vector(2 downto 0);
		o_opcode_d : out std_logic_vector(5 downto 0);
		o_funct_d : out std_logic_vector(5 downto 0)
	);
end component;

-- Wires
signal w_opcode : std_logic_vector(5 downto 0);
signal w_funct : std_logic_vector(5 downto 0);
signal w_memwrite : std_logic;
signal w_memtoreg : std_logic;
signal w_branch : std_logic;
signal w_alusrc : std_logic;
signal w_regdst : std_logic;
signal w_regwrite : std_logic;
signal w_aluctrl : std_logic_vector(2 downto 0);

begin

CONTROL_0 : control port map(i_opcode_m =>w_opcode,
							 i_funct_m =>w_funct,
							 o_memwrite_m =>w_memwrite,
							 o_memtoreg_m =>w_memtoreg,
							 o_branch_m =>w_branch,
							 o_alusrc_m =>w_alusrc,
							 o_regdst_m =>w_regdst,
							 o_regwrite_m =>w_regwrite,
							 o_aluctrl_m =>w_aluctrl);

DATAPATH_0 : datapath port map(i_clk => i_clk,
							   i_rst => i_rst,
							   i_memwrite =>w_memwrite,
							   i_memtoreg =>w_memtoreg,
							   i_alusrc =>w_alusrc,
							   i_regdst =>w_regdst,
							   i_regwrite =>w_regwrite,
							   i_branch =>w_branch,
							   i_aluctrl_d =>w_aluctrl,
							   o_opcode_d =>w_opcode,
							   o_funct_d =>w_funct);
end Behavioral;
