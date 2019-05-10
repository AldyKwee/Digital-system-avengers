--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:43:03 05/10/2019
-- Design Name:   
-- Module Name:   D:/My Documents/College Assignments/Semester 4/Digital System/Project/Main/TxCircuit_tb.vhd
-- Project Name:  Main
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UART_TX
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
 
ENTITY TxCircuit_tb IS
END TxCircuit_tb;
 
ARCHITECTURE behavior OF TxCircuit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART_TX
    PORT(
         TXD : OUT  std_logic;
         BUSY : OUT  std_logic;
         DATA : IN  std_logic_vector(7 downto 0);
         LOAD : IN  std_logic;
         CLK50 : IN  std_logic;
         led : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DATA : std_logic_vector(7 downto 0) := (others => '0');
   signal LOAD : std_logic := '0';
   signal CLK50 : std_logic := '0';

 	--Outputs
   signal TXD : std_logic;
   signal BUSY : std_logic;
   signal led : std_logic;

   -- Clock period definitions
   constant CLK50_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UART_TX PORT MAP (
          TXD => TXD,
          BUSY => BUSY,
          DATA => DATA,
          LOAD => LOAD,
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
		DATA <= "01100011";
		LOAD <= '1';
		wait for 10 us;
		LOAD <= '0';
		wait for 5 us;
		LOAD <= '1';


      wait;
   end process;

END;
