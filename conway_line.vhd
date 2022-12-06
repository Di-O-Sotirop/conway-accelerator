library ieee; 
use ieee.std_logic_1164.all; 
-- VERSION 4: DFF_Pixel is syncronous. 
entity conway_line is 
  generic(  len : natural :=3;
            n : natural :=32);
  port(
		clk, ALOAD, EN : in std_logic; --
        D   : in std_logic_vector(n-1 downto 0);
        SO  : out std_logic_vector(n-1 downto 0)
		); 
end conway_line; 

architecture archi of conway_line is 

--||COMPONENT||--
COMPONENT conway_line_buffer_block is port(
    clk, ALOAD, EN : in std_logic; --
    D   : in std_logic_vector(n-1 downto 0);
    SO  : out std_logic_vector(n-1 downto 0)
    ); 
end COMPONENT conway_line_buffer_block; 

--||SIGNALS||--

signal interWire: std_logic_vector((len+1)*n-1 downto 0);


--||ASSMEBLY||--
  begin  
  
  G0: FOR i IN len-1 downto 0 GENERATE
	Buff0 : conway_line_buffer_block Port Map(	
				
                clk => clk,
                ALOAD => ALOAD,
                EN => EN,
                D => interWire((i+1)*n-1 downto (i*n)+0),
                SO => interWire((i+1+1)*n-1 downto (i+1)*n+0)
                ); 
   end generate G0;	


     interWire(n-1 downto 0) <= D;
    SO <= interWire((len+1)*n-1 downto len*n);

end archi; 