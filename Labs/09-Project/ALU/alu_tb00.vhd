--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:44:23 04/07/2020
-- Design Name:   
-- Module Name:   C:/Users/HP/Downloads/Digital-electronics-1-master/Labs/07-stopwatch/alu/alu_tb00.vhd
-- Project Name:  alu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
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
 
ENTITY alu_tb00 IS
END alu_tb00;
 
ARCHITECTURE behavior OF alu_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         alu_select : IN  std_logic_vector(2 downto 0);
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         negf : OUT  std_logic;
         zerf : OUT  std_logic;
         carf : OUT  std_logic;
         ovrf : OUT  std_logic;
         y : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal alu_select : std_logic_vector(2 downto 0) := (others => '0');
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal negf : std_logic;
   signal zerf : std_logic;
   signal carf : std_logic;
   signal ovrf : std_logic;
   signal y : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          alu_select => alu_select,
          a => a,
          b => b,
          negf => negf,
          zerf => zerf,
          carf => carf,
          ovrf => ovrf,
          y => y
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 50 ns;	

      
		
		
		

      -- insert stimulus here 

      wait;
   end process;

END;
