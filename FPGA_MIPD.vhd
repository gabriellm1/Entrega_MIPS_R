library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Baseado no apendice C (Register Files) do COD (Patterson & Hennessy).

entity FPGA_MIPD is
	Generic(DATA_SIZE : natural := 1);
    port
    (
		CLOCK : in std_logic;
		SW : in std_logic_vector(2 downto 0);
		KEY : in std_logic_vector(0 downto 0);
		LEDG : out std_logic_vector(0 downto 0);
		HEX0, HEX1 : OUT STD_LOGIC_VECTOR(6 downto 0)
    );
end entity;

architecture comportamento of FPGA_MIPD is

signal sig_key_clock : std_logic;
signal saida_ula_7 : std_logic_vector(4 downto 0);

begin
	



	key_clock: entity work.key
		Port Map(key_in=>KEY(0),enable=>'1',led_in=>LEDG(0),key_out=>sig_key_clock);

	conv7seg0: entity work.conversor7seg
		Port Map(dadoHex=>saida_ula_7(3 downto 0),saida7seg=>HEX0);

	conv7seg1: entity work.conversor7seg
		Port Map(dadoHex=>"000" & saida_ula_7(4),saida7seg=>HEX1);
	
	mips_r: entity work.MIPS
		Generic Map(addrWidth=>5,regAddrWidth => 5,dataWidth=>5)
		Port Map(clk=>sig_key_clock,reset=>SW(0),escreveC=>SW(1),ulaOut=>saida_ula_7);
		
end architecture;
               