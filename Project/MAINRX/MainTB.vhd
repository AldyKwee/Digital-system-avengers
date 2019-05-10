--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:32:47 05/10/2019
-- Design Name:   
-- Module Name:   D:/My Documents/College Assignments/Semester 4/Digital System/Project/MAINRX/MainTB.vhd
-- Project Name:  MAINRX
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MAINRX
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
 
ENTITY MainTB IS
END MainTB;
 
ARCHITECTURE behavior OF MainTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MAINRX
    PORT(
         OUT_D : OUT  std_logic_vector(6 downto 0);
         CLK : IN  std_logic;
         EN_SEGMENT : OUT  std_logic;
         RXD : IN  std_logic;
         BUSY : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RXD : std_logic := '0';

 	--Outputs
   signal OUT_D : std_logic_vector(6 downto 0);
   signal EN_SEGMENT : std_logic;
   signal BUSY : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MAINRX PORT MAP (
          OUT_D => OUT_D,
          CLK => CLK,
          EN_SEGMENT => EN_SEGMENT,
          RXD => RXD,
          BUSY => BUSY
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 
		RXD <= '0';
		wait for 10 us;
		RXD <= '1';
		wait for 10 us;
		RXD <= '0';
		wait for 10 us;
		RXD <= '1';
		wait for 10 us;
		RXD <= '0';
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
