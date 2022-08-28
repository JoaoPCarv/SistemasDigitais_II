-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

-- Registrador de 4 bits --
entity registrador_4bits is 
       port(
	   clock, reset, enable: in bit;
	   entrada: in bit_vector(3 downto 0);
	   saida: out bit_vector(3 downto 0)
	   );
end registrador_4bits;

architecture arch_registrador_4bits of registrador_4bits is
  begin
  
  load: process(clock, reset)
  begin
    if (reset = '1') then saida <= "0000";
     elsif (clock'event and clock = '1') then
      if(enable = '1') then saida <= entrada; 
	  end if;
    end if;	
	
  end process;
  
end arch_registrador_4bits;