--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:22:42 05/10/2019
-- Design Name:   
-- Module Name:   D:/My Documents/College Assignments/Semester 4/Digital System/Project/MAINRX/RX_TB.vhd
-- Project Name:  MAINRX
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UART
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RX_TB IS
END RX_TB;
 
ARCHITECTURE behavior OF RX_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART
    PORT(
         RXD : IN  std_logic;
         DATA : OUT  std_logic_vector(7 downto 0);
         BUSY : OUT  std_logic;
         CLK50 : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RXD : std_logic := '0';
   signal CLK50 : std_logic := '0';

 	--Outputs
   signal DATA : std_logic_vector(7 downto 0);
   signal BUSY : std_logic;

   -- Clock period definitions
   constant CLK50_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UART PORT MAP (
          RXD => RXD,
          DATA => DATA,
          BUSY => BUSY,
          CLK50 => CLK50
        );

   -- Clock process definitions
   CLK50_process :process
   begin
		CLK50 <= '0';
		wait for CLK50_period/2;
		CLK50 <= '1';
		wait for CLK50_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK50_period*10;

      -- insert stimulus here 
		RXD <= '1';
		wait for 10 us;
		RXD <= '0';
		wait for 10 us;
		RXD <= '1';
		wait for 10 us;
		RXD <= '1';
		wait for 10 us;
		RXD <= '0';
		wait for 10 us;
		RXD <= '0';
		wait for 10 us;
		RXD <= '1';
		wait for 10 us;
		RXD <= '1';
		wait for 10 us;
		RXD <= '1';
		wait for 10 us;
		RXD <= '1';
		wait for 10 us;
		RXD <= '1';
		wait for 10 us;	
		RXD <= '0';
		wait for 10 us;
		RXD <= '1';
		wait for 10 us;
      wait;
   end process;

END;
