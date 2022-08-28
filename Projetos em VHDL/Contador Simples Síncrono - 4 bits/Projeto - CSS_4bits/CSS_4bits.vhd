-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

--Lista de Componentes: --

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

-----------------------------------------------------------------------------

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

-----------------------------------------------------------------------------

-- Somador completo síncrono de 4 bits --
entity somador_completo_sincrono_4bits is
       port(
	   enable: in bit;
	   add1: in bit_vector(3 downto 0);
	   add2: in bit_vector(3 downto 0);
	   carry_in: in bit;
	   result: out bit_vector(3 downto 0);
	   carry_out: out bit
	   );
end somador_completo_sincrono_4bits;

architecture arch_somador_sincrono_4bits of somador_completo_sincrono_4bits is

component somador_completo_sincrono_1bit is
       port(
	   enable: in bit;
	   add1: in bit;
	   add2: in bit;
	   carry_in: in bit;
	   result: out bit;
	   carry_out: out bit
	   );
end component;

signal c_out0_s, c_out1_s, c_out2_s: bit;

  begin
  soma0: somador_completo_sincrono_1bit port map(enable, add1(0), add2(0), carry_in, result(0), c_out0_s);
  soma1: somador_completo_sincrono_1bit port map(enable, add1(1), add2(1), c_out0_s, result(1), c_out1_s);
  soma2: somador_completo_sincrono_1bit port map(enable, add1(2), add2(2), c_out1_s, result(2), c_out2_s);
  soma3: somador_completo_sincrono_1bit port map(enable, add1(3), add2(3), c_out2_s, result(3), carry_out);

end arch_somador_sincrono_4bits;

----------------------------------------------------------------------------------------------------------

-- Unidade de Controle do CSS-4bits --

entity Contador_Simples_Sincrono_UC is
       port(
	   clock: in bit;
	   reset: in bit;
	   enable_s: out bit;
	   enable_n: out bit;
	   enable_c: out bit
	   );
end Contador_Simples_Sincrono_UC;

architecture arch_Contador_Simples_Sincrono_UC of Contador_Simples_Sincrono_UC is
type estado is(inicial, somador, atualizador, mostrador);
signal atual, proximo: estado;

  begin
  
  controlar: process(clock, reset)
    begin
	  if(clock'event and clock = '1') then
	   if(reset = '1') then atual <= inicial;
	    else atual <= proximo;
	   end if;
	  end if;
  end process;
  
  proximo <= somador     when (atual = inicial or atual = atualizador) else
			 atualizador when (atual = somador);
			 
  enable_s <= '1' when (atual = somador) else '0';		 
  enable_n <= '1' when (atual = atualizador) else '0';
  enable_c <= '1' when (atual = atualizador) else '0';
  
end arch_Contador_Simples_Sincrono_UC;

--------------------------------------------------------------------------------------

-- FLuxo de Dados do CSS-4bits --

entity Contador_Simples_Sincrono_FD is
       port(
	   clock: in bit;
	   reset: in bit;
	   enable_s: in bit;
	   enable_n: in bit;
	   enable_c: in bit;
	   saida: out bit_vector(3 downto 0)
	   );
end Contador_Simples_Sincrono_FD;

architecture arch_Contador_Simples_Sincrono_FD of Contador_Simples_Sincrono_FD is

component registrador_4bits is 
       port(
	   clock, reset, enable: in bit;
	   entrada: in bit_vector(3 downto 0);
	   saida: out bit_vector(3 downto 0)
	   );
end component;

component somador_completo_sincrono_4bits is
       port(
	   enable: in bit;
	   add1: in bit_vector(3 downto 0);
	   add2: in bit_vector(3 downto 0);
	   carry_in: in bit;
	   result: out bit_vector(3 downto 0);
	   carry_out: out bit
	   );
end component;

signal soma_A_s, carry_A_s: bit_vector(3 downto 0);
signal soma_B_s, carry_B_s: bit_vector(3 downto 0);

  begin
  
  regCarry: registrador_4bits port map(clock, reset, enable_c, carry_B_s, carry_A_s);
  regAdder: registrador_4bits port map(clock, reset, enable_n, soma_B_s, soma_A_s);
  
  somador:  somador_completo_sincrono_4bits port map(enable_s, soma_A_s, "0001", carry_A_s(0), soma_B_s, carry_B_s(0));
  
  saida <= soma_A_s;

end arch_Contador_Simples_Sincrono_FD;

--------------------------------------------------------------------------------------

-- Projeto Final --

entity CSS_4bits is 
       port(
	   clock: in bit;
	   reset: in bit;
	   saida: out bit_vector(3 downto 0)
	   );
end CSS_4bits;

architecture arch_CSS_4bits of CSS_4bits is

component Contador_Simples_Sincrono_UC is
       port(
	   clock: in bit;
	   reset: in bit;
	   enable_s: out bit;
	   enable_n: out bit;
	   enable_c: out bit
	   );
end component;

component Contador_Simples_Sincrono_FD is
       port(
	   clock: in bit;
	   reset: in bit;
	   enable_s: in bit;
	   enable_n: in bit;
	   enable_c: in bit;
	   saida: out bit_vector(3 downto 0)
	   );
end component;

signal enable_s_sig, enable_n_sig, enable_c_sig: bit;

  begin
  
  UC: Contador_Simples_Sincrono_UC port map(clock, reset, enable_s_sig, enable_n_sig, enable_c_sig);
  FD: Contador_Simples_Sincrono_FD port map(clock, reset, enable_s_sig, enable_n_sig, enable_c_sig, saida);

end arch_CSS_4bits;

