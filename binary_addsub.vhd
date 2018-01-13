library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity binary_addsub is
	port(
		input_num 				 : in std_logic_vector(7 downto 0);
		key0, key1, subtract  : in std_logic;
		sum       				 : out std_logic_vector(7 downto 0);
		carry     				 : out std_logic
	);
end binary_addsub;

architecture a of binary_addsub is
	signal sum_temp 			: std_logic_vector(8 downto 0);
	signal a, b_temp, b, c  : std_logic_vector(7 downto 0);
	signal carry_in 			: std_logic;
	
begin
	process(input_num, key1, key0, subtract, sum_temp, carry_in)
	begin
		if  (key0 = '1') then 
			a <= input_num;
		elsif (key1 = '1') then 
			b <= input_num;
		end if;
		if (subtract = '1') then
		c <= "11111111";
		else 
		c <= "00000000";
		end if; 
		
	b <= ((c) XOR (b_temp)); -- 1's complement 
	carry_in <= subtract;    -- 2's complement (used later, only if subtracting)
		
		sum_temp <= ('0' & a) + ('0' & b) + ("00000000" & carry_in);
		sum <= sum_temp(8 downto 0);
	end process;
end a;