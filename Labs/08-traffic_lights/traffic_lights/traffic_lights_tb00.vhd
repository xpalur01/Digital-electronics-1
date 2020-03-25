
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY traffic_lights_tb00 IS
END traffic_lights_tb00;
 
ARCHITECTURE behavior OF traffic_lights_tb00 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT traffic
    PORT(
         clk_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         lights_o : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal srst_n_i : std_logic := '0';

 	--Outputs
   signal lights_o : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: traffic PORT MAP (
          clk_i => clk_i,
          srst_n_i => srst_n_i,
          lights_o => lights_o
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
      
      	
		wait for clk_i_period*46;
		
		
-------------------------------------------
--BUTTON PUSHED FOR BRIEF MOMENT..... reset
-------------------------------------------
		wait until rising_edge(clk_i); 
		srst_n_i <= '1';
		wait until rising_edge(clk_i);
		srst_n_i <= '0';

     wait for clk_i_period*40;


      wait;
   end process;

END;
