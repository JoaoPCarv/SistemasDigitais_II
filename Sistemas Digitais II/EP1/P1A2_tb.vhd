-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

-- Testbench do P1A2 --

entity P1A2_tb is
    -- Empty --
end P1A2_tb;

architecture P1A2_testbench of P1A2_tb is

component rom_arquivo is
       port(
	   addr: in  bit_vector(4 downto 0);
	   data: out bit_vector(7 downto 0)
	   );
end component;

signal addr_s: bit_vector(4 downto 0);
signal data_s: bit_vector(7 downto 0);

  begin
  
  DUT: rom_arquivo port map(addr_s, data_s);
  
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

end P1A2_testbench;

