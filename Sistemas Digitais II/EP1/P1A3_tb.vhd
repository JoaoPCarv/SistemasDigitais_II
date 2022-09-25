-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

-- Testbench do P1A3 --

entity P1A3_tb is
    -- Empty --
end P1A3_tb;

architecture P1A3_testbench of P1A3_tb is

component rom_arquivo_generica is
       generic(
	   addressSize : natural := 5;
	   wordSize    : natural := 8;
	   datFileName : string  := "conteudo_rom_ativ_02_carga.dat"
	   );
	   port(
	   addr: in  bit_vector(addressSize - 1 downto 0);
	   data: out bit_vector(wordSize    - 1 downto 0)
	   );
end component;

constant addressSize_s: integer := 5;
constant wordSize_s   : integer := 8;

signal addr_s: bit_vector(addressSize_s - 1 downto 0);
signal data_s: bit_vector(wordSize_s - 1    downto 0);

  begin
  
  DUT: rom_arquivo_generica
  generic map(addressSize_s, wordSize_s)
  port map(addr_s, data_s);
  
  teste: process
  
    begin

    addr_s <= "00000";
    wait for 1 ns;
    assert (data_s = "00000000") report "Erro..." severity error;
	
	wait for 1 ns;
	
	addr_s <= "00111";
    wait for 1 ns;
    assert (data_s = "11111111") report "Erro..." severity error;
    
    wait for 1 ns;
	
	addr_s <= "10111";
    wait for 1 ns;
    assert (data_s = "01011101") report "Erro..." severity error;
    
    wait for 1 ns;

    assert (false) report "Fim do teste." severity note;
	wait;

	
  end process;

end P1A3_testbench;

