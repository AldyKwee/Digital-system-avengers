-- -----------------------
-- Simple UART Transmitter
-- -----------------------
-- Version:      1.00
-- Written By:   Brian Christian
-- Published On: 2016-09-15
-- Website:      www.thebcfactor.com
--
-- DESCRIPTION:
-- This is a very minimalistic implementation of a RS-232 UART transmitter.  It has no parity or flow control capabilities.
-- The data is transmitted as 1 Start bit, 8 Data bits and 1 Stop bit.  I have successfully tested it at the following baud
-- rates: 300, 9600, 115200, 921600.
--
-- EXTERNAL SIGNALS:
--   TXD   = (OUT)  Serial Output
--                  * Transmitted stream RS-232 of serial data.
--   BUSY  = (OUT)  Busy Indicator
--                  * A 'HIGH' indicates transmitter is actively sending data.
--                  * A 'LOW' indicates the transmitter is idle and ready for data to send.
--   DATA  = (IN)   Data Input
--                  * The 8-bits of data input to be transmitted.
--   LOAD  = (IN)   Data Latch
--                  *  On a LOW-to-HIGH transition, this will cause the DATA to be latched and the transmitter will start
--                     sending the data.
--   CLK50 = (IN)   System Clock
--                  * This clock is used to derive the baud rate clock.  See below how to calculate the baud rate.
--
-- BAUD RATE SELECTION:
--    The baud rate is determined by dividing half of the input clock signal (CLK50) by the divisor.  For example, this module
--    is defaultly set to 9600 baud.  The divisor used to generate the 9600 baud clock is calculated talking half of the 50MHz
--    system clock and dividing it by the desired baud rate.  (25MHz / 9600 Baud = 2604)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UART_TX is
    generic (
                divisor    : integer := 416    -- Set the Baud Rate Divisor here.  
                                                -- Some common values:  300 Baud = 83333, 9600 Baud = 2604, 115200 Baud = 217, 921600 Baud = 27
            );
            
    port(
            TXD         : out    std_logic;                      -- Transmitter output.
            BUSY        : out    std_logic;                      -- HIGH = Busy currently transmitting, LOW = Ready to transmit.
            DATA        : in    std_logic_vector(7 downto 0):= "00000000";    -- 8-bits of data to be transmitted.
            LOAD        : in    std_logic;                       -- LOW-to-HIGH transition latched DATA and starts transmitting.
            CLK50       : in    std_logic;                        -- 50 MHz system clock.
				led			: out std_logic
        );
end UART_TX;

architecture Behavior of UART_TX is

    signal    start        : std_logic;                        -- Starts the bit counter.
    signal    ibusy        : std_logic;                        -- Signals the module is currently transmitting.
    signal    output       : std_logic_vector(10 downto 0);    -- Shift register data.
    signal    divider      : integer range 0 to 4000000;       -- Counter used for dividing the system clock.
    signal    clk          : std_logic:= '0';                        -- Baud rate clock.
    signal    count        : integer range 0 to 10;            -- Counter used for selecting bit being transmitted.
	 signal lampu : std_logic;
    
begin

    -- ASSIGN EXTERNAL SIGNALS
    -- Used to being internal signals out to the 'real world'.
    BUSY <= ibusy;            -- Make the internal busy signal available outside.
    TXD  <= output(count);    -- Assign value of data at specific bit position to the TXD signal.
	 led <= lampu;

    -- START TRIGGER
    -- When the 'LOAD' sigal is received, send the 'start' signal only if it's not already busy sending
    -- data.
    process(LOAD)
    begin
        if (ibusy = '1') then            -- If the module is already sending data, ignore the 'LOAD' signal.
            start <= '0';
        elsif (falling_edge(LOAD)) then   -- Otherwise, on the rising edge of the 'LOAD' signal, start the
            start <= '1';                -- bit counter.
				lampu <= '0';
        end if;
    end process;

    -- BIT COUNTER
    -- This counter increments the bit counter for each clock pulse.  This is used to select which bit
    -- is transmitted.
    process(clk,start)
    begin
        if (start = '1') then            -- Detect the 'start' signal and then set the 'busy' signal
            count <= 0;                  -- and reset the bit count value.
            ibusy <= '1';
        elsif (count = 10) then          -- When the count reached '10' (11 actual bits), clear 'busy'
            ibusy <= '0';                -- to stop the counter.
        elsif (rising_edge(clk)) then    -- Increment the counter value on each rising edge of the clock.
            count <= count + 1;
        end if;
    end process;
    
    -- INPUT LATCH
    -- This takes the input data byte and latches it to the output shift register.
    process(LOAD)
    begin
        if (falling_edge(LOAD)) then      -- Do it on rising edge of LOAD signal.
            output(0) <= '1';            -- 1st bit is a '1' to make sure the TX line is at a high state.
            output(1) <= '0';            -- 2nd bit (1st Official bit) is a '0' or 'Start Bit'.
            output(9 downto 2) <= data;  -- 3rd thru 10th bits are the data.
            output(10) <= '1';           -- 11th bit is the '1' or 'Stop Bit'.
        end if;
    end process;

    -- BAUD RATE GENERATOR
    -- This divides the system to clock to the desired output Baud Rate.  In this example it divides a 50MHz clock.
    -- Sample Baud Rate divider values:  300 Baud = 83333, 9600 Baud = 2604, 115200 Baud = 217, 921600 Baud = 27
    -- Note that because the output clock is inverted on each full count, the formula to calculate the baud rate is:
    -- 25Mhz / Baud Rate = Divider Value  (ex:  25MHz / 9600 Baud = 2604)
    process(CLK50)
    begin
        if (rising_edge(CLK50)) then     -- On each rising edge of the 50MHz clock, do the following...
            if (divider < divisor) then  -- Check if we have counted past the Baud Rate divisor.
                divider <= divider + 1;  -- If not, increment the clock divider counter by 1.
            else
                divider <= 0;            -- If we have counted pass the divider value, then reset the clock counter back to 0.
                clk <= not clk;          -- Toggle the new output clock's signal. (This effectively splits the frequency by half.)
            end if;
        end if;
    end process;
    
end Behavior;