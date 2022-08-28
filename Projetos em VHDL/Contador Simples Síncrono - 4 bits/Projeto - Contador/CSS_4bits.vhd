-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

-- Lista de Componentes --

-- Somador Completo de 1 bit --
entity somador_completo_1bit is
       port(
	   add1: in bit;
	   add2: in bit;
	   carry_in: in bit;
	   result: out bit;
	   carry_out: out bit
	   );
end somador_completo_1bit;

architecture arch_somador_completo_1bit of somador_completo_1bit is
  begin 
  
	 result <= (add1) xor (add2) xor (carry_in);
     carry_out <= (add1 and add2) or (add1 and carry_in) or (add2 and carry_in);

	

end arch_somador_completo_1bit;
-------------------------------

-- Registrador Interno --
entity registrador_interno is
       port(
	   enable: in bit;
	   reg_in: in bit_vector(3 downto 0);
	   reg_out: out bit_vector(3 downto 0)
	   );

end registrador_interno;

architecture arch_registrador_interno of registrador_interno is

  begin
  
  load: process(enable)
  begin
  
  if(enable = '1') then reg_out <= reg_in;
  end if;
  
  end process;

end arch_registrador_interno;

-----------------------------------------------------------------------------

-- Somador Completo de 4 bits (com Enable) --
entity somador_completo_4bits_enable is
       port(
	   enable: in bit;
	   add1: in bit_vector(3 downto 0);
	   add2: in bit_vector(3 downto 0);
	   carry_in: in bit;
	   result: out bit_vector(3 downto 0);
	   carry_out: out bit
	   );
end somador_completo_4bits_enable;

architecture arch_somador_completo_4bits_enable of somador_completo_4bits_enable is

component somador_completo_1bit is
       port(
	   add1: in bit;
	   add2: in bit;
	   carry_in: in bit;
	   result: out bit;
	   carry_out: out bit
	   );
end component;

component registrador_interno is
       port(
	   enable: in bit;
	   reg_in: in bit_vector(3 downto 0);
	   reg_out: out bit_vector(3 downto 0)
	   );

end component;


signal c_out0_s, c_out1_s, c_out2_s, c_out3_s: bit;
signal add1_s, add2_s, carry_in_s1, carry_in_s2: bit_vector(3 downto 0);

  begin
  
  carry_in_s1 <= "000"& carry_in; 
  
  reg1:     registrador_interno port map(enable, add1, add1_s);
  reg2:     registrador_interno port map(enable, add2, add2_s);
  regCarry: registrador_interno port map(enable, carry_in_s1, carry_in_s2);

  
  soma0: somador_completo_1bit port map(add1_s(0), add2_s(0), carry_in_s2(0), result(0), c_out0_s);
  soma1: somador_completo_1bit port map(add1_s(1), add2_s(1), c_out0_s, result(1), c_out1_s);
  soma2: somador_completo_1bit port map(add1_s(2), add2_s(2), c_out1_s, result(2), c_out2_s);
  soma3: somador_completo_1bit port map(add1_s(3), add2_s(3), c_out2_s, result(3), carry_out);


end arch_somador_completo_4bits_enable;

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
---------------------------

-- Unidade de Controle do Contador Simples Síncrono - 4 bits --

entity Contador_Simples_Sincrono_4bits_UC is
       port(
	   clock: in bit;
	   reset: in bit;
	   enable_s: out bit;
	   enable_n: out bit;
	   enable_c: out bit
	   );
end Contador_Simples_Sincrono_4bits_UC;

architecture arch_Contador_Simples_Sincrono_4bits_UC of Contador_Simples_Sincrono_4bits_UC is
type estado is(inicial, somador, atualizador, mostrador);
signal atual, proximo: estado;

  begin
  
  controlar: process(clock, reset)
    begin
	  if (reset = '1') then atual <= inicial;
	   elsif (clock'event and clock = '1') then atual <= proximo;
	  end if;
  end process;
  
  proximo <= somador     when (atual = inicial or atual = atualizador) else
			 atualizador when (atual = somador);
			 
  enable_s <= '1' when (atual = somador) else '0';		 
  enable_n <= '1' when (atual = atualizador) else '0';
  enable_c <= '1' when (atual = atualizador) else '0';
  
end arch_Contador_Simples_Sincrono_4bits_UC;

------------------------------------------------------------------------------

-- Fluxo de Dados do do Contador Simples Síncrono - 4 bits --

entity Contador_Simples_Sincrono_4bits_FD is
       port(
	   clock: in bit;
	   reset: in bit;
	   enable_s: in bit;
	   enable_n: in bit;
	   enable_c: in bit;
	   saida: out bit_vector(3 downto 0)
	   );
end Contador_Simples_Sincrono_4bits_FD;

architecture arch_Contador_Simples_Sincrono_4bits_FD of Contador_Simples_Sincrono_4bits_FD is

component registrador_4bits is 
       port(
	   clock, reset, enable: in bit;
	   entrada: in bit_vector(3 downto 0);
	   saida: out bit_vector(3 downto 0)
	   );
end component;

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

signal RegNum_in, RegNum_out, RegCarry_in, RegCarry_out: bit_vector(3 downto 0);

  begin
  
  regCarry: registrador_4bits port map(clock, reset, enable_c, RegCarry_in, RegCarry_out);
  regNum:   registrador_4bits port map(clock, reset, enable_n, RegNum_in, RegNum_out);
  
  somador:  somador_completo_4bits_enable port map(enable_s, RegNum_out, "0001", RegCarry_out(0), RegNum_in, RegCarry_in(0));
  
  saida <= RegNum_out;

end arch_Contador_Simples_Sincrono_4bits_FD;

--------------------------------------------------------------------------------------

-- Projeto Final - Contador Simples Síncrono - 4 bits --

entity CSS_4bits is 
       port(
	   clock: in bit;
	   reset: in bit;
	   saida: out bit_vector(3 downto 0)
	   );
end CSS_4bits;

architecture arch_CSS_4bits of CSS_4bits is

component Contador_Simples_Sincrono_4bits_UC is
       port(
	   clock: in bit;
	   reset: in bit;
	   enable_s: out bit;
	   enable_n: out bit;
	   enable_c: out bit
	   );
end component;

component Contador_Simples_Sincrono_4bits_FD is
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
  
  UC: Contador_Simples_Sincrono_4bits_UC port map(clock, reset, enable_s_sig, enable_n_sig, enable_c_sig);
  FD: Contador_Simples_Sincrono_4bits_FD port map(clock, reset, enable_s_sig, enable_n_sig, enable_c_sig, saida);

end arch_CSS_4bits;
