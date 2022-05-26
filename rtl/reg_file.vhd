----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:24:38 04/18/2022 
-- Design Name: 
-- Module Name:    reg_file - Behavioral 
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
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_file is
	
	port(i_clk : in std_logic;
		 i_wen : in std_logic;
		 i_raddr_0 : in std_logic_vector(4 downto 0);
		 i_raddr_1 : in std_logic_vector(4 downto 0);
		 i_waddr_0 : in std_logic_vector(4 downto 0);
		 i_wdata_0 : in std_logic_vector(31 downto 0);
		 o_rdata_0 : out std_logic_vector(31 downto 0);
		 o_rdata_1 : out std_logic_vector(31 downto 0)
		 );
	
end reg_file;

architecture Behavioral of reg_file is
	-- 32x32 register file structure 
	type array_t is array (31 downto 0) of std_logic_vector(31 downto 0);
	signal register_file : array_t := ( 
		x"00000000", -- ra
		x"00000000", -- s8
		x"00000000", -- sp
		x"00000000", -- gp
		x"00000000", -- k1
		x"00000000", -- k0
		x"00000000", -- t9
		x"00000000", -- t8
		x"00000000", -- s7
		x"00000000", -- s6
		x"00000000", -- s5
		x"00000000", -- s4
		x"00000000", -- s3
		x"00000000", -- s2
		x"0000000F", -- s1
		x"0000000A", -- s0
		x"00000000", -- t7
		x"00000000", -- t6
		x"00000000", -- t5
		x"00000000", -- t4
		x"00000000", -- t3
		x"00000000", -- t2
		x"00000000", -- t1
		x"00000000", -- t0
		x"00000000", -- a3
		x"00000000", -- a2
		x"00000000", -- a1
		x"00000000", -- a0
		x"00000000", -- v1
		x"00000000", -- v0
		x"00000000", -- at
		x"00000000" -- #0
	);
begin

-- Writes the data to the register at rising edge of the clock.
process(i_clk)
begin
	if rising_edge(i_clk) then
		if i_wen = '1' then
			if unsigned(i_waddr_0) /= 0 then
				register_file(to_integer(unsigned(i_waddr_0))) <= i_wdata_0;	
			end if;
		end if;
	end if;
end process;

-- Reads the data from the register file in async. way.
process(i_raddr_0, i_raddr_1)
begin
	if unsigned(i_raddr_0) = 0 then
		o_rdata_0 <= (others => '0');
	else
		o_rdata_0 <= register_file(to_integer(unsigned(i_raddr_0)));
	end if;
	if unsigned(i_raddr_1) = 0 then
		o_rdata_1 <= (others => '0');
	else
		o_rdata_1 <= register_file(to_integer(unsigned(i_raddr_1)));
	end if;
end process;

end Behavioral;
