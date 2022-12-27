library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
--use work.content_cnn.all;


entity DFF is 
--generic(n : natural := 1);
  port(
		clk	: in 	std_logic; 							--clock input
		EN	: in	std_logic; 							
		D 	: in 	std_logic;--_vector(n-1 downto 0);
		Q 	: out 	std_logic--_vector(n-1 downto 0)
		); 
end DFF; 

architecture Register_behavioral of DFF is 
begin
process (clk, EN) begin
	if EN = '1' then 
		if (clk'event and clk='1') then 
			Q <= D;
		end if;
	end if;
end process;
end Register_behavioral; 