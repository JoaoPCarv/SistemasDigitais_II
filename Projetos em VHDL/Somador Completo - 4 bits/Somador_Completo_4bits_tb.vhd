-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

entity somador_completo_4bits_tb is
       -- Empty --
end somador_completo_4bits_tb;

architecture somador_completo_4bits_testbench of somador_completo_4bits_tb is

component somador_completo_4bits is
       port(
	   add1: in bit_vector(3 downto 0);
	   add2: in bit_vector(3 downto 0);
	   carry_in: in bit;
	   result: out bit_vector(3 downto 0);
	   carry_out: out bit
	   );
end component;

signal add1_s, add2_s, result_s: bit_vector(3 downto 0);
signal carry_in_s, carry_out_s: bit;

  begin
  DUT: somador_completo_4bits port map(add1_s, add2_s, carry_in_s, result_s, carry_out_s);
  
  -- Apenas alguns testes... --
  teste: process
    begin
	
	-- (0 + 0 + 0 = 0) --
	add1_s <= "0000";
	add2_s <= "0000";
	carry_in_s <= '0';
	wait for 1 ns;
	assert (result_s = "0000") report "Falha ((0000),(0000),0) - Result" severity error;
	assert (carry_out_s = '0') report "Falha ((0000),(0000),0) - Carry-out" severity error;
	
	wait for 1 ns;
	
	-- (1 + 0 + 1 = 2) --
	add1_s <= "0001";
	add2_s <= "0000";
	carry_in_s <= '1';
	wait for 1 ns;
	assert (result_s = "0010") report "Falha ((0001),(0000),1) - Result" severity error;
	assert (carry_out_s = '0') report "Falha ((0001),(0000),1) - Carry-out" severity error;
	
	wait for 1 ns;
	
	-- (7 + 9 + 0 = 16) --
	add1_s <= "0111";
	add2_s <= "1001";
	carry_in_s <= '0';
	wait for 1 ns;
	assert (result_s = "0000") report "Falha ((0111),(1001),0) - Result" severity error;
	assert (carry_out_s = '1') report "Falha ((0111),(1001),0) - Carry-out" severity error;
	
	-- (7 + 9 + 1 = 17) --
	add1_s <= "0111";
	add2_s <= "1001";
	carry_in_s <= '1';
	wait for 1 ns;
	assert (result_s = "0001") report "Falha ((0111),(1001),1) - Result" severity error;
	assert (carry_out_s = '1') report "Falha ((0111),(1001),1) - Carry-out" severity error;
	
	-- (15 + 1 + 0 = 16) --
	add1_s <= "1111";
	add2_s <= "0001";
	carry_in_s <= '0';
	wait for 1 ns;
	assert (result_s = "0000") report "Falha ((1111),(0001),0) - Result" severity error;
	assert (carry_out_s = '1') report "Falha ((1111),(0001),0) - Carry-out" severity error;
	
	wait for 1 ns;
	
	-- (15 + 1 + 1 = 17) --
	add1_s <= "1111";
	add2_s <= "0001";
	carry_in_s <= '1';
	wait for 1 ns;
	assert (result_s = "0001") report "Falha ((1111),(0001),1) - Result" severity error;
	assert (carry_out_s = '1') report "Falha ((1111),(0001),1) - Carry-out" severity error;
	
	wait for 1 ns;
	
	-- (15 + 15 + 0 = 30) --
	add1_s <= "1111";
	add2_s <= "1111";
	carry_in_s <= '0';
	wait for 1 ns;
	assert (result_s = "1110") report "Falha ((1111),(1111),0) - Result" severity error;
	assert (carry_out_s = '1') report "Falha ((1111),(1111),0) - Carry-out" severity error;
	
	wait for 1 ns;
	
	-- (15 + 15 + 1 = 31) --
	add1_s <= "1111";
	add2_s <= "1111";
	carry_in_s <= '1';
	wait for 1 ns;
	assert (result_s = "1111") report "Falha ((1111),(1111),1) - Result" severity error;
	assert (carry_out_s = '1') report "Falha ((1111),(1111),1) - Carry-out" severity error;
	
	wait for 1 ns;

	-- Limpando os sinais de estímulo --
	add1_s <= "0000";
	add2_s <= "0000";
	carry_in_s <= '0';
	assert (false) report "Fim do Teste" severity note;
	wait;
	
  end process;


end somador_completo_4bits_testbench;