-- Autor: João Pedro Lima Affonso de Carvalho, Poli-USP, NUSP: 11260846 --

library IEEE;
use IEEE.numeric_bit.ALL;

-- Entidade fornecida --

entity rom_simples is
       port(
	   addr: in  bit_vector(4 downto 0);
	   data: out bit_vector(7 downto 0)
	   );
end rom_simples;

architecture arch_rom_simples of rom_simples is

signal dec: integer;

  begin 
  
  dec <= to_integer(unsigned(addr));
  
  with dec select data <=
                          "00000000" when  0,
						  "00000011" when  1,
						  "11000000" when  2,
						  "00001100" when  3, 
						  "00110000" when  4,
						  "01010101" when  5,
						  "10101010" when  6,
						  "11111111" when  7,
						  "11100000" when  8,
						  "11100111" when  9,
						  "00000111" when 10,
						  "00011000" when 11,
						  "11000011" when 12,
						  "00111100" when 13,
						  "11110000" when 14,
						  "00001111" when 15,
						  "11101101" when 16,
						  "10001010" when 17,
						  "00100100" when 18,
						  "01010101" when 19,
						  "01001100" when 20,
						  "01000100" when 21,
						  "01110011" when 22,
						  "01011101" when 23,
						  "11100101" when 24,
						  "01111001" when 25,
						  "01010000" when 26,
						  "01000011" when 27,
						  "01010011" when 28,
						  "10110000" when 29,
						  "11011110" when 30,
						  "00110001" when 31,
						  "00000000" when others;


end arch_rom_simples;