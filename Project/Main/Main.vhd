----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:43:48 05/02/2019 
-- Design Name: 
-- Module Name:    Main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
------------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:11:07 05/02/2019 
-- Design Name: 
-- Module Name:    Main - Behavioral 
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

entity Main is
	port(
	DATA : in std_logic_vector(7 downto 0) := "00000000";
	LOAD : in    std_logic; 
	BUSY        : out    std_logic;
	TXD         : out    std_logic;
	DISPLAY : out std_logic_vector(6 downto 0);
	EN_SEGMENT : out std_logic;
	CLK50       : in    std_logic; 
	led 			: out std_logic
	);

end Main;

architecture Behavioral of Main is
	
-- Component Declaration Area
component SevenSegment
	Port ( I : in std_logic_vector(7 downto 0);
     O : out std_logic_vector(6 downto 0));
end component;

component UART_TX
	generic (
                divisor    : integer := 416   -- Set the Baud Rate Divisor here.  
                                                -- Some common values:  300 Baud = 83333, 9600 Baud = 2604, 115200 Baud = 217, 921600 Baud = 27
            );
            
    port(
            TXD         : out    std_logic;                      -- Transmitter output.
            BUSY        : out    std_logic;                      -- HIGH = Busy currently transmitting, LOW = Ready to transmit.
            DATA        : in    std_logic_vector(7 downto 0) := "00000000";    -- 8-bits of data to be transmitted.
            LOAD        : in    std_logic;                       -- LOW-to-HIGH transition latched DATA and starts transmitting.
            CLK50       : in    std_logic;                        -- 50 MHz system clock.
				led 			: out std_logic
        );
end component;
	
-- signal buatdata : STD_LOGIC_VECTOR (7 downto 0);	

begin
EN_SEGMENT <= '0';
SEVEN_SEGMENT : SevenSegment
port map(
	I => DATA,	-- left is component's, right is entity's
	O => DISPLAY
);

TX_CIRCUIT : UART_TX
port map(
	TXD => TXD,
	BUSY => BUSY,
	DATA => DATA,
	LOAD => LOAD,
	CLK50 => CLK50,
	led => led
);

end Behavioral;

