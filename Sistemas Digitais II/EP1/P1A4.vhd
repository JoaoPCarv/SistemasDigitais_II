-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

library IEEE;
use IEEE.numeric_bit.ALL;

-- Entidade fornecida --
entity ram is
       generic(
	   addressSize: natural := 5;
	   wordSize   : natural := 8
	   );
	   port(
	   ck, wr : in  bit;
	   addr   : in  bit_vector(addressSize - 1 downto 0);
	   data_i : in  bit_vector(wordSize - 1 downto 0);
	   data_o : out bit_vector(wordSize - 1 downto 0)
	   );
end ram;

architecture arch_ram of ram is

-- Definição de memória com valores genéricos --
type mem_tipo is array(0 to 2**addressSize - 1) of bit_vector(wordSize - 1 downto 0);

signal mem_temp: bit_vector(wordSize - 1 downto 0);
signal mem: mem_tipo;

  begin
  
  mem_temp <= mem(to_integer(unsigned(addr)));
  
  escrita: process(ck, wr) is
    begin
	
	if(ck'event and ck = '1') then 
	  if(wr = '1') then mem(to_integer(unsigned(addr))) <= data_i;
	  end if;
	end if;
	
  end process;
  
  data_o <= mem_temp;
  

end arch_ram;