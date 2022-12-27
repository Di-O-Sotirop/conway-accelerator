library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;


-------------------------------------------------------------------
--      CONWAY LINE BUFFER (32 Parallel Load Parallel Store DFFs)
-------------------------------------------------------------------
entity conway_line_buffer_block is generic(
    n: natural :=32
);
port(
    clk, EN : in std_logic; --
    D   : in std_logic_vector(n-1 downto 0);
    SO  : out std_logic_vector(n-1 downto 0)
    ); 
end conway_line_buffer_block; 

architecture structural of conway_line_buffer_block is 

----------------------------------------------------------------
--						COMPONENTS
----------------------------------------------------------------

	COMPONENT DFF is Port(
		clk	: in 	std_logic; 							--clock input
		EN	: in 	std_logic; 							
		D 	: in 	std_logic;
		Q 	: out 	std_logic
    );
	end COMPONENT DFF;
----------------------------------------------------------------
--						SIGNALS
----------------------------------------------------------------

begin  

-----------------------------------------------------------------
---					COMPONENT ASSEMBLY
-----------------------------------------------------------------
		--==			MAIN BUFFER			==--
		--	cell generation for all 32 dffs
		G1: for i in n-1 downto 0 generate
			Buff0	: DFF Port Map(									
				clk	=> clk,
				EN	=> EN,
				D	=> D(i),
				Q	=> SO(i)
		);		
		end generate G1;		

-----------------------------------------------------------------
---					SIGNAL ASSIGNMENT 
-----------------------------------------------------------------

-----------------------------------------------------------------			
--					P R O C E S S E S	
-----------------------------------------------------------------			
end structural; 
