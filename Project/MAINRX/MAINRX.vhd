----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:36:32 05/02/2019 
-- Design Name: 
-- Module Name:    MAINRX - Behavioral 
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

entity MAINRX is
    Port ( --DATA_IN : out  STD_LOGIC_VECTOR (7 downto 0);
           OUT_D : out  STD_LOGIC_VECTOR (6 downto 0);
           CLK : in  STD_LOGIC;
           EN_SEGMENT : out  STD_LOGIC;
           RXD : in  STD_LOGIC;
			  BUSY : out std_logic
			  );
end MAINRX;

architecture Behavioral of MAINRX is

component UART
	port ( RXD            : in    std_logic;                     -- Receiver input.
          DATA        : out    std_logic_vector(7 downto 0);    -- 8-bits of data received.
          BUSY        : out    std_logic;                       -- Indicates receiver is currently receiving.
          CLK50        : in    std_logic 
			);
			
end component;



component SevenSegment
	port (I : in std_logic_vector (7 downto 0);
			O : out std_logic_vector (6 downto 0)
			);
end component;

signal buatdata : STD_LOGIC_VECTOR (7 downto 0);


begin

EN_SEGMENT <= '0';

uart_receiver1 : UART
port map(
	RXD => RXD,
	DATA => buatdata,
	BUSY => BUSY,
	CLK50 => CLK
	);
	
sevensegment1 : SevenSegment
port map (
	I =>  buatdata,
	O => OUT_D
	);	

end Behavioral;

