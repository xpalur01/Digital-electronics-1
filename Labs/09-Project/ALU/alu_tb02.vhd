--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:37:36 04/08/2020
-- Design Name:   
-- Module Name:   C:/Users/HP/Downloads/Digital-electronics-1-master/Labs/07-stopwatch/alu/alu_tb02.vhd
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
 
ENTITY alu_tb02 IS
END alu_tb02;
 
ARCHITECTURE behavior OF alu_tb02 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         alu_select : IN  std_logic_vector(3 downto 0);
         --carry_in : IN  std_logic;
         clk_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         en_i : IN  std_logic;
         negf : OUT  std_logic;
         zero : OUT  std_logic;
         carry_out : OUT  std_logic;
         y : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');
   signal alu_select : std_logic_vector(3 downto 0) := (others => '0');
   signal carry_in : std_logic := '0';
   signal clk_i : std_logic := '0';
   signal srst_n_i : std_logic := '0';
   signal en_i : std_logic := '0';

 	--Outputs
   signal negf : std_logic;
   signal zero : std_logic;
   signal carry_out : std_logic;
   signal y : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          a => a,
          b => b,
          alu_select => alu_select,
          --carry_in => carry_in,
          clk_i => clk_i,
          srst_n_i => srst_n_i,
          en_i => en_i,
          negf => negf,
          zero => zero,
          carry_out => carry_out,
          y => y
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      alu_select <= "0000";		
		a <= x"A";
	   b <= x"4";
			  
		for i in 0 to 15 loop 
			alu_select <= alu_select + x"1";
			wait for 50 ns;
		end loop;
      wait;

      -- insert stimulus here 

      wait;
   end process;

END;
