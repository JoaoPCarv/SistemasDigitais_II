-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

-- Inversor temporizado de 100 MHz (ciclo de 10 ns) --
-- Aplicabilidade como clock --
entity inversor_temporizado is
       port(
	   entrada: in bit;
	   saida: out bit
	   );
end inversor_temporizado;

architecture arch_inversor_temporizado of inversor_temporizado is

begin
  inversor: process(entrada)
    begin
      saida <= not entrada after 5 ns;
    end process;

end arch_inversor_temporizado;