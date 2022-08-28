-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

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