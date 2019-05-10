----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:51:59 05/08/2019 
-- Design Name: 
-- Module Name:    Add_dec - Behavioral 
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

entity Add_dec is
    Port ( addrs : in  STD_LOGIC_VECTOR (7 downto 0);
           EN_UART : out  STD_LOGIC;
           EN_I2C : out  STD_LOGIC;
           EN_LAIN : out  STD_LOGIC);
end Add_dec;

architecture Behavioral of Add_dec is

begin
	process(addrs)
	begin
		if (addrs = "10000000") then
			EN_UART <= '0';
			EN_I2C <= '1';
			EN_LAIN <= '1';
		elsif (addrs = "10000001") then
			EN_UART <= '1';
			EN_I2C <= '0';
			EN_LAIN <= '1';
		elsif (addrs = "10000010") then
			EN_UART <= '1';
			EN_I2C <= '1';
			EN_LAIN <= '0';
		end if;
	end process;

end Behavioral;

