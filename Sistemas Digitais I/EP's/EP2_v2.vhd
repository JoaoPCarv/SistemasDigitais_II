library ieee;
use ieee.numeric_bit.all;

entity log2 is
       port(
	   clock, reset: in  bit;
	   start:        in  bit;
	   ready:        out bit;
	   N:            in  bit_vector(7 downto 0);
	   logval:       out bit_vector(3 downto 0)
	   );
end log2;

architecture main of log2 is

component log2UC is
      port(
	  clock, reset: in  bit;
	  start:        in  bit;
	  zero:         in  bit;
	  up:           out bit;
	  load0:        out bit;
	  ready:        out bit
	  );
end component;

component log2FD is
       port (
	   clock, reset: in  bit;
	   up:           in  bit;
	   load0:        in  bit;
	   N:            in  bit_vector(7 downto 0);
	   logval:       out bit_vector(3 downto 0);
	   zero:         out bit
	   );
end component;

signal zeroM: bit;
signal load0, updateM: bit;

begin

UC: log2UC port map(clock, reset, start, zeroM, updateM, load0, ready);

FD: log2FD port map(clock, reset, updateM, load0, N, logval, zeroM);

end main;
--------------------------     U.C     -------------------------- 
library ieee;
use ieee.numeric_bit.all;

entity log2UC is
       port(
	   clock, reset: in  bit;
	   start:        in  bit;
	   zero:         in  bit;
	   up:           out bit;
	   load0:        out bit;
	   ready:        out bit
	   );
end log2UC;

architecture unidadeControle of log2UC is

type estado is (idle, init, update);
signal atual, proximo: estado;

begin

controlar: process(clock, reset)
begin
     if (clock'event and clock = '1') then
	  if(reset = '1') then atual <= idle; 
	   else atual <= proximo;
	  end if;
	 end if;
end process controlar;

proximo <= idle   when (atual = idle and start = '0') else
           init   when (atual = idle and start = '1') else
		   idle   when (zero = '1' and atual = init)  else
		   update when (zero = '0' and atual = init)  else
		   update when (zero = '0' and atual = update);
           
ready  <= '1' when (atual = idle)   else '0';
up     <= '1' when (atual = update) else '0';
load0  <= '1' when (atual = init)   else '0';

end unidadeControle;
-------------------------- COMPONENTES --------------------------                  
library ieee;
use ieee.numeric_bit.all;

entity detec0 is
       port(
	   N: in bit_vector(7 downto 0);
	   F: out bit
	   );
end detec0;

architecture detectar of detec0 is
begin

F <= '1' when (N = "00000000") else '0';

end detectar;
-----------------------------------------------------------------
library ieee;
use ieee.numeric_bit.all;

entity regEdes is
       port(
	   clock, reset, regis, des: in bit;
	   A: in  bit_vector(7 downto 0);
	   B: out bit_vector(7 downto 0)
	   );
end regEdes;

architecture regArch of regEdes is
signal saida: bit_vector(7 downto 0);

begin

funcao: process(clock, reset) 
begin
      if (reset = '1') then B <= "00000000";
	   elsif (clock'event and clock = '0') then 
	    if (regis = '1') then saida <= A; end if;
		 if (des = '1') then 
		 
		  saida(0) <= saida(1);
		  saida(1) <= saida(2);
		  saida(2) <= saida(3);
		  saida(3) <= saida(4);
		  saida(4) <= saida(5);
		  saida(5) <= saida(6);
		  saida(6) <= saida(7);
		  saida(7) <= '0';
		
		 end if; 
		 B <= saida;
	  end if;	 
end process funcao;



end regArch;
-----------------------------------------------------------------
library ieee;
use ieee.numeric_bit.all;

entity contador is
       port(
	   clock, reset, regis, cont: in bit;
	   A: in bit_vector(3 downto 0);
	   i: out bit_vector(3 downto 0)
	   );
end contador;

architecture contagem of contador is
signal conta: unsigned(3 downto 0);

begin 

contar: process(clock, reset)
begin
     if (reset = '1') then i <= "1111";
	  elsif (clock'event and clock = '0') then
   	   if (regis = '1') then conta <= unsigned(A); end if;
	   if (cont = '1')  then conta <= conta + 1; end if;
	    i <= bit_vector(conta);
	 end if;

end process contar;

end contagem;
--------------------------     F.D     -------------------------- 
library ieee;
use ieee.numeric_bit.all;

entity log2FD is
       port (
	   clock, reset: in  bit;
	   up:           in  bit;
	   load0:        in  bit;
	   N:            in  bit_vector(7 downto 0);
	   logval:       out bit_vector(3 downto 0);
	   zero:         out bit
	   );
end log2FD;

architecture fluxoDados of log2FD is

component detec0 is
       port(
	   N: in bit_vector(7 downto 0);
	   F: out bit
	   );
end component;

component regEdes is
       port(
	   clock, reset, regis, des: in bit;
	   A: in  bit_vector(7 downto 0);
	   B: out bit_vector(7 downto 0)
	   );
end component;

component contador is
       port(
	   clock, reset, regis, cont: in bit;
	   A: in bit_vector(3 downto 0);
	   i: out bit_vector(3 downto 0)
	   );
  
end component;

signal zeroD: bit;
signal loadA, loadP: bit_vector(7 downto 0);
signal logA,  logP: bit_vector(3 downto 0);

begin

regini: regEdes  port map(clock, reset, load0, '0', N, loadA);
logini: contador port map(clock, reset, load0, '0', "1111", logA);

regdes: regEdes  port map(clock, reset, up, up, loadA, loadP);
logcon: contador port map(clock, reset, up, up, logA, logP);

detec:  detec0   port map(loadP, zeroD);

zero <= zeroD;

logval <= logP when (zeroD = '1');


end fluxoDados;