-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

entity projeto1_tb is
       -- Empty --
end projeto1_tb;

architecture projeto1_testbench of projeto1_tb is

component purrinha is
       port (
       num4, num3, num2, num1: in bit_vector(1 downto 0);
       guess4, guess3, guess2, guess1: in bit_vector(3 downto 0);
       display: out bit_vector(6 downto 0)
	   );
end component;

signal num4_s, num3_s, num2_s, num1_s: bit_vector(1 downto 0);
signal guess4_s, guess3_s, guess2_s, guess1_s: bit_vector(3 downto 0);
signal display_s: bit_vector(6 downto 0);

  begin
  DUT: purrinha port map(num4_s, num3_s, num2_s, num1_s, guess4_s, guess3_s, guess2_s, guess1_s, display_s);
  
  -- Apenas alguns testes... --
  teste: process
  begin
  
  num4_s <= "11";
  num3_s <= "10";
  num2_s <= "01";
  num1_s <= "00";
  
  guess4_s <= "1100";
  guess3_s <= "1010";
  guess2_s <= "1000";
  guess1_s <= "0110";
  
  wait for 1 ns;
  
  assert (display_s = "0110000") report "Falha..." severity error;
  
  wait for 1 ns;
  
  num4_s <= "11";
  num3_s <= "00";
  num2_s <= "00";
  num1_s <= "00";

  guess4_s <= "0110";
  guess3_s <= "0000";
  guess2_s <= "1101";
  guess1_s <= "0100";

  wait for 1 ns;

  assert (display_s = "0000001") report "Falha..." severity error;
  
  wait for 1 ns;
  
  num4_s <= "10";
  num3_s <= "10";
  num2_s <= "01";
  num1_s <= "11";

  guess4_s <= "0101";
  guess3_s <= "1000";
  guess2_s <= "1001";
  guess1_s <= "1110";

  wait for 1 ns;

  assert (display_s = "1111001") report "Falha..." severity error;
  
  wait for 1 ns;
  
  num4_s <= "01";
  num3_s <= "00";
  num2_s <= "01";
  num1_s <= "01";

  guess4_s <= "1111";
  guess3_s <= "0000";
  guess2_s <= "0011";
  guess1_s <= "0011";

  wait for 1 ns;

  assert (display_s = "1001111") report "Falha..." severity error;
  
  wait for 1 ns;
  
  -- Limpando as entradas --
  
  num4_s <= "00";
  num3_s <= "00";
  num2_s <= "00";
  num1_s <= "00";

  guess4_s <= "0000";
  guess3_s <= "0000";
  guess2_s <= "0000";
  guess1_s <= "0000";

  assert (false) report "Fim do Teste" severity note;
  wait;
  
  end process;

end projeto1_testbench;