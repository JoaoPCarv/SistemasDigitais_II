library ieee;
use ieee.numeric_bit.all;

entity turbo is
       port (
       clock:  in bit;
	   reset:  in bit; 
       button: in bit_vector(7 downto 0); 
       sensib: in bit_vector(3 downto 0); 
       cmd:    out bit_vector(7 downto 0) 
);
end entity;

architecture main of turbo is

component turboUC is
       port(
	   clock:      in  bit;
	   reset:      in  bit;
	   pushedB:    in  bit;
	   comp1:      in  bit;
	   comp2:      in  bit;
	   gtoe:       in  bit;
	   enableCmd:  out bit;
	   resetCount: out bit;
	   enableReg:  out bit;
	   enCount:    out bit
	   );
end component;

component turboFD is
       port(
	   clock:      in  bit;
	   reset:      in  bit;
	   enableCmd:  in  bit;
	   resetCount: in  bit;
	   enableReg:  in  bit;
	   enCount:    in  bit;
	   button:     in  bit_vector(7 downto 0);
	   sensib:     in  bit_vector(3 downto 0);
	   cmd:        out bit_vector(7 downto 0);
	   pushedB:    out bit;
	   comp1:      out bit;
	   comp2:      out bit;
	   gtoe:       out bit
	   );
end component;

signal enableCmdS, resetCountS, enableRegS, enCountS, pushedBS, comp1S, comp2S, gtoeS: bit;

begin

UCFlag: turboUC port map(clock, reset, pushedBS, comp1S, comp2S, gtoeS, enableCmdS, resetCountS, enableRegS, enCountS);

FDFlag: turboFD port map(clock, reset, enableCmdS, resetCountS, enableRegS, enCountS, button, sensib, cmd, pushedBS, comp1S, comp2S, gtoeS);


end main;
--------------------------     U.C     -------------------------- 
library ieee;
use ieee.numeric_bit.all;

entity turboUC is
       port(
	   clock:      in  bit;
	   reset:      in  bit;
	   pushedB:    in  bit;
	   comp1:      in  bit;
	   comp2:      in  bit;
	   gtoe:       in  bit;
	   enableCmd:  out bit;
	   resetCount: out bit;
	   enableReg:  out bit;
	   enCount:    out bit
	   );
end turboUC;

architecture unidadeControle of turboUC is

type estado is (idle, pushed, hold, turbo);
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

proximo <= idle   when (pushedB = '0' and (atual = idle or (atual = pushed and comp1 = '0') or (atual = hold and comp2 = '0'))) else
           pushed when (pushedB = '1' and (atual = idle or (atual = pushed and comp1 = '0') or (atual = hold and comp2 = '0'))) else
		   hold   when (pushedB = '1' and comp1  = '1' and atual = pushed) else
		   hold   when (pushedB = '1' and comp2  = '1' and gtoe  = '0' and atual = hold) else 
		   turbo  when (pushedB = '1' and comp2  = '1' and gtoe  = '1' and atual = hold);

enableCmd  <= '1' when (atual = pushed or atual = turbo) else '0';
resetCount <= '1' when (atual = pushed) else '0';
enableReg  <= '1' when (atual = pushed) else '0';
enCount    <= '1' when (atual = hold)   else '0';

end unidadeControle;
	   
-------------------------- COMPONENTES --------------------------                  
library ieee;
use ieee.numeric_bit.all;

entity counter is
       port(
	   clock, reset, regis, cont: in bit;
	   A: in  bit_vector(3 downto 0);
	   i: out bit_vector(3 downto 0)
	   );
end counter;

architecture archCounter of counter is
signal conta: bit_vector(3 downto 0);

begin 

contar: process(clock, reset)
begin
     if (reset = '1') then conta <= "0000";
	  elsif (clock'event and clock = '0') then
   	   if (regis = '1') then conta <= A; end if;
	   if (cont = '1')  then conta <= bit_vector(unsigned(conta) + 1); end if;
	 end if;

end process contar;
i <= conta;
end archCounter;
-----------------------------------------------------------------
library ieee;
use ieee.numeric_bit.all;

entity push is
       port(
	   A: in  bit_vector(7 downto 0);
	   B: out bit
	   );
end push;

architecture archPush of push is
begin

B <= A(7) or A(6) or A(5) or A(4) or A(3) or A(2) or A(1) or A(0);

end archPush;
-----------------------------------------------------------------
library ieee;
use ieee.numeric_bit.all;

entity comp4 is
       port(
	   A: in  bit_vector(3 downto 0);
	   B: in  bit_vector(3 downto 0);
	   C: out bit
	   );
end comp4;

architecture archComp4 of comp4 is
begin

C <= '0' when ((A(3) = '0' and B(3) = '1') or 
			   (A(2) = '0' and B(2) = '1') or
			   (A(1) = '0' and B(1) = '1') or 
			   (A(0) = '0' and B(0) = '1')) else '1';

end archComp4;

-----------------------------------------------------------------
library ieee;
use ieee.numeric_bit.all;

entity comp8 is
       port(
	   A: in  bit_vector(7 downto 0);
	   B: in  bit_vector(7 downto 0);
	   C: out bit
	   );
end comp8;

architecture archComp8 of comp8 is
begin

C <= '1' when (A = B) else '0';

end archComp8;
-----------------------------------------------------------------
library ieee;
use ieee.numeric_bit.all;

entity registrador is
       port(
	   clock, reset, regis: in bit;
	   A: in  bit_vector(7 downto 0);
	   B: out bit_vector(7 downto 0)
	   );
end registrador;

architecture archReg of registrador is
signal saida: bit_vector(7 downto 0);

begin

registro: process(clock, reset)
begin 
     
	 if(reset = '1') then saida <= "00000000";
	  elsif(clock'event and clock = '0') then 
	   if (regis = '1') then saida <= A;
	   end if;
	 end if; 
end process registro;

B <= saida;

end archReg;
-----------------------------------------------------------------
library ieee;
use ieee.numeric_bit.all;

entity mux is
       port(
	   A:   in  bit_vector(7 downto 0);
	   sel: in  bit;
	   B:   out bit_vector(7 downto 0)
	   );
end mux;

architecture archMux of mux is

begin

with sel select 
     B <= A          when '1',
	      "00000000" when others;
	 

end archMux;
--------------------------     F.D     -------------------------- 
library ieee;
use ieee.numeric_bit.all;

entity turboFD is
       port(
	   clock:      in  bit;
	   reset:      in  bit;
	   enableCmd:  in  bit;
	   resetCount: in  bit;
	   enableReg:  in  bit;
	   enCount:    in  bit;
	   button:     in  bit_vector(7 downto 0);
	   sensib:     in  bit_vector(3 downto 0);
	   cmd:        out bit_vector(7 downto 0);
	   pushedB:    out bit;
	   comp1:      out bit;
	   comp2:      out bit;
	   gtoe:       out bit
	   );
end turboFD;

architecture fluxoDados of turboFD is

component push is
       port(
	   A: in  bit_vector(7 downto 0);
	   B: out bit
	   );
end component;

component counter is
       port(
	   clock, reset, regis, cont: in bit;
	   A: in  bit_vector(3 downto 0);
	   i: out bit_vector(3 downto 0)
	   );
end component;

component comp4 is
       port(
	   A: in  bit_vector(3 downto 0);
	   B: in  bit_vector(3 downto 0);
	   C: out bit
	   );
end component;

component comp8 is
       port(
	   A: in  bit_vector(7 downto 0);
	   B: in  bit_vector(7 downto 0);
	   C: out bit
	   );
end component;

component registrador is
       port(
	   clock, reset, regis: in bit;
	   A: in  bit_vector(7 downto 0);
	   B: out bit_vector(7 downto 0)
	   );
end component;

component mux is
       port(
	   A:   in  bit_vector(7 downto 0);
	   sel: in  bit;
	   B:   out bit_vector(7 downto 0)
	   );
end component;

signal reg:   bit_vector(7 downto 0);
signal count: bit_vector(3 downto 0);

begin

pushedFlag: push        port map(button, pushedB);

comp1Flag:  comp8       port map(button, reg, comp1);

comp2Flag:  comp8       port map(button, reg, comp2);
 
sensibFlag: comp4       port map(count, sensib, gtoe);

resetFlag:  mux         port map(reg, enableCmd, cmd);

regFlag:    registrador port map(clock, reset, enableReg, button, reg);

countFlag: counter      port map(clock, reset, resetCount, enCount, count);

end fluxoDados;