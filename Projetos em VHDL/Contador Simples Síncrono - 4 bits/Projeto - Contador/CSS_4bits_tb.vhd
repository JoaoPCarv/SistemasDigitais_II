-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

-- Testbench do Contador Simples Síncrono - 4 bits --

entity CSS_4bits_tb is 
    -- Empty --
end CSS_4bits_tb;

architecture CSS_4bits_testbench of CSS_4bits_tb is

-- Componente a ser testado --
component CSS_4bits is 
       port(
	   clock: in bit;
	   reset: in bit;
	   saida: out bit_vector(3 downto 0)
	   );
end component;

-- Sinais de Estímulo --
signal clock_s, reset_s: bit;
signal saida_s: bit_vector(3 downto 0);

  begin
  -- Device under Test --
  DUT: CSS_4bits port map(clock_s, reset_s, saida_s);
  
  -- Simulação feita com sinal de clock de 250 MHz | ciclo de 4 ns --
  teste: process
  begin
  
  reset_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0000") report "Erro - Reset" severity error;
  
  wait for 1 ns;
  
  -- Início do sinal de clock -- 
  -- 0 -> 1 --
  clock_s <= '1';
  reset_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0000") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0000") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0000") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0000") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0001") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0001") report "Erro - Clock" severity error;
  
  wait for 1 ns;

  -- 1 -> 2 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0001") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0001") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0010") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0010") report "Erro - Clock" severity error;
  
  wait for 1 ns;

  -- 2 -> 3 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0010") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0010") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0011") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0011") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 3 -> 4 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0011") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0011") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0100") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0100") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 4 -> 5 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0100") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0100") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0101") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0101") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 5 -> 6 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0101") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0101") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0110") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0110") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 6 -> 7 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0110") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0110") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0111") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0111") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 7 -> 8 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0111") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0111") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1000") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1000") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 8 -> 9 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1000") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1000") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1001") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1001") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 9 -> 10 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1001") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1001") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1010") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1010") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 10 -> 11 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1010") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1010") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1011") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1011") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 11 -> 12 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1011") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1011") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1100") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1100") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 12 -> 13 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1100") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1100") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1101") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1101") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 13 -> 14 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1101") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1101") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1110") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1110") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 14 -> 15 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1110") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1110") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1111") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1111") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  -- 15 -> 16|0 --
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "1111") report "Erro - ASM" severity error;
  
  wait for 1 ns;
  
  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "1111") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  clock_s <= '1';
  
  wait for 1 ns;
  
  assert (saida_s = "0000") report "Erro - ASM" severity error;
  
  wait for 1 ns;

  clock_s <= '0';
  
  wait for 1 ns;
  
  assert (saida_s = "0000") report "Erro - Clock" severity error;
  
  wait for 1 ns;
  
  assert (false) report "O contador completou o ciclo de contagem." severity note;
  
  wait for 1 ns;
  
  assert (false) report "Fim do Teste." severity note;
  wait;
  end process;
  

end CSS_4bits_testbench;



