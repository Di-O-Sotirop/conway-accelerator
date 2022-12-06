library ieee; 
use ieee.std_logic_1164.all; 

entity conway is 
generic(
        n: natural :=32;
        buff_num := 3
        );
  port(
		clk, ALOAD, EN : in std_logic; --
        D0   : in std_logic_vector(buff_num*n-1 downto 0);
        -- D1   : in std_logic_vector(n-1 downto 0);
        -- D2   : in std_logic_vector(n-1 downto 0);
        
        SO  : out std_logic_vector(n-1 downto 0)
		); 
end conway; 

architecture archi of conway is 

--||COMPONENT||--
COMPONENT conway_line is port(
    clk, ALOAD, EN : in std_logic; --
    D   : in std_logic_vector(n-1 downto 0);
    SO  : out std_logic_vector(n-1 downto 0)
    ); 
end COMPONENT conway_line; 


component conway_ADDER is port(
        	i00:	        in std_logic;
            i01:	        in std_logic;
            i02:	        in std_logic;
    
            i10:	        in std_logic;
            i11:            in std_logic;
            i12:	        in std_logic;
    
            i20:	        in std_logic;
            i21:	        in std_logic;
            i22:	        in std_logic;
    
            sum:	        out 
    );
    end component conway_ADDER;
    


--||SIGNALS||--
signal : std_logic_vector(neurons*pxbus-1 downto 0);


signal buffin: std_logic_vector(neurons*pxbus-1 downto 0);
signal buffout: std_logic_vector(neurons*pxbus-1 downto 0);

signal MuxToLine: std_logic_vector(buff_height*n-1 downto 0);
signal 

--||ASSMEBLY||--
  
  begin 
      G0: FOR i IN buff_num-1 downto 0 GENERATE
	    Buff0 : conway_line Port Map(	
				EN	=> EN,
				D	=> D(i*n+n-1 downto i*n),
                clk => clk,
                ALOAD => ALOAD(i),
                SO => SO(i*n+n-1 downto i*n)
		);		
   end generate G0;	
    -- Fix this with proper code
   begin 
   G1: FOR i IN n-2 downto 0 GENERATE
        core0 : conway_ADDER Port Map(
            i00 =>  SO(n-1),
            i01 =>  SO(n-1-1),
            i02 =>  SO(n-1-2),

            i10 =>  SO(2*n-1),
            i11 =>  SO(2*n-1-1),
            i12 =>  SO(2*n-1-2),

            i20 =>  SO(3*n-1),
            i21 =>  SO(3*n-1-1),
            i22 =>  SO(3*n-1-2),

            sum => SO(i)
   );
end archi; 
