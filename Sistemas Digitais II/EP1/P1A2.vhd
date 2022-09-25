-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

library IEEE;
use IEEE.numeric_bit.ALL;

library std;
use std.textio.all;

-- Entidade fornecida --
entity rom_arquivo is
       port(
	   addr: in  bit_vector(4 downto 0);
	   data: out bit_vector(7 downto 0)
	   );
end rom_arquivo;

architecture arch_rom_arquivo of rom_arquivo is

-- Definição de memória --
type mem_tipo is array(0 to 31) of bit_vector(7 downto 0);

-- Função de inicialização da memória --
impure function init_mem(mem_arquivo_nome: in string) return mem_tipo is

  file     mem_arquivo: text open read_mode is mem_arquivo_nome;
  variable mem_linha: line;
  variable temp_bitv: bit_vector(7 downto 0);
  variable returnmem: mem_tipo;
  
  begin
  
  for i in mem_tipo'range loop
  
    readline(mem_arquivo, mem_linha);
	read(mem_linha, temp_bitv);
	returnmem(i) := temp_bitv;
  
  end loop;
  
  return returnmem;

end function;

signal mem: mem_tipo := init_mem("conteudo_rom_ativ_02_carga.dat");

begin 

  data <= mem(to_integer(unsigned(addr)));
  
end arch_rom_arquivo;