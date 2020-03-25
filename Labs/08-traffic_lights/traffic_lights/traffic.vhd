library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--------------------------------------------------------------------------------------------
entity traffic is
	port( clk_i: in std_logic;
			srst_n_i: in std_logic;
			lights_o: out std_logic_vector(5 downto 0));
end traffic;
--------------------------------------------------------------------------------------------
architecture traffic of traffic is
	 type state_type is (state0_GR, state1_YR, state2_RR, state3_RG, state4_RY, state5_RR); -- state0_GR means state zero green & red
    signal state: state_type;
    signal count : unsigned(3 downto 0);
    constant SEC5: unsigned(3 downto 0) := "1111"; --decimal 15, meaning 15 x 1/3Hz = 5s
    constant SEC1: unsigned(3 downto 0) := "0011"; --decimal 3,  meaning  3 x 1/3Hz = 1s 
begin
process(clk_i, srst_n_i)
begin
		  if srst_n_i = '1' then
					state <= state0_GR;
					count <= "0000";
       
		  elsif rising_edge(clk_i) then
				case state is
						when state0_GR =>
									if count < SEC5 then
										state <= state0_GR;
										count <= count + 1;
									else
										state <= state1_YR;
										count <= "0000";
									end if;
						when state1_YR =>
									if count < SEC1 then
										state <= state1_YR;
										count <= count + 1;
									else
										state <= state2_RR;
										count <= "0000";
									end if;
						when state2_RR =>
									if count < SEC1 then
										state <= state2_RR;
										count <= count + 1;
									else
										state <= state3_RG;
										count <= "0000";
									end if;
						when state3_RG =>
									if count < SEC5 then
										state <= state3_RG;
										count <= count + 1;
									else
										state <= state4_RY;
										count <= "0000";
									end if;
						when state4_RY =>
									if count < SEC1 then
										state <= state4_RY;
										count <= count + 1;
									else
										state <= state5_RR;
										count <= "0000";
									end if;
						when state5_RR =>
									if count < SEC1 then
										state <= state5_RR;
										count <= count + 1;
									else
										state <= state0_GR;
										count <= "0000";
									end if;
						when others =>
										state <= state0_GR;
		end case;
	end if;
end process;

CodeToLights: process(state)
begin
case state is 
		when state0_GR => lights_o <= "100001";
		when state1_YR => lights_o <= "100010";
		when state2_RR => lights_o <= "100100";
		when state3_RG => lights_o <= "001100";
		when state4_RY => lights_o <= "010100";
		when state5_RR => lights_o <= "100100";
		when others => lights_o <= "100001";
	end case;
end process;
end traffic;
