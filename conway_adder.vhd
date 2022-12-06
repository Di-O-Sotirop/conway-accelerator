--------------------------------------------------------
-- VHDL code for n-bit adder (ESD figure 2.5)	
-- by Weujun Zhang, 04/2001
--
-- function of adder:
-- A plus B to get n-bit sum and 1 bit carry	
-- we may use generic statement to set the parameter 
-- n of the adder.							
--------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------

entity conway_ADDER is

generic(n: natural :=2);
port(	A:	        in std_logic;
	    B:	        in std_logic;
        carry_in:   in std_logic;
	    carry_out:	out std_logic
);

end conway_ADDER;

--------------------------------------------------------

architecture behv of conway_ADDER is

-- define a temparary signal to store the result

signal result: std_logic_vector(n downto 0);
signal half_add_res: std_logic;

begin					  
 
    -- the 3rd bit should be carry
    half_add_res    <=  A xor B;
    carry_out       <= (A and B) or (half_add_res and carry_in);
    sum             <= half_add_res xor carry_in;

end behv;

--------------------------------------------------------