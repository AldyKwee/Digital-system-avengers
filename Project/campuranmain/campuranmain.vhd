----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:39:45 05/07/2019 
-- Design Name: 
-- Module Name:    campuranmain - Behavioral 
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

entity campuranmain is
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
end campuranmain;

architecture Behavioral of campuranmain is

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
	
begin

receiver:MAINRX
port map(
	DATA_IN <= DATA,
	OUT_D <= DISPLAY,
	CLK <= CLK50,
	EN_SEGMENT <= EN_SEGMENT,
	RXD <= RXD,
	BUSY <= BUSY
	);
	
transmitter:Main
port map(
	DATA <= DATA,
	LOAD <= LOAD,
	BUSY <= BUSY,
	TXD <= TXD,
	DISPLAY <= DISPLAY,
	EN_SEGMENT <= EN_SEGMENT,
	CLK50 <= CLK50
	);

end Behavioral;

