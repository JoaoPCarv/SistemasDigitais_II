-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

-- Testbench do Somador Completo de 4 bits (com Enable) --

entity somador_completo_4bits_enable_tb is
    -- Empty --
end somador_completo_4bits_enable_tb;

architecture somador_completo_4bits_enable_testbench of somador_completo_4bits_enable_tb is

-- Componente a ser testado --
component somador_completo_4bits_enable is
       port(
	   enable: in bit;
	   add1: in bit_vector(3 downto 0);
	   add2: in bit_vector(3 downto 0);
	   carry_in: in bit;
	   result: out bit_vector(3 downto 0);
	   carry_out: out bit
	   );
end component;

-- Sinais de Estímulo --
signal enable_s, carry_in_s, carry_out_s: bit;
signal add1_s, add2_s, result_s: bit_vector(3 downto 0);

  begin
  -- Device under Test --
  DUT: somador_completo_4bits_enable port map(enable_s, add1_s, add2_s, carry_in_s, result_s, carry_out_s);
  
  teste: process
  begin
  
  add1_s <= "0000";
  add2_s <= "0000";
  carry_in_s <= '0';
  enable_s <= '1';
  
  wait for 1 ns; 
  
  assert (result_s = "0000") report "Erro (0 + 0 + 0 = 0) - Result" severity error;
  assert (carry_out_s = '0') report "Erro (0 + 0 + 0 = 0) - Carry Out" severity error;

  wait for 1 ns; 
  
  add1_s <= "1100";
  add2_s <= "0010";
  carry_in_s <= '0';
  enable_s <= '0';
  
  wait for 1 ns; 
  
  assert (result_s = "0000") report "Erro de Enable" severity error;
  
  wait for 1 ns; 
  
  enable_s <= '1';
  
  wait for 1 ns; 

  assert (result_s = "1110") report "Erro (12 + 2 + 0 = 14) - Result" severity error;
  assert (carry_out_s = '0') report "Erro (12 + 2 + 0 = 14) - Carry Out" severity error;

  wait for 1 ns; 
  
  add1_s <= "0101";
  add2_s <= "1010";
  carry_in_s <= '1';
  enable_s <= '0';
  
  wait for 1 ns; 

  assert (result_s = "1110") report "Erro de Enable" severity error;
  
  wait for 1 ns; 
  
  enable_s <= '1';
  
  wait for 1 ns; 
  
  assert (result_s = "0000") report "Erro (10 + 5 + 1 = 16) - Result" severity error;
  assert (carry_out_s = '1') report "Erro (10 + 5 + 1 = 16) - Carry Out" severity error;
  
  wait for 1 ns; 
  
  add1_s <= "1000";
  add2_s <= "0001";
  carry_in_s <= '1';
  enable_s <= '0';
  
  wait for 1 ns; 

  assert (result_s = "0000") report "Erro de Enable" severity error;
  
  wait for 1 ns; 
  
  enable_s <= '1';
  
  wait for 1 ns; 
  
  assert (result_s = "1010") report "Erro (8 + 1 + 1 = 10) - Result" severity error;
  assert (carry_out_s = '0') report "Erro (8 + 1 + 1 = 10) - Carry Out" severity error;
  
  wait for 1 ns; 
  
  add1_s <= "0110";
  add2_s <= "1001";
  carry_in_s <= '0';
  enable_s <= '0';
  
  wait for 1 ns; 

  assert (result_s = "1010") report "Erro de Enable" severity error;
  
  wait for 1 ns; 
  
  enable_s <= '1';
  
  wait for 1 ns; 
  
  assert (result_s = "1111") report "Erro (6 + 9 + 0 = 15) - Result" severity error;
  assert (carry_out_s = '0') report "Erro (6 + 9 + 0 = 15) - Carry Out" severity error;
  
  wait for 1 ns; 

  -- Limpando os sinais de estímulo --
  add1_s <= "0000";
  add2_s <= "0000";
  carry_in_s <= '0';
  enable_s <= '0';
  
  wait for 1 ns; 

  assert (false) report "Fim do Teste." severity note;
  wait;

  end process;


end somador_completo_4bits_enable_testbench;

