----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:33:25 05/06/2019 
-- Design Name: 
-- Module Name:    UTAMA - Behavioral 
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

entity UTAMA is
	port(
		DATA 			: in std_logic_vector(7 downto 0) := "00000000";
		LOAD 			: in    std_logic; 
		BUSY        : out    std_logic;
		TXD         : out    std_logic;
		RXD			: in std_logic;
		DISPLAY 		: out std_logic_vector(6 downto 0);
		EN_SEGMENT 	: out std_logic;
		CLK50       : in    std_logic;
		address		: in std_logic_vector(1 downto 0)
	);
	
end UTAMA;

architecture Behavioral of UTAMA is
	component Main is
		port(
			DATA 			: in std_logic_vector(7 downto 0) := "00000000";
			LOAD 			: in    std_logic; 
			BUSY        : out    std_logic;
			TXD         : out    std_logic;
			DISPLAY 		: out std_logic_vector(6 downto 0);
			EN_SEGMENT 	: out std_logic;
			CLK50       : in    std_logic 
		);

	end component;
	
	component MAINRX is
		Port( 
			DATA_IN 	: out  STD_LOGIC_VECTOR (7 downto 0);
         OUT_D 		: out  STD_LOGIC_VECTOR (6 downto 0);
         CLK 			: in  STD_LOGIC;
         EN_SEGMENT 	: out  STD_LOGIC;
         RXD 			: in  STD_LOGIC;
			BUSY 			: out std_logic
		);
		
	end component;
begin
txmain : Main
					port map (
						DATA => DATA, -- left is component, right is entity
						LOAD => LOAD,		
						BUSY => BUSY,    
						TXD  => TXD,     
						DISPLAY => DISPLAY,		
						EN_SEGMENT => EN_SEGMENT,
						CLK50  => CLK50	
					);
	--addressing
	process (address)
		begin
			case address is
				when "00" => -- activate tx circuit
--				txmain : Main
--					port map (
--						DATA => DATA, -- left is component, right is entity
--						LOAD => LOAD,		
--						BUSY => BUSY,    
--						TXD  => TXD,     
--						DISPLAY => DISPLAY,		
--						EN_SEGMENT => EN_SEGMENT,
--						CLK50  => CLK50	
--					);
				
				when "01" => -- activate rx circuit
--				rxmain : MAINRX
--					port map (
--						DATA_IN => DATA,--betul		
--						BUSY => BUSY,  --betul  
--						RXD  => RXD,     --betul
--						OUT_D => DISPLAY,		--betul
--						EN_SEGMENT => EN_SEGMENT,--betul
--						CLK => CLK50	--betul
--					);
				when "10" =>
				
				when others =>
				
			end case;
		end process;
end Behavioral;

