--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:36:21 04/08/2020
-- Design Name:   
-- Module Name:   C:/Users/HP/Downloads/Digital-electronics-1-master/Labs/07-stopwatch/alu/alu_tb01.vhd
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
use IEEE.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY alu_tb01 IS
END alu_tb01;
 
ARCHITECTURE behavior OF alu_tb01 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         alu_select : IN  std_logic_vector(3 downto 0);
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
			carry_in : in STD_LOGIC;
			clk_i : in STD_LOGIC;
			srst_n_i : in STD_LOGIC;
			en_i : in STD_LOGIC;
			
			
         negf : OUT  std_logic;
         zero : OUT  std_logic;
         carry_out : OUT  std_logic;
         --ovrf : OUT  std_logic;
         y : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal alu_select : std_logic_vector(2 downto 0) := (others => '0');
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal negf : std_logic;
   signal zero : std_logic;
   signal carry_out : std_logic;
   signal ovrf : std_logic;
   signal y : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          alu_select => alu_select,
          a => a,
          b => b,
			 carry_in => carry_in,
          negf => negf,
          zero => zero,
          carry_out => carry_out,
          --ovrf => ovrf,
          y => y
        );

  
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 50 ns;	
		
		a <= "0110";
		b <= "0111";
		alu_select <= "001";
		wait for 50 ns;
		alu_select <= "010";
		wait for 50 ns;
		alu_select <= "011";
		wait for 100 ns;
		
		a <= x"0A";
	   b <= x"04";
		alu_select <= x"0";
	  
		for i in 0 to 15 loop 
			alu_select <= alu_select + x"1";
			wait for 50 ns;
		  end loop;
		  
		a <= x"F6";
	   b <= x"0A";
      wait;

      -- insert stimulus here 

      wait;
   end process;

END;
