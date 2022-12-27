library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;
----------------------------------------------------------
-- Testbench of the verilog top module containing the 
-- HWPE signals.
-- Reads from conway_small_dataset.txt 32 lines of 32 bits
-- and stores the next state of the board to 
-- Results_file.txt
----------------------------------------------------------
entity ConwayHPWETestbench is end ConwayHPWETestbench;


architecture tb of ConwayHPWETestbench is

    signal en_monitor   : std_logic_vector(3-1 downto 0);
    signal inp_monitor   : std_logic_vector(32-1 downto 0);

    signal clk          : std_logic;
    signal rst          : std_logic;

    signal read_v       : std_logic;
    signal read_r       : std_logic;
    signal input_data   : std_logic_vector(32-1 downto 0);
    
    signal write_v      : std_logic;
    signal write_r      : std_logic;
    signal output_data  : std_logic_vector(32-1 downto 0);
		--File Management
	file file_BOARD 	: text;
	file file_PIXEL 	: text;
	
	---------------------------
	--COMPONENT DECLARATIOn  --
	---------------------------	
	component conway_hwpe is 
    port(
        
        en_monitor      : out   std_logic_vector(3-1 downto 0);
        inp_monitor     : out   std_logic_vector(32-1 downto 0);
        ap_clk, ap_rst_n : in std_logic;

        r_reqs_TVALID   : in    std_logic;
        r_reqs_TREADY   : out   std_logic;
        r_reqs_TDATA    : in    std_logic_vector(32-1 downto 0);

  
        w_reqs_TVALID   : out   std_logic;
        w_reqs_TREADY   : in    std_logic;
        w_reqs_TDATA    : out   std_logic_vector(32-1 downto 0)
        
        
   );
  end component;
begin
	---------------------------
	--COMPONENT INSTANTIATION--
	---------------------------	
	CONW: conway_hwpe port map(
	
	    en_monitor     => en_monitor,
	   inp_monitor     => inp_monitor,
	
        ap_clk          => clk,
        ap_rst_n        => rst,

        r_reqs_TVALID   => read_v,
        r_reqs_TREADY   => read_r,
        r_reqs_TDATA    => input_data,

  
        w_reqs_TVALID   => write_v,
        w_reqs_TREADY   => write_r,
        w_reqs_TDATA    => output_data
	);

	------------------------------------------------------	
	--					P R O C E S S 					--
	------------------------------------------------------	

			-- Clock Process--
	cc	: process
		constant T: time := 50 ns;
		begin
			clk <= '1';
			wait for T/2;
			clk <= '0';
			wait for T/2;
		end process;

		--== Pixel INITIALIZATION ==--
		--== Parameter INITIALIZATION ==--
    tb1 : process
	--==Indexes and Constants==--
	constant period		: time 		:= 50 ns;
	--==File Variables==--
	variable v_ILINE	: line;
	variable v_BOARD	: std_logic_vector(32-1 downto 0);
	variable v_PIXEL	: std_logic_vector(24 downto 0);
--	file file_BOARD	    : text open read_mode is  "conway_small_dataset.txt";
	file file_BOARD_R	: text open write_mode is "Results_file.txt";
	
begin
	--== Signal Initialization ==--
    -- write_v and write_r are handled by the datapath
    rst             <= '1';
    read_v          <= '0';
    input_data      <= (others => '0');
    write_r         <= '0';

    wait for period;
    --== Start Processing ==--
    rst             <= '0';
    read_v          <= '1';
    write_r         <= '0';

    --== Load/Store Board ==--
    file_open(file_BOARD, "conway_small_dataset.txt", read_mode);
--    file_open(file_BOARD_R, "conway_small_dataset_R.txt", write_mode);
	while not endfile(file_BOARD) loop --read all file
		readline(file_BOARD, v_ILINE);	--line by line
		read(v_ILINE, v_BOARD);
		input_data <= v_BOARD;		 
	
    	wait for period;
		
        write_v     <= '1';
        write_r     <= '1';

        write(v_ILINE,output_data,right,32);
		writeline(file_BOARD_R, v_ILINE);
	end loop;	
        
	end process;
end tb;




