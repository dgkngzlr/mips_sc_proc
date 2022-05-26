----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:39:16 05/19/2022 
-- Design Name: 
-- Module Name:    datapath - Behavioral 
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

entity datapath is
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
end datapath;

architecture Behavioral of datapath is

component pc_reg is
port(
	i_clk : in std_logic;
	i_rst : in std_logic;
	i_addr : in std_logic_vector(31 downto 0);
	o_addr : out std_logic_vector(31 downto 0)
);
end component;

component pc_four_adder is
	port(
		i_pc : in std_logic_vector(31 downto 0);
		o_pc : out std_logic_vector(31 downto 0)
	);
end component;

component pc_src_mux is
	port(
		i_sel : in std_logic;
		i_data_0 : in std_logic_vector(31 downto 0);
		i_data_1 : in std_logic_vector(31 downto 0);
		o_data_0 : out std_logic_vector(31 downto 0)
	);
end component;

component pc_branch_adder is
	port(
		i_offset : in std_logic_vector(31 downto 0); 
		i_base : in std_logic_vector(31 downto 0); 
		o_sum : out std_logic_vector(31 downto 0)
	);
end component;

component instruct_mem is
port(
	i_addr : in std_logic_vector(5 downto 0);
	o_data : out std_logic_vector(31 downto 0)
);
end component;

component decoder is
	port(
		i_intruct : in std_logic_vector(31 downto 0);
		o_opcode : out std_logic_vector(5 downto 0);
		o_rs : out std_logic_vector(4 downto 0);
		o_rt : out std_logic_vector(4 downto 0);
		o_rd : out std_logic_vector(4 downto 0);
		o_shamt : out std_logic_vector(4 downto 0);
		o_funct : out std_logic_vector(5 downto 0)
	);
end component;

component reg_file is
	port(i_clk : in std_logic;
		 i_wen : in std_logic;
		 i_raddr_0 : in std_logic_vector(4 downto 0);
		 i_raddr_1 : in std_logic_vector(4 downto 0);
		 i_waddr_0 : in std_logic_vector(4 downto 0);
		 i_wdata_0 : in std_logic_vector(31 downto 0);
		 o_rdata_0 : out std_logic_vector(31 downto 0);
		 o_rdata_1 : out std_logic_vector(31 downto 0)
		 );
end component;

component rf_dst_mux is
	port(
		i_sel : in std_logic;
		i_target : in std_logic_vector(4 downto 0);
		i_dest : in std_logic_vector(4 downto 0);
		o_dest : out std_logic_vector(4 downto 0)
	);
end component;

component extender is
  port (
	i_data : in std_logic_vector(15 downto 0);
	o_extended : out std_logic_vector(31 downto 0)
  );
end component;

component alu_src_mux is
	port(
		i_sel : in std_logic;
		i_reg : in std_logic_vector(31 downto 0);
		i_imm : in std_logic_vector(31 downto 0);
		o_data : out std_logic_vector(31 downto 0)
	);
end component;

component branch_shifter is
	port(
		i_data : in std_logic_vector(31 downto 0);
		o_shifted : out std_logic_vector(31 downto 0)
	);
end component;

component alu is
	port(
		i_op_a : in std_logic_vector(31 downto 0);
		i_op_b : in std_logic_vector(31 downto 0);
		i_aluctrl : in std_logic_vector(2 downto 0);
		o_zero : out std_logic;
		o_res : out std_logic_vector(31 downto 0)
	);
end component;

component data_mem is
	port(
		i_clk : in std_logic;
		i_wen : in std_logic;
		i_addr : in std_logic_vector(31 downto 0);
		i_wdata : in std_logic_vector(31 downto 0);
		o_rdata : out std_logic_vector(31 downto 0)
	);
end component;

component rf_write_mux is
	port(
		i_sel : in std_logic;
		i_data_0 : in std_logic_vector(31 downto 0);
		i_data_1 : in std_logic_vector(31 downto 0);
		o_data_0 : out std_logic_vector(31 downto 0)
	);
end component;


-- Wires
signal pc_plus_4 : std_logic_vector(31 downto 0);
signal pc_reg_val : std_logic_vector(31 downto 0);
signal pc_branch_val : std_logic_vector(31 downto 0);
signal pc_mux_out : std_logic_vector(31 downto 0);
signal pc_offset : std_logic_vector(31 downto 0);
signal pc_sel : std_logic;

signal inst_data : std_logic_vector(31 downto 0);
signal inst_opcode : std_logic_vector(5 downto 0);
signal inst_rs : std_logic_vector(4 downto 0);
signal inst_rt : std_logic_vector(4 downto 0);
signal inst_rd : std_logic_vector(4 downto 0);
signal inst_shamt : std_logic_vector(4 downto 0);
signal inst_funct : std_logic_vector(5 downto 0);

signal rf_waddr : std_logic_vector(4 downto 0);
signal rf_wdata : std_logic_vector(31 downto 0);
signal rf_out_0 : std_logic_vector(31 downto 0);
signal rf_out_1 : std_logic_vector(31 downto 0);

signal immediate_field : std_logic_vector(15 downto 0);
signal immediate_extended : std_logic_vector(31 downto 0);

signal alu_op_0 : std_logic_vector(31 downto 0);
signal alu_op_1 : std_logic_vector(31 downto 0);
signal alu_res : std_logic_vector(31 downto 0);
signal alu_zero_flag : std_logic;

signal ram_data :std_logic_vector(31 downto 0);

begin

PC_REG_0 : pc_reg port map(i_clk => i_clk,
						   i_rst => i_rst,
						   i_addr => pc_mux_out,
						   o_addr => pc_reg_val);

PC_ADDER_0 : pc_four_adder port map(i_pc => pc_reg_val,
									o_pc => pc_plus_4);

PC_ADDER_1 : pc_branch_adder port map(i_offset => pc_offset,
									  i_base => pc_plus_4,
									  o_sum => pc_branch_val);		

PC_SRC_MUX_0 : pc_src_mux port map(i_sel => pc_sel,
								   i_data_0 => pc_plus_4,
								   i_data_1 => pc_branch_val,
								   o_data_0 => pc_mux_out);	

ROM_0 : instruct_mem port map(i_addr => pc_reg_val(5 downto 0),
							  o_data => inst_data);	

DECODER_0 : decoder port map(i_intruct => inst_data,
							 o_opcode => inst_opcode,
							 o_rs => inst_rs,
							 o_rt => inst_rt,
							 o_rd => inst_rd,
							 o_shamt => inst_shamt,
							 o_funct => inst_funct);

REGISTER_FILE : reg_file port map(i_clk => i_clk,
								  i_wen => i_regwrite, --!
								  i_raddr_0 => inst_rs,
								  i_raddr_1 => inst_rt,
								  i_waddr_0 => rf_waddr,
								  i_wdata_0 => rf_wdata,
								  o_rdata_0 => rf_out_0,
								  o_rdata_1 => rf_out_1);

RF_DST_MUX_0 : rf_dst_mux port map(i_sel => i_regdst, --!
								   i_target => inst_rt,
								   i_dest => inst_rd,
								   o_dest => rf_waddr);

EXTENDER_0 : extender port map(i_data => immediate_field, 
							   o_extended => immediate_extended);

ALU_SRC_MUX_0 : alu_src_mux port map(i_sel => i_alusrc, -- !
									 i_reg => rf_out_1,
									 i_imm => immediate_extended,
									 o_data => alu_op_1);

BRANCH_SHIFTER_0 : branch_shifter port map(i_data => immediate_extended,
										   o_shifted => pc_offset);

ALU_0 : alu port map(i_op_a => alu_op_0,
					 i_op_b => alu_op_1,
					 i_aluctrl => i_aluctrl_d, -- !
					 o_zero => alu_zero_flag,
					 o_res => alu_res);

RAM_0 : data_mem port map(i_clk => i_clk,
						  i_wen => i_memwrite, --!
						  i_addr => alu_res,
						  i_wdata => rf_out_1,
						  o_rdata => ram_data);

RF_WRITE_MUX_0 : rf_write_mux port map(i_sel => i_memtoreg, --!
									   i_data_0 => alu_res,
									   i_data_1 => ram_data,
									   o_data_0 => rf_wdata);
						  

-- Concurrent statements
immediate_field <= inst_rd & inst_shamt & inst_funct;		   
alu_op_0 <= rf_out_0;
pc_sel <= i_branch; --!
o_opcode_d <= inst_opcode;
o_funct_d <= inst_funct;

end Behavioral;

