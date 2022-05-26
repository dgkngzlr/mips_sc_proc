----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:26:26 05/21/2022 
-- Design Name: 
-- Module Name:    main_control - Behavioral 
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

entity main_control is
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
end main_control;

architecture Behavioral of main_control is

begin

process(i_opcode)
begin
	o_memwrite <= '0';
	o_memtoreg <= '0';
	o_branch <= '0';
	o_alusrc <= '0';
	o_regdst <= '0';
	o_regwrite <= '0';
	o_aluop <= "00";
	
	case i_opcode is
		-- R - type
		when "000000" =>
			o_regwrite <= '1'; -- write register
			o_regdst <= '1';   -- take rd field
			o_alusrc <= '0';   -- no imm. field
			o_branch <= '0';   -- select pc + 4
			o_memwrite <= '0'; -- no mem. write
			o_memtoreg <= '0'; -- write back from alu result
			o_aluop <= "10";   
		
		-- lw instruction
		when "100011" =>
			o_regwrite <= '1'; -- write register
			o_regdst <= '0';   -- take rt field
			o_alusrc <= '1';   -- use imm. field
			o_branch <= '0';   -- select pc + 4
			o_memwrite <= '0'; -- no mem. write
			o_memtoreg <= '1'; -- write back from ram
			o_aluop <= "00";  
			
		-- sw instruction
		when "101011" =>
			o_regwrite <= '0'; -- read register
			o_alusrc <= '1';   -- use imm. field
			o_branch <= '0';   -- select pc + 4
			o_memwrite <= '1'; -- mem. write
			o_aluop <= "00";  
			
		-- beq instruction
		when "000100" =>
			o_regwrite <= '0'; -- read register
			o_alusrc <= '0';   -- no imm. field
			o_branch <= '1';   -- jump 
			o_memwrite <= '0'; -- no mem. write
			o_aluop <= "01";
		
		-- addi instruction
		when "001000" =>
			o_regwrite <= '1'; -- write register
			o_regdst <= '0';   -- take rt field
			o_alusrc <= '1';   -- use imm. field
			o_branch <= '0';   -- select pc + 4
			o_memwrite <= '0'; -- no mem. write
			o_memtoreg <= '0'; -- write back from alu result
			o_aluop <= "00";   
		
		-- bne instruction
		when "000101" =>
			o_regwrite <= '0'; -- read register
			o_alusrc <= '0';   -- no imm. field
			o_branch <= '1';   -- jump 
			o_memwrite <= '0'; -- no mem. write
			o_aluop <= "01";
		
		
		when others =>
	end case;
end process;

end Behavioral;

