-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

entity comparador_4bits_tb is
       -- Empty --
end comparador_4bits_tb;

architecture comparador_4bits_testbench of comparador_4bits_tb is

component comparador_4bits is
       port(
	   entrada1: in bit_vector(3 downto 0);
	   entrada2: in bit_vector(3 downto 0);
	   saida: out bit
);
end component;

signal entrada1_s, entrada2_s: bit_vector(3 downto 0);
signal saida_s: bit;

  begin
  DUT: comparador_4bits port map(entrada1_s, entrada2_s, saida_s);

  -- Apenas alguns testes... --
  teste: process
  begin
  
  entrada1_s <= "0000";
  entrada2_s <= "0000";
  wait for 1 ns;
  assert (saida_s = '1') report "Falha ((0000), (0000))" severity error;

  wait for 1 ns;
  
  entrada1_s <= "0000";
  entrada2_s <= "0001";
  wait for 1 ns;
  assert (saida_s = '0') report "Falha ((0000), (0001))" severity error;
  
  wait for 1 ns;
  
  entrada1_s <= "0001";
  entrada2_s <= "0010";
  wait for 1 ns;
  assert (saida_s = '0') report "Falha ((0001), (0010))" severity error;
  
  wait for 1 ns;
  
  entrada1_s <= "0110";
  entrada2_s <= "0110";
  wait for 1 ns;
  assert (saida_s = '1') report "Falha ((0110), (0110))" severity error;
  
  wait for 1 ns;
  
  entrada1_s <= "1010";
  entrada2_s <= "0011";
  wait for 1 ns;
  assert (saida_s = '0') report "Falha ((1010), (0011))" severity error;
  
  wait for 1 ns;
  
  entrada1_s <= "1100";
  entrada2_s <= "0011";
  wait for 1 ns;
  assert (saida_s = '0') report "Falha ((1100), (0011))" severity error;
  
  wait for 1 ns;
  
  entrada1_s <= "1001";
  entrada2_s <= "1001";
  wait for 1 ns;
  assert (saida_s = '1') report "Falha ((1001), (1001))" severity error;
  
  wait for 1 ns;
  
  entrada1_s <= "1101";
  entrada2_s <= "1011";
  wait for 1 ns;
  assert (saida_s = '0') report "Falha ((1101), (1011))" severity error;
  
  wait for 1 ns;
  
  entrada1_s <= "1101";
  entrada2_s <= "1101";
  wait for 1 ns;
  assert (saida_s = '1') report "Falha ((1101), (1101))" severity error;
  
  wait for 1 ns;
  
  entrada1_s <= "0101";
  entrada2_s <= "0101";
  wait for 1 ns;
  assert (saida_s = '1') report "Falha ((0101), (0101))" severity error;
  
  wait for 1 ns;
  
  entrada1_s <= "1010";
  entrada2_s <= "1010";
  wait for 1 ns;
  assert (saida_s = '1') report "Falha ((1010), (1010))" severity error;
  
  wait for 1 ns;
  
  entrada1_s <= "1000";
  entrada2_s <= "1000";
  wait for 1 ns;
  assert (saida_s = '1') report "Falha ((1000), (1000))" severity error;
  
  wait for 1 ns;
  
  entrada1_s <= "1100";
  entrada2_s <= "1000";
  wait for 1 ns;
  assert (saida_s = '0') report "Falha ((1100), (1000))" severity error;
  
   wait for 1 ns;
  
  entrada1_s <= "1111";
  entrada2_s <= "1111";
  wait for 1 ns;
  assert (saida_s = '1') report "Falha ((1111), (1111))" severity error;
  
  -- Limpando os sinais de estímulo --
  entrada1_s <= "0000";
  entrada2_s <= "0000";
  assert (false) report "Fim do Teste" severity note;
  wait;
 
  end process;

end comparador_4bits_testbench;