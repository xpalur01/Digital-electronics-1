------------------------------------------------------------------------
--TOP
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for top level
------------------------------------------------------------------------
entity top is
port (
    clk_i      : in  std_logic;                                  -- 10 kHz clock signal
    BTN0       : in  std_logic;                                  -- Synchronous reset
    SW0_CPLD, SW1_CPLD, SW2_CPLD, SW3_CPLD  : in  std_logic;     -- Input A
    SW4_CPLD, SW5_CPLD, SW6_CPLD, SW7_CPLD  : in  std_logic;     -- Input B
    SW8_CPLD, SW9_CPLD, SW10_CPLD,SW11_CPLD : in  std_logic;     -- Input ALU Operation Select


    disp_dp          : out std_logic;                            -- Decimal point
    disp_seg_o       : out std_logic_vector(7-1 downto 0);
    disp_dig_o       : out std_logic_vector(4-1 downto 0);
	 
	 LD0              : out std_logic;           -- Carry = alu_carry_out
    LD1              : out std_logic;           -- Negative flag = alu_negf
    LD2              : out std_logic            -- Output equal "0" = alu_zero
);
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    signal s_dataA, s_dataB   : std_logic_vector(4-1 downto 0);
    signal s_dataSEL          : std_logic_vector(4-1 downto 0);
    signal s_en               : std_logic;
    signal s_disp             : std_logic_vector(4-1 downto 0);
	 signal s_zero             : std_logic;
	 signal s_negf             : std_logic;
	 signal s_carry_out        : std_logic;

begin

    -- Combine 4-bit inputs to internal signals
    s_dataSEL(3) <= SW11_CPLD;
    s_dataSEL(2) <= SW10_CPLD;               --ALU Operation Select
    s_dataSEL(1) <= SW9_CPLD;
    s_dataSEL(0) <= SW8_CPLD;

    s_dataB(3) <= SW7_CPLD;         
    s_dataB(2) <= SW6_CPLD;                  --Input B Switches
    s_dataB(1) <= SW5_CPLD;
    s_dataB(0) <= SW4_CPLD;

    s_dataA(3) <= SW3_CPLD;
    s_dataA(2) <= SW2_CPLD;                  --Input A Switches
    s_dataA(1) <= SW1_CPLD;
    s_dataA(0) <= SW0_CPLD;


--------------------------------------------------------------------
-- Sub-block of driver_7seg entity
--------------------------------------------------------------------
    DRIVER_7SEG : entity work.driver_7seg
    port map (
        clk_i    => clk_i,      -- 10 kHz
        srst_n_i => BTN0,       -- Synchronous reset
        data0_i  => s_disp,     -- Slide switches data
        data1_i  => "0000",
        data2_i  => s_dataB,
        data3_i  => s_dataA,
        dp_i     => "1111",     -- Decimal point not used
        
        dp_o     => disp_dp,
        seg_o    => disp_seg_o,
        dig_o    => disp_dig_o
    );
--------------------------------------------------------------------
-- Sub-block of alu entity
--------------------------------------------------------------------
    ALU_BLOCK : entity work.alu
    port map (
        clk_i    => clk_i,          -- 10 kHz
        srst_n_i => BTN0,           -- Synchronous reset
        en_i  => s_en,              -- Slide switches data
        alu_select  => s_dataSEL,
        a  => s_dataA,
        b  => s_dataB,
        
        negf => s_negf,
        zero => s_zero,
        carry_out => s_carry_out,
        y => s_disp
    );
--------------------------------------------------------------------
-- Sub-block of clock enable entity 
--------------------------------------------------------------------
    Alu_Clock : entity work.clock_enable
    port map (
    
       clk_i => clk_i,
       srst_n_i => BTN0,
       clock_enable_o => s_en
       
    );
	 
	 LD0 <= s_carry_out;
    LD1 <= s_negf;
    LD2 <= s_zero;
         
end architecture Behavioral;