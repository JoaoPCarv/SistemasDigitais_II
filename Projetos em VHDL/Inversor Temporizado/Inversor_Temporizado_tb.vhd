-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

entity inversor_temporizado_tb is
       -- Empty --
end inversor_temporizado_tb;

architecture inversor_temporizado_testbench of inversor_temporizado_tb is

component inversor_temporizado is
       port(
	   entrada: in bit;
	   saida: out bit
	   );
end component;

signal entrada_s, saida_s: bit;

  begin
  
  DUT: inversor_temporizado port map(entrada_s, saida_s);
  
  teste: process
    begin
	
	entrada_s <= '0';
	
	assert (saida_s = '0') report "Erro de inicializacao" severity error;
	
	wait for 5 ns;
	assert (saida_s = '1') report "Erro de inicializacao" severity error;
	
    entrada_s <= '1';
	wait for 5 ns;
	assert (saida_s = '0') report "Erro de inversao" severity error;
	
    entrada_s <= '0';
	wait for 5 ns;
	assert (saida_s = '1') report "Erro de inversao" severity error;
	
    entrada_s <= '1';
	wait for 5 ns;
	assert (saida_s = '0') report "Erro de inversao" severity error;
	
    entrada_s <= '0';
	wait for 5 ns;
	assert (saida_s = '1') report "Erro de inversao" severity error;
	
	assert (false) report "Fim do Teste" severity note;
	wait;
	
  end process;

end inversor_temporizado_testbench;