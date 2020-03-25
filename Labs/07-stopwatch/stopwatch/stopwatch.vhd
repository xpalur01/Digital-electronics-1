library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------------------------------------------------------
entity stopwatch is
port(
	--VSTUPY
	 clk_i       : in std_logic;
    ce_100Hz_i  : in std_logic; -- clock enable
    srst_n_i    : in std_logic; -- aktivni v low	
    cnt_en_i    : in std_logic; --stopwatch enables
	 
	 --VYSTUPY
	 sec_h_o     : out unsigned (4-1 downto 0); --desitky sekund 
    sec_l_o     : out unsigned (4-1 downto 0); --jednotky sekundy
    hth_h_o     : out unsigned (4-1 downto 0); --desetiny sekundy
    hth_l_o     : out unsigned (4-1 downto 0)  --setiny sekundy
		);
end entity stopwatch;
--------------------------------------------------------------------------------------------------------------------------

architecture Behavioral of stopwatch is

   signal s_sec_h_o  	: unsigned (4-1 downto 0) := (others => '0');
	signal s_sec_l_o  	: unsigned (4-1 downto 0) := (others => '0');
	signal s_hth_h_o  	: unsigned (4-1 downto 0) := (others => '0');
	signal s_hth_l_o  	: unsigned (4-1 downto 0) := (others => '0');
   signal s_en			   : std_logic;



begin

--------------------------------------------------------------------------------------------------------------------------
procesAdding: process(clk_i)																		-- PROCES prirazeni
begin
	if rising_edge(clk_i) then 
            
		 hth_l_o <= unsigned(s_hth_l_o);
		 hth_h_o <= unsigned(s_hth_h_o);
		 sec_l_o <= unsigned(s_sec_l_o);
		 sec_h_o <= unsigned(s_sec_h_o);
         
			
    if cnt_en_i = '1' then
				s_en <=	'0';
		 else
				s_en <=	'1';
    end if;
end if;
end process; 


--------------------------------------------------------------------------------------------------------------------------
--PODMINKY: kdyz bude plny musi se resetovat na nuly, jakmile se dostane nejnizsi na devet presune se jednicka dal a tak dokola se vsema nasledujicima radama(podmineno tim ze musí být resetované enable signaly v urcite hodnote) 
procesCount: process(clk_i, srst_n_i, s_en, s_sec_h_o, s_sec_l_o, s_hth_h_o, s_hth_l_o)
         
begin    
	if rising_edge(clk_i) then    	    
				if srst_n_i = '0'	or (s_hth_l_o = 9 and s_hth_h_o = 9 and s_sec_l_o = 9 and s_sec_h_o = 5) then      --RESET PRI NAPLNENI COUNTERU 59 99
				
									s_sec_h_o <= (others => '0');  
									s_sec_l_o <= (others => '0');
									s_hth_h_o <= (others => '0');
									s_hth_l_o <= (others => '0');
                
				elsif s_en = '1' and ce_100Hz_i = '1' then 																			  --SIGNAL ENABLE & CLOCK ENABLE
									s_hth_l_o <= s_hth_l_o + 1;
									  
							if s_hth_l_o = 9 then																										  --PLNE SETINY SEKUND 
												s_hth_l_o <= (others => '0'); --VYNULOVANI 
												s_hth_h_o <= s_hth_h_o + 1;   --PRENESENI DO DALSIHO RADU
									  
							if s_hth_h_o = 9 then																										  --PLNE DESETINY SEKUND
												s_hth_h_o <= (others => '0'); --VYNULOVANI
												s_sec_l_o <= s_sec_l_o + 1;	--PRENESENI DO VYSIHO RADU
												 
							if s_sec_l_o = 9 then																										  --PLNE JEDNOTKY SEKUND
												s_sec_l_o <= (others => '0'); --VYNULOVANI
												s_sec_h_o <= s_sec_h_o + 1;	--PRENESENI DO POSLEDNIHO RADU, JEDE JENOM DO 5
															
					end if;
				end if;
			end if;
		end if;
	end if;

end process; 

end architecture Behavioral;