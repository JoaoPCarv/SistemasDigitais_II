-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

library IEEE;
use IEEE.numeric_bit.ALL;

library std;
use std.textio.all;

-- Entidade fornecida --
entity rom_arquivo_generica is
       generic(
	   addressSize : natural := 5;
	   wordSize    : natural := 8;
	   datFileName : string  := "conteudo_rom_ativ_02_carga.dat"
	   );
	   port(
	   addr: in  bit_vector(addressSize - 1 downto 0);
	   data: out bit_vector(wordSize    - 1 downto 0)
	   );
end rom_arquivo_generica;

architecture arch_arquivo_generic of rom_arquivo_generica is

-- Definição de memória com valores genéricos --
type mem_tipo is array(0 to 2**addressSize - 1) of bit_vector(wordSize - 1 downto 0);

-- Função de inicialização da memória com tamanho da aplavra genérico --
impure function init_mem(mem_arquivo_nome: in string) return mem_tipo is

  file     mem_arquivo: text open read_mode is mem_arquivo_nome;
  variable mem_linha: line;
  variable temp_bitv: bit_vector(wordSize - 1 downto 0);
  variable returnmem: mem_tipo;
  
  begin
  
  for i in mem_tipo'range loop
  
    readline(mem_arquivo, mem_linha);
	read(mem_linha, temp_bitv);
	returnmem(i) := temp_bitv;
  
  end loop;
  
  return returnmem;

end function;

-- Instanciação da memória com arquivo genérico --
signal mem: mem_tipo := init_mem(datFileName);

begin 

  data <= mem(to_integer(unsigned(addr)));


end arch_arquivo_generic;