-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

-- Somador completo síncrono de 1 bit --

entity somador_completo_sincrono_1bit is
       port(
	   enable: in bit;
	   add1: in bit;
	   add2: in bit;
	   carry_in: in bit;
	   result: out bit;
	   carry_out: out bit
	   );
end somador_completo_sincrono_1bit;

architecture arch_somador_sincrono_1bit of somador_completo_sincrono_1bit is
  begin 
  
  somar: process(enable)
    begin
	
	if(enable = '1') then 
	 result <= (add1) xor (add2) xor (carry_in);
     carry_out <= (add1 and add2) or (add1 and carry_in) or (add2 and carry_in);
	end if;
	
  end process;

end arch_somador_sincrono_1bit;

