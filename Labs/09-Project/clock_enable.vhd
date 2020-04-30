------------------------------------------------------------------------
--CLOCK ENABLE
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- Provides unsigned numerical computation

------------------------------------------------------------------------
-- Entity declaration for clock enable
------------------------------------------------------------------------
entity clock_enable is
generic (
    g_NPERIOD : std_logic_vector(16-1 downto 0) := x"0006"
);
port (--------------------------------------------- INPUTS
			 clk_i          : in  std_logic;		        -- Clock input
			 srst_n_i       : in  std_logic; 			-- Synchronous reset (active low)
			 
		--------------------------------------------- OUTPUTS
			 clock_enable_o : out std_logic				--Clock enable output for other devices
);
end entity clock_enable;

------------------------------------------------------------------------
-- Architecture declaration for clock enable
------------------------------------------------------------------------
architecture Behavioral of clock_enable is
    signal s_cnt : std_logic_vector(16-1 downto 0) := x"0000";
begin

--------------------------------------------------------------------
-- p_clk_enable:
--------------------------------------------------------------------
    p_clk_enable : process (clk_i)
    begin
        if rising_edge(clk_i) then 		 -- Rising clock edge
            if srst_n_i = '0' then  		 -- Synchronous reset (active low)
                s_cnt <= (others => '0');  	 -- Clear all bits
                clock_enable_o <= '0';
            elsif s_cnt >= g_NPERIOD-1 then      -- Enable pulse
                s_cnt <= (others => '0');
                clock_enable_o <= '1';
            else
                s_cnt <= s_cnt + x"0001";
                clock_enable_o <= '0';
            end if;
        end if;
    end process p_clk_enable;

end architecture Behavioral;
