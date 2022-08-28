-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --
--Projeto 1

--Lista de Componentes: --

-- Somador completo de 1 bit --
entity somador_completo_1bit is
       port(
	   add1: in bit;
	   add2: in bit;
	   carry_in: in bit;
	   result: out bit;
	   carry_out: out bit
	   );
end somador_completo_1bit;

architecture arch_somador_1bit of somador_completo_1bit is
  begin 
  
  result <= (add1) xor (add2) xor (carry_in);
  carry_out <= (add1 and add2) or (add1 and carry_in) or (add2 and carry_in);

end arch_somador_1bit;

----------------------

-- Somador completo de 4 bits --
entity somador_completo_4bits is
       port(
	   add1: in bit_vector(3 downto 0);
	   add2: in bit_vector(3 downto 0);
	   carry_in: in bit;
	   result: out bit_vector(3 downto 0);
	   carry_out: out bit
	   );
end somador_completo_4bits;

architecture arch_somador_4bits of somador_completo_4bits is

component somador_completo_1bit is
       port(
	   add1: in bit;
	   add2: in bit;
	   carry_in: in bit;
	   result: out bit;
	   carry_out: out bit
	   );
end component;

signal c_out0_s, c_out1_s, c_out2_s: bit;

  begin
  soma0: somador_completo_1bit port map(add1(0), add2(0), carry_in, result(0), c_out0_s);
  soma1: somador_completo_1bit port map(add1(1), add2(1), c_out0_s, result(1), c_out1_s);
  soma2: somador_completo_1bit port map(add1(2), add2(2), c_out1_s, result(2), c_out2_s);
  soma3: somador_completo_1bit port map(add1(3), add2(3), c_out2_s, result(3), carry_out);

end arch_somador_4bits;

-----------------------

-- Comparador de 4 bits --
entity comparador_4bits is
       port(
	   entrada1: in bit_vector(3 downto 0);
	   entrada2: in bit_vector(3 downto 0);
	   saida: out bit
);
end comparador_4bits;

architecture arch_comparador_4bits of comparador_4bits is

signal comp0, comp1, comp2, comp3: bit;
  begin
  
  comp0 <= entrada1(0) xnor entrada2(0);
  comp1 <= entrada1(1) xnor entrada2(1);
  comp2 <= entrada1(2) xnor entrada2(2);
  comp3 <= entrada1(3) xnor entrada2(3);
  
  saida <= (comp0) and (comp1) and (comp2) and (comp3);
  
end arch_comparador_4bits;

--------------------------

-- Entidade fornecida --

entity purrinha is
       port (
       num4, num3, num2, num1: in bit_vector(1 downto 0);
       guess4, guess3, guess2, guess1: in bit_vector(3 downto 0);
       display: out bit_vector(6 downto 0)
	   );
end purrinha;

architecture arch_projeto1 of purrinha is

-- Instanciação dos componentes a serem usados --

component somador_completo_4bits is
       port(
	   add1: in bit_vector(3 downto 0);
	   add2: in bit_vector(3 downto 0);
	   carry_in: in bit;
	   result: out bit_vector(3 downto 0);
	   carry_out: out bit
	   );
end component;

component comparador_4bits is
       port(
	   entrada1: in bit_vector(3 downto 0);
	   entrada2: in bit_vector(3 downto 0);
	   saida: out bit
);
end component;

signal c_out0_s, c_out1_s, c_out2_s: bit;
signal rst0_s, rst1_s, rst_total_s: bit_vector(3 downto 0);
signal num4_s, num3_s, num2_s, num1_s: bit_vector(3 downto 0);
signal comp1_s, comp2_s, comp3_s, comp4_s: bit;
signal vencedor: bit_vector(3 downto 0);

  begin
  
  num4_s <= "00" & num4;
  num3_s <= "00" & num3;
  num2_s <= "00" & num2;
  num1_s <= "00" & num1;
  
  soma0: somador_completo_4bits port map(num1_s, num2_s, '0', rst0_s, c_out0_s);
  soma1: somador_completo_4bits port map(rst0_s, num3_s, c_out0_s, rst1_s, c_out1_s);
  soma2: somador_completo_4bits port map(rst1_s, num4_s, c_out1_s, rst_total_s, c_out2_s);
  
  comparador1: comparador_4bits port map(guess1, rst_total_s, comp1_s);
  comparador2: comparador_4bits port map(guess2, rst_total_s, comp2_s);
  comparador3: comparador_4bits port map(guess3, rst_total_s, comp3_s);
  comparador4: comparador_4bits port map(guess4, rst_total_s, comp4_s);
  
  vencedor <= comp1_s & comp2_s & comp3_s & comp4_s;
  
  with (vencedor) select
  display <= "0000001" when "0000",
             "0110000" when "1000",
             "1101101" when "0100",
             "1111001" when "0010",
             "0110011" when "0001",
             "1001111" when others;			 

end arch_projeto1;





