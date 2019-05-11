library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

 entity SevenSegment is
 port (
     I : in std_logic_vector(7 downto 0);
     O : out std_logic_vector(6 downto 0)
   );
 end SevenSegment;

 architecture Behavioral of SevenSegment is

 begin
  process (I)
  begin
   case I is
   when "11111111" => O <= "0000001";  -- '0'
   when "11111110" => O <= "1001111";  -- '1'
   when "11111101" => O <= "0010010";  -- '2'
   when "11111100" => O <= "0000110";  -- '3'
   when "11111011" => O <= "1001100";  -- '4' 
   when "11111010" => O <= "0100100";  -- '5'
   when "11111001" => O <= "0100000";  -- '6'
   when "11111000" => O <= "0001111";  -- '7'
   when others  => O <= "1111111";  -- 'X'
    
   end case;
  end process;
 end Behavioral;