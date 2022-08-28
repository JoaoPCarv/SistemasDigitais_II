-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

entity somador_completo_1bit_tb is
       -- Empty --
end somador_completo_1bit_tb;

architecture somador_completo_1bit_testbench of somador_completo_1bit_tb is

component somador_completo_1bit is
       port(
	   add1: in bit;
	   add2: in bit;
	   carry_in: in bit;
	   result: out bit;
	   carry_out: out bit
	   );
end component;

signal add1_s, add2_s, carry_in_s, result_s, carry_out_s: bit; 

  begin
  DUT: somador_completo_1bit port map(add1_s, add2_s, carry_in_s, result_s, carry_out_s);
  
  -- Terna: (add1_s, add2_s, carry_in_s) --
  teste: process
    begin
	
	-- (0 + 0 + 0 = 0) --
	add1_s <= '0';
	add2_s <= '0';
	carry_in_s <= '0';
	wait for 1 ns;
	assert (result_s = '0') report "Falha (0,0,0) - Result" severity error;
	assert (carry_out_s = '0') report "Falha (0,0,0) - Carry-out" severity error;
	
	wait for 1 ns;
	
	-- (0 + 0 + 1 = 1) --
	add1_s <= '0';
	add2_s <= '0';
	carry_in_s <= '1';
	wait for 1 ns;
	assert (result_s = '1') report "Falha (0,0,1) - Result" severity error;
	assert (carry_out_s = '0') report "Falha (0,0,1) - Carry-out" severity error;
	
	wait for 1 ns;

    -- (1 + 0 + 0 = 1) --
	add1_s <= '1';
	add2_s <= '0';
	carry_in_s <= '0';
	wait for 1 ns;
	assert (result_s = '1') report "Falha (1,0,0) - Result" severity error;
	assert (carry_out_s = '0') report "Falha (1,0,0) - Carry-out" severity error;
	
	wait for 1 ns;

    -- (0 + 1 + 0 = 1) --
	add1_s <= '0';
	add2_s <= '1';
	carry_in_s <= '0';
	wait for 1 ns;
	assert (result_s = '1') report "Falha (0,1,0) - Result" severity error;
	assert (carry_out_s = '0') report "Falha (0,1,0) - Carry-out" severity error;
	
	wait for 1 ns;
    
	-- (1 + 1 + 0 = 2) --
	add1_s <= '1';
	add2_s <= '1';
	carry_in_s <= '0';
	wait for 1 ns;
	assert (result_s = '0') report "Falha (1,1,0) - Result" severity error;
	assert (carry_out_s = '1') report "Falha (1,1,0) - Carry-out" severity error;
	
	wait for 1 ns;

    -- (1 + 0 + 1 = 2) --
	add1_s <= '1';
	add2_s <= '0';
	carry_in_s <= '1';
	wait for 1 ns;
	assert (result_s = '0') report "Falha (1,0,1) - Result" severity error;
	assert (carry_out_s = '1') report "Falha (1,0,1) - Carry-out" severity error;
	
	wait for 1 ns;

    -- (0 + 1 + 1 = 2) --
	add1_s <= '0';
	add2_s <= '1';
	carry_in_s <= '1';
	wait for 1 ns;
	assert (result_s = '0') report "Falha (0,1,1) - Result" severity error;
	assert (carry_out_s = '1') report "Falha (0,1,1) - Carry-out" severity error;
	
	-- (1 + 1 + 1 = 3) --
	add1_s <= '1';
	add2_s <= '1';
	carry_in_s <= '1';
	wait for 1 ns;
	assert (result_s = '1') report "Falha (1,1,1) - Result" severity error;
	assert (carry_out_s = '1') report "Falha (1,1,1) - Carry-out" severity error;
	
	wait for 1 ns;
	
	-- Limpando os sinais de estímulo --
	add1_s <= '0';
	add2_s <= '0';
	carry_in_s <= '0';
	assert (false) report "Fim do Teste" severity note;
	wait;
	
  end process;	

end somador_completo_1bit_testbench;

