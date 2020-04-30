----------------------------------------------------------------------------------
-- 4-bit ALU
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

---------------------------------------------------------------------------
entity alu is
      port( --------------------------------------------- INPUTS
            a : in STD_LOGIC_VECTOR(3 downto 0);            -- input A
            b : in STD_LOGIC_VECTOR(3 downto 0);            -- input B
            alu_select : in STD_LOGIC_VECTOR(3 downto 0);   -- process selection
            clk_i : in STD_LOGIC;                           -- 10 kHz clock signal
            srst_n_i : in STD_LOGIC;                        -- synchronous reset button active low
            en_i : in STD_LOGIC;                            -- clock enable is intended for 10kHz clock signal
            
            --------------------------------------------- OUTPUTS
            negf : out STD_LOGIC;                            -- negative flag
            zero : out STD_LOGIC;                            -- zero flag
            carry_out : out STD_LOGIC;                       -- carry flag                     
            y : out STD_LOGIC_VECTOR(3 downto 0)             -- MAIN OUTPUT
          );
end alu;
---------------------------------------------------------------------------
--ARCHITECTURE
---------------------------------------------------------------------------

architecture Behavioral of alu is

begin

process(clk_i)

variable temp: STD_LOGIC_VECTOR(4 downto 0) := "00000";
variable yv: STD_LOGIC_VECTOR(3 downto 0);
variable carry_var: STD_LOGIC; 
--variable zerov: STD_LOGIC := '0';

begin   
   if rising_edge(clk_i) then
   
         carry_out <= '0';
         negf <= '0';
         zero <= '0';

         if srst_n_i = '0' then                    --reset
               yv := (others => '0');         
         elsif en_i = '1' then
               
--------------------------------------------------------------------------------------------      
               case alu_select is
                  
                  when "0000" =>                   --a + b
                           temp := ('0' & a) + ('0' & b);
                           yv := temp(3 downto 0);
                           carry_var := temp(4);
                           carry_out <= carry_var;                  
                  when "0001" =>                   -- y = |a - b|, negf = 1 if b > a   
                           if (a >= b) then 
                               yv := std_logic_vector(unsigned(a) - unsigned(b));
                               negf   <= '0';
                           else 
                               yv := std_logic_vector(unsigned(b) - unsigned(a));
                               negf   <= '1';
                           end if;                      
                  when "0010" =>                   -- y = |b - a|, negf = 1 if b < a
                           if (b >= a) then 
                               yv := std_logic_vector(unsigned(b) - unsigned(a));
                               negf   <= '0';
                           else 
                               yv := std_logic_vector(unsigned(a) - unsigned(b));
                               negf   <= '1';
                           end if;                  
                  when "0011" =>                   -- a +1
                           yv := a + 1;
                  when "0100" =>                   -- a -1
                           yv := a - 1;
                  when "0101" =>                   -- Rotate right
                           yv := std_logic_vector(unsigned(b) ror 1);
                  when "0110" =>                   -- Rotate left
                           yv := std_logic_vector(unsigned(b) rol 1);
                  when "0111" =>                   -- a = b ??? if true '1' will be on display, if false '0' on the display
                           if(a=b) then
                               yv := "0001" ;
                              else
                               yv := "0000" ;
                              end if;
                              
                  when "1000" =>                   -- NOT a
                           yv := NOT a;               
                  when "1001" =>                   -- Logical shift left
                           yv := std_logic_vector(unsigned(b) sll 1);
                           
                           if (b(3) = '1') then         
                           carry_var := '1';
                           carry_out <= carry_var;   
                           end if;
                  when "1010" =>                   -- a AND b
                           yv := a AND b;            
                  when "1011" =>                   -- a OR b
                           yv := a OR b;   
                  when "1100" =>                   -- a XOR b
                           yv := a XOR b;   
                  when "1101" =>                   -- a XNOR b
                           yv := a XNOR b;   
                  when "1110" =>                   -- This operation in czech "Dvojkový doplnìk a", just from 4 will do -4
                           yv := NOT(a) + 1;
                  when "1111" =>                   -- Switch MSB and LSB    
                           yv(3) := b(0);
                           yv(2) := b(2);
                           yv(1) := b(1);
                           yv(0) := b(3);

                  when others => 
                           null;
               end case;
         end if;
--------------------------------------------------------------------------------------------   
         
            if yv = "0000" then
                     zero <= '1';
            end if;
         
         y <= yv;
         
         
            
               
      end if;
   end process;
   
end Behavioral;

