--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:50:02 04/08/2020
-- Design Name:   
-- Module Name:   C:/Users/HP/Downloads/Digital-electronics-1-master/Labs/07-stopwatch/alu/alu_tb03.vhd
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
 
ENTITY alu_tb03 IS
END alu_tb03;
 
ARCHITECTURE behavior OF alu_tb03 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         alu_select : IN  std_logic_vector(3 downto 0);
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
   signal clk_i : std_logic := '0';
   signal srst_n_i : std_logic := '1';
   signal en_i : std_logic := '1';

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
     
		-- insert stimulus here
		
      --srst_n_i <= '1';
		--en_i <= '1';
		wait for 100 ns;
		a <= "1011";
		b <= "1011";
		
		alu_select <= "0000";
		wait for clk_i_period*5;
		alu_select <= "0001";
		wait for clk_i_period*5;
		alu_select <= "0010";
		wait for clk_i_period*5;
		alu_select <= "0011";
		wait for clk_i_period*5;
		alu_select <= "0100";
		wait for clk_i_period*5;
		alu_select <= "0101";
		wait for clk_i_period*5;
		alu_select <= "0110";
		wait for clk_i_period*5;
		alu_select <= "0111";
		wait for clk_i_period*5;
		--------------------------------
		alu_select <= "1000";
		wait for clk_i_period*5;
		alu_select <= "1001";
		wait for clk_i_period*5;
		alu_select <= "1010";
		wait for clk_i_period*5;
		alu_select <= "1011";
		wait for clk_i_period*5;
		alu_select <= "1100";
		wait for clk_i_period*5;
		alu_select <= "1101";
		wait for clk_i_period*5;
		alu_select <= "1110";
		wait for clk_i_period*5;
		alu_select <= "1111";
		wait for clk_i_period*5;		


      wait;
   end process;

END;
