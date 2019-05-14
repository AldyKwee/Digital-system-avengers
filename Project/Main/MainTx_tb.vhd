--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:33:42 05/10/2019
-- Design Name:   
-- Module Name:   D:/My Documents/College Assignments/Semester 4/Digital System/Project/Main/MainTx_tb.vhd
-- Project Name:  Main
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Main
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
 
ENTITY MainTx_tb IS
END MainTx_tb;
 
ARCHITECTURE behavior OF MainTx_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Main
    PORT(
         DATA : IN  std_logic_vector(7 downto 0);
         LOAD : IN  std_logic;
         BUSY : OUT  std_logic;
         TXD : OUT  std_logic;
         DISPLAY : OUT  std_logic_vector(6 downto 0);
         EN_SEGMENT : OUT  std_logic;
         CLK50 : IN  std_logic;
         led : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DATA : std_logic_vector(7 downto 0) := (others => '0');
   signal LOAD : std_logic := '0';
   signal CLK50 : std_logic := '0';

 	--Outputs
   signal BUSY : std_logic;
   signal TXD : std_logic;
   signal DISPLAY : std_logic_vector(6 downto 0);
   signal EN_SEGMENT : std_logic;
   signal led : std_logic;

   -- Clock period definitions
   constant CLK50_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Main PORT MAP (
          DATA => DATA,
          LOAD => LOAD,
          BUSY => BUSY,
          TXD => TXD,
          DISPLAY => DISPLAY,
          EN_SEGMENT => EN_SEGMENT,
          CLK50 => CLK50,
          led => led
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
		DATA <= "11111110";
		LOAD <= '0';
		
		wait for 10 us;
		
		LOAD <= '1';
		
		wait for 10 us;
		
		LOAD <= '0';

      wait;
   end process;

END;
