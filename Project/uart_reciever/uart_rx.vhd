-- --------------------
-- Simple UART Receiver
-- --------------------
-- Version:      1.00
-- Written By:   Brian Christian
-- Published On: 2016-09-15
-- Website:      www.thebcfactor.com
--
-- DESCRIPTION:
-- This is a very minimalistic implementation of a RS-232 UART receiver.  It has no parity or flow control capabilities.
-- The receiver looks for data containing 1 Start bit, 8 Data bits (Stop bits are ignored).  There is also no frame error
-- checking.  I have successfully tested it at the following baud rates: 300, 9600, 115200, 128000 and 921600.
--
-- EXTERNAL SIGNALS:
--   RXD   = (IN)   Serial Input
--                  * Connection to receive a stream RS-232 of serial data.
--   BUSY  = (OUT)  Busy Indicator
--                  * A 'HIGH' indicates receiver is actively acquiring data.
--                  * A 'LOW' indicates the receiver is idle and ready for data.
--                  * A HIGH-to-LOW transition occurs when the data becomes available on the DATA bus.
--   DATA  = (OUT)  Data Output
--                  * The 8-bits of received data.
--   CLK50 = (IN)   System Clock
--                  * This clock is used to derive the baud rate clock.  See blow how to calculate the baud rate.
--
-- BAUD RATE SELECTION:
--    The baud rate is determined by dividing half of the input clock signal (CLK50) by the divisor.  For example, this module
--    is defaultly set to 9600 baud.  The divisor used to generate the 9600 baud clock is calculated talking half of the 50MHz
--    system clock and dividing it by the desired baud rate.  (25MHz / 9600 Baud = 2604)


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UART is
    generic (
                divisor        : integer := 2604    -- Set the Baud Rate Divisor here.  
                                                    -- Some common values:  300 Baud = 83333, 9600 Baud = 2604, 115200 Baud = 217, 921600 Baud = 27
            );
    port    (
                RXD            : in    std_logic;                     -- Receiver input.
                DATA        : out    std_logic_vector(7 downto 0);    -- 8-bits of data received.
                BUSY        : out    std_logic;                       -- Indicates receiver is currently receiving.
                CLK50        : in    std_logic                        -- 50 MHz System clock
            );
end UART;

architecture Behavior of UART is

    signal clk                : std_logic;                    -- Baud clock.
    signal divider            : integer range 0 to 25000000;  -- Counter used for dividing the system clock.
    signal ibusy            : std_logic;                      -- Signals the module is currently receiving.
    signal count            : integer range 0 to 10;          -- Counter used for selecting bit being transmitted.
    signal idata            : std_logic_vector(9 downto 0);   -- Receive shift register.

begin

    -- ASSIGN EXTERNAL SIGNALS
    -- Used to being internal signals out to the 'real world'.
    BUSY <= ibusy;
    
    -- CLOCK SYNC TRIGGER / COUNTER
    -- Detect the beginning of the serial stream and start the baud clock generator.
    process(RXD,count)
    begin
        if (count > 9) then              -- If the number of bits counted is greater then 9,
            ibusy <= '0';                -- stop the baud clock generator/bit counter.
        elsif (falling_edge(RXD)) then   -- Otherwise, on the falling edge of RXD input,
            ibusy <= '1';                -- start the baud clock generator/bit counter.
        end if;
    end process;
    
    -- BAUD CLOCK GENERATOR
    -- Generate the desired baud clock by dividing the system clock.  This clock is counter is normally held at 0 until it
    -- is told to start.  This ensures the baud clock is in sync with the input serial stream.
    process(CLK50,ibusy)
    begin
        if (ibusy = '0') then                   -- If the receiver is not running, don't generate a baud clock.
            divider <= 0;                       -- Keep the clock divider at 0 to ensure sync with when the clock is started.
            clk <= '1';                         -- Keep the baud clock at '1' to start with a known clock phase.
        else
            if (rising_edge(CLK50)) then        -- On each rising edge of the 50MHz clock, do the following...
                if (divider < divisor) then     -- Check if we have counted past the Baud Rate divisor.
                    divider <= divider + 1;     -- If not, increment the clock divider counter by 1.
                else
                    divider <= 0;               -- If we have counted pass the divider value, then reset the clock counter back to 0.
                    clk <= not clk;             -- Toggle the new output clock's signal. (This effectively splits the frequency by half.)
                end if;
            end if;
        end if;
    end process;
    
    -- BIT COUNTER
    -- Increments to count how many bits have been sampled.
    process(clk,ibusy)
    begin
        if (ibusy = '1') then            -- Only count when the receiver is 'running'.
            if (rising_edge(clk)) then   -- Increment counter on each baud clock pulse.
                count <= count + 1;
            end if;
        else                            -- If we are not currently receiving,
            count <= 0;                 -- set the counter to 0.
        end if;
    end process;

    -- INPUT SAMPLE
    -- Latch the RXD input to the data register at the bit specified by the bit counter.
    process(clk,ibusy)
    begin
        if (ibusy = '1') then               -- Only latch if the receiver is 'running".
            if (falling_edge(clk)) then     -- Latch on the falling edge of the baud clock. The falling edge occurs approximately
                                            -- at the middle of the transmitted bits.  (If the sender is reliably clocked.)
                idata(count) <= RXD;        -- Store the samples bit in the data latch at the position specified by the bit counter.
            end if;
        end if;
    end process;
    
    -- OUTPUT LATCH
    -- When all 8-bits are received, make it available on the output.
    process(count)
    begin
        if (falling_edge(ibusy)) then    -- On falling edge of 'busy' signal,
            DATA <= idata(8 downto 1);   -- latch 8-bits of received data to output.
        end if;
    end process;
    
end Behavior;