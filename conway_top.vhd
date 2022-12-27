library ieee; 
use ieee.std_logic_1164.all; 

entity conway is 
generic(
        n: natural :=32;
        buff_num : natural := 3
        );
  port(
		clk : in std_logic; --
        EN : in std_logic_vector(buff_num-1 downto 0);
        D  : in std_logic_vector(n-1 downto 0);
        SO  : out std_logic_vector(n-1 downto 0)
		); 
end conway; 

architecture archi of conway is 

--||COMPONENT||--
COMPONENT conway_line_buffer_block is port(
    clk, EN : in std_logic; --
    D   : in std_logic_vector(n-1 downto 0);
    SO  : out std_logic_vector(n-1 downto 0)
    ); 
end COMPONENT conway_line_buffer_block; 


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
    
            sum:	        out std_logic
    );
    end component conway_ADDER;
    


--||SIGNALS||--
signal LineToMux: std_logic_vector(buff_num*n-1 downto 0);
signal MuxToCores: std_logic_vector(buff_num*n-1 downto 0);

--||ASSMEBLY||--
  
  begin 
      G0: FOR i IN buff_num-1 downto 0 GENERATE
	    Buff0 : conway_line_buffer_block Port Map(	
				EN	=> EN(i),
				D	=> D(n-1 downto 0),
                clk => clk,
                SO => LineToMux(i*n+n-1 downto i*n)
		);		
   end generate G0;	
    -- Fix this with proper code

    process(EN)
    begin
        if EN = "010" then 
            MuxToCores(n-1      downto 0)          <= LineToMux(2*n-1 downto n);
            MuxToCores(2*n-1    downto n)          <= LineToMux(3*n-1   downto 2*n);
            MuxToCores(3*n-1    downto 2*n)        <= LineToMux(n-1     downto 0);
        elsif EN = "100" then 
            MuxToCores(n-1      downto 0)          <= LineToMux(3*n-1 downto 2*n);
            MuxToCores(2*n-1    downto n)          <= LineToMux(n-1     downto 0);
            MuxToCores(3*n-1    downto 2*n)        <= LineToMux(2*n-1   downto n);
        elsif EN = "001" then 
            MuxToCores(n-1      downto 0)          <= LineToMux(n-1 downto 0);
            MuxToCores(2*n-1    downto n)          <= LineToMux(2*n-1     downto n);
            MuxToCores(3*n-1    downto 2*n)        <= LineToMux(3*n-1   downto 2*n);
        end if;
    end process;

   G1: FOR i IN n-2 downto 1 GENERATE
        core0 : conway_ADDER Port Map(
            i00 =>  MuxToCores(i-1),   --[row offset + column offset + kernel offset]
            i01 =>  MuxToCores(i),
            i02 =>  MuxToCores(i+1),

            i10 =>  MuxToCores(n+i-1),
            i11 =>  MuxToCores(n+i),
            i12 =>  MuxToCores(n+i+1),

            i20 =>  MuxToCores(2*n+i-1),
            i21 =>  MuxToCores(2*n+i),
            i22 =>  MuxToCores(2*n+i+1),

            sum => SO(i)
   );
   end generate G1;
   SO(n-1) <= '0';
   SO(0) <= '0';
end archi; 