--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:42:06 03/20/2020
-- Design Name:   
-- Module Name:   C:/Users/HP/Downloads/Digital-electronics-1-master/Labs/07-stopwatch/stopwatch/stopwatch_tb00.vhd
-- Project Name:  stopwatch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: driver_7seg
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
use ieee.numeric_std.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY stopwatch_tb00 IS
END stopwatch_tb00;
 
ARCHITECTURE behavior OF stopwatch_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT driver_7seg
    PORT(
         clk_i    : IN  std_logic;
         srst_n_i : IN  std_logic;
         cnt_en_i : IN  std_logic;
         seg_o    : OUT  unsigned(7-1 downto 0);
         dig_o    : OUT  unsigned(3 downto 0)
        );
    END COMPONENT;
    
------------------------------------------------------------------
   --Inputs
   signal clk_i : std_logic := '0';
   signal srst_n_i : std_logic := '0';
   signal cnt_en_i : std_logic := '0';

 	--Outputs
   signal seg_o : unsigned(6 downto 0);
   signal dig_o : unsigned(3 downto 0);
	
	

   -- Clock period definitions
   constant clk_i_period : time := 1 ns;
 ------------------------------------------------------------------
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: driver_7seg PORT MAP (
          clk_i => clk_i,
          srst_n_i => srst_n_i,
          cnt_en_i => cnt_en_i,
          seg_o => seg_o,
          dig_o => dig_o
        );
-----------------------------------------------------------
   -- Clock process definitions
   clk_i_process :process
   begin
	while now < 1000ns loop
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
		end loop;
   end process;
 
-----------------------------------------------------------
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      --wait for 100 ns;	

		srst_n_i <= '1';
		wait until rising_edge(clk_i);
      --wait for clk_i_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
