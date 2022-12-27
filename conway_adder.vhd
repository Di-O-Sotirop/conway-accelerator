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
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;
--------------------------------------------------------

entity conway_ADDER is

generic(n: natural :=2);
port(	i00:	        in std_logic;
        i01:	        in std_logic;
        i02:	        in std_logic;

        i10:	        in std_logic;
        i11:            in std_logic;
        i12:	        in std_logic;

        i20:	        in std_logic;
        i21:	        in std_logic;
        i22:	        in std_logic;

	    sum:	        out std_logic
);

end conway_ADDER;

--------------------------------------------------------

architecture behv of conway_ADDER is

-- define a temparary signal to store the result

signal result: std_logic_vector(3 downto 0);

begin		
    --result <= i00 + i01 + i02 + i10 + i12 + i20 + i21 + i22;
    
    --process(result)
    process(i00,i01,i02,i10,i12,i20,i21,i22)
     variable  result : unsigned(3 downto 0);-- := i00 + i01 + i02 + i10 + i12 + i20 + i21 + i22;
     variable concat : std_logic_vector(3 downto 0);-- := (i00 + i01 + i02 + i10 + i12 + i20 + i21 + i22) & i11;
        begin
             result := "0000";
             if (i00 = '1') then
                result := result+1;
             end if;
             if (i01 = '1') then
                result := result+1;
             end if;
             if (i02 = '1') then
                result := result+1;
             end if;
             if (i10 = '1') then
                result := result+1;
             end if;
             if (i12 = '1') then
                result := result+1;
             end if;
             if (i20 = '1') then
                result := result+1;
             end if;
             if (i21 = '1') then
                result := result+1;
             end if;
             if (i22 = '1') then
                result := result+1;
             end if;
           -- result := i00 + i01 + i02 + i10 + i12 + i20 + i21 + i22;
            if result(3 downto 1) = "000" then -- result < 2
                sum <= '0';
            elsif result(3 downto 1) = "001" then  -- 4 > result > 1 
                if i11 = '1'then
                    sum <= '1';
                elsif result(0) = '0' then
                    sum <= '0';
                else --dead cell with 3 neighbors
                    sum <= '1';
                end if;
            else
                sum <= '0';
            end if;
       end process;
end behv;

--------------------------------------------------------