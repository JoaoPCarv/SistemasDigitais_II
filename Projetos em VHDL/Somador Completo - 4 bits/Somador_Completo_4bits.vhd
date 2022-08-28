-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

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

-----------------------------------------------------------------------------

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

