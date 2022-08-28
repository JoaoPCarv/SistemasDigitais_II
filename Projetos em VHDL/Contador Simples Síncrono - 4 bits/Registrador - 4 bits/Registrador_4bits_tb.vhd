-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

entity registrador_4bits_tb is
       -- Empty --
end registrador_4bits_tb;

architecture registrador_4bits_testbench of registrador_4bits_tb is

component registrador_4bits is 
       port(
	   clock, reset, enable: in bit;
	   entrada: in bit_vector(3 downto 0);
	   saida: out bit_vector(3 downto 0)
	   );
end component;

signal clock_s, reset_s, enable_s: bit;
signal entrada_s, saida_s: bit_vector(3 downto 0);

  begin
  
  DUT: registrador_4bits port map(clock_s, reset_s, enable_s, entrada_s, saida_s);
  
  teste: process
    begin
	
	reset_s <= '1';
    wait for 0.1 ns;
	
	assert (saida_s = "0000") report "Erro de reset" severity error;
	
	wait for 0.1 ns;
	
	clock_s <= '1';
	reset_s <= '0';
	enable_s <= '0';
	entrada_s <= "1001";
	wait for 0.1 ns;
	
	assert (saida_s = "0000") report "Erro de enable" severity error;
	
	wait for 0.1 ns;
	
	clock_s <= '0';
	reset_s <= '0';
	enable_s <= '1';
	entrada_s <= "1001";
	wait for 0.1 ns;
	
	assert (saida_s = "0000") report "Erro de clock" severity error;
	
	wait for 0.1 ns;
	
	clock_s <= '1';
	reset_s <= '0';
	enable_s <= '1';
	entrada_s <= "1001";
	wait for 0.1 ns;
	
	assert (saida_s = "1001") report "Erro de load" severity error;
	
	-- Limpando as entradas de estímulo --
	clock_s <= '0';
	reset_s <= '0';
	enable_s <= '0';
	entrada_s <= "0000";
	
	assert (false) report "Fim do Teste" severity note;
    wait;

  end process;

end registrador_4bits_testbench;