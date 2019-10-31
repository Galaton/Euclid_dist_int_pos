library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Teste_dist_euclid is

end entity;

architecture rtl of Teste_dist_euclid is

signal 	clks, resets: std_logic := '0';
signal sg_x1,sg_x2,sg_y1,sg_y2 : std_logic_vector(7 downto 0);
signal sg_result : std_logic_vector(15 downto 0);

component Dist_eucl is

	generic(	DATA_WIDTH : natural := 8	);
	port(
  clk		: in std_logic;
  reset	: in std_logic;
  x1 		: in std_logic_vector(DATA_WIDTH -1 downto 0);
  x2 		: in std_logic_vector(DATA_WIDTH -1 downto 0);
  y1 		: in std_logic_vector(DATA_WIDTH -1 downto 0);
  y2 		: in std_logic_vector(DATA_WIDTH -1 downto 0);
  result : out std_logic_vector((2*DATA_WIDTH) -1 downto 0)
	);

end component;

begin

	clks <= not clks after 10 ns;

DE : Dist_eucl
  port map (		clk     =>clks,
            		reset	=>resets,
            		x1      =>sg_x1,
            		x2      =>sg_x2,
            		y1      =>sg_y1,
            		y2      =>sg_y2,
            		result  =>sg_result
            );


process
begin
  -- expected 2
	sg_x1 <= "00000001";
  sg_x2 <= "00000011";
  sg_y1 <= "00000001";
  sg_y2 <= "00000011";

  wait for 11 ns; -- expected 114
  sg_x1 <= "10000000";
  sg_x2 <= "00100000";
  sg_y1 <= "01000000";
  sg_y2 <= "00000010";

  wait for 300 ns; -- test reset
  resets <= '1';


end process;


end rtl;
