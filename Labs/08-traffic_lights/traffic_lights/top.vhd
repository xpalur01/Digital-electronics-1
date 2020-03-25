library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
----------------------------------------------------------------------------------------------------
entity top_t_lights is
	port(
			clk_i 	: in std_logic;
			BTN0 	: in std_logic;
			Leds_o : out std_logic_vector(5 downto 0)			
		  );
end top_t_lights;
----------------------------------------------------------------------------------------------------

architecture Behavioral of top_t_lights is
----------------------------------------------------------------------------------------------------
--INCLUDING ENTITY
----------------------------------------------------------------------------------------------------
	component clock_enable is 
		port( 
				clk_i							: in std_logic;
				srst_n_i 					: in std_logic;	-- RESET			
				clock_enable_o 			: out std_logic	
			  );			  
	end component;
	
	component traffic is
		port(
				clk_i       : in std_logic; 
				srst_n_i    : in std_logic; -- RESET			
				lights_o      : out std_logic_vector(5 downto 0)		
			  );			  
	end component;
----------------------------------------------------------------------------------------------------
signal s_res, s_en: std_logic;

begin
	s_res <= BTN0; 														
	
	En1: clock_enable
			port map( 
						clk_i 				=> clk_i,
						srst_n_i 			=> s_res,
						clock_enable_o		=> s_en					
						);
	En2: traffic
			port map(
						clk_i		 => s_en,
						srst_n_i  => s_res,
						lights_o	 => Leds_o					
						);
						
end Behavioral;

